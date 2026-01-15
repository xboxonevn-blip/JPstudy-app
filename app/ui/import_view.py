from __future__ import annotations
import sqlite3
import csv
import os
import random
from typing import Callable, Optional, List, Tuple
from dataclasses import dataclass, field

from PySide6.QtWidgets import (
    QWidget,
    QVBoxLayout,
    QLabel,
    QPushButton,
    QFileDialog,
    QHBoxLayout,
    QTableWidget,
    QTableWidgetItem,
    QMessageBox,
    QLineEdit,
    QComboBox,
    QTextEdit,
    QDialog,
    QDialogButtonBox,
    QProgressDialog,
)
from PySide6.QtCore import Qt, QThread, QObject, Signal

from app.db.repo import create_item_with_card, count_items, get_items_by_ids, build_cloze_preview
from app.db.database import new_db_connection, init_db


@dataclass
class ImportResult:
    imported: int = 0
    errors: int = 0
    skipped: int = 0  # duplicates merged/skipped
    new_ids: List[int] = field(default_factory=list)
    error_rows: List[str] = field(default_factory=list)
    duplicate_rows: List[str] = field(default_factory=list)
    warning_rows: List[str] = field(default_factory=list)  # e.g., cloze fallback


class AddItemDialog(QDialog):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("Thêm mục mới (A - Nạp)")
        self.resize(520, 420)

        layout = QVBoxLayout(self)

        row1 = QHBoxLayout()
        self.cb_type = QComboBox()
        self.cb_type.addItems(["vocab", "kanji", "grammar"])
        self.ed_term = QLineEdit()
        self.ed_term.setPlaceholderText("term (từ/kanji/mẫu)")
        row1.addWidget(QLabel("Loại:"))
        row1.addWidget(self.cb_type, 1)
        row1.addWidget(QLabel("Term:"))
        row1.addWidget(self.ed_term, 2)
        layout.addLayout(row1)

        row2 = QHBoxLayout()
        self.ed_reading = QLineEdit()
        self.ed_reading.setPlaceholderText("reading (kana) có thể để trống")
        self.ed_tags = QLineEdit()
        self.ed_tags.setPlaceholderText("tags: N4, food, ...")
        row2.addWidget(QLabel("Reading:"))
        row2.addWidget(self.ed_reading, 2)
        row2.addWidget(QLabel("Tags:"))
        row2.addWidget(self.ed_tags, 2)
        layout.addLayout(row2)

        self.ed_meaning = QLineEdit()
        self.ed_meaning.setPlaceholderText("meaning (nghĩa Tiếng Việt)")
        layout.addWidget(QLabel("Meaning:"))
        layout.addWidget(self.ed_meaning)

        self.ed_example = QTextEdit()
        self.ed_example.setPlaceholderText("example sentence (câu ví dụ) nên có để luyện C sau này")
        layout.addWidget(QLabel("Example:"))
        layout.addWidget(self.ed_example, 1)

        btns = QDialogButtonBox(QDialogButtonBox.Cancel | QDialogButtonBox.Ok)
        btns.accepted.connect(self.accept)
        btns.rejected.connect(self.reject)
        layout.addWidget(btns)

    def data(self) -> dict:
        return {
            "item_type": self.cb_type.currentText().strip(),
            "term": self.ed_term.text().strip(),
            "reading": self.ed_reading.text().strip(),
            "meaning": self.ed_meaning.text().strip(),
            "example": self.ed_example.toPlainText().strip(),
            "tags": self.ed_tags.text().strip(),
        }


class QuickQuizDialog(QDialog):
    def __init__(self, items: List[sqlite3.Row], parent=None):
        super().__init__(parent)
        self.items = list(items)
        random.shuffle(self.items)
        self.index = 0
        self.correct = 0
        self.revealed = False

        self.setWindowTitle("Quick Quiz (10)")
        self.resize(520, 360)

        layout = QVBoxLayout(self)
        self.lbl_status = QLabel("")
        layout.addWidget(self.lbl_status)

        self.lbl_front = QLabel("")
        self.lbl_front.setWordWrap(True)
        self.lbl_front.setStyleSheet("font-size: 18px; font-weight: 700;")
        layout.addWidget(self.lbl_front)

        self.ed_guess = QLineEdit()
        self.ed_guess.setPlaceholderText("Nhập thử nghĩa (optional)")
        layout.addWidget(self.ed_guess)

        self.lbl_back = QTextEdit()
        self.lbl_back.setReadOnly(True)
        layout.addWidget(self.lbl_back, 1)

        btn_row = QHBoxLayout()
        self.btn_reveal = QPushButton("Xem đáp án")
        self.btn_correct = QPushButton("Đúng")
        self.btn_wrong = QPushButton("Sai")
        self.btn_close = QPushButton("Đóng")
        for b in [self.btn_reveal, self.btn_correct, self.btn_wrong, self.btn_close]:
            b.setCursor(Qt.PointingHandCursor)
        self.btn_correct.setEnabled(False)
        self.btn_wrong.setEnabled(False)

        self.btn_reveal.clicked.connect(self.on_reveal)
        self.btn_correct.clicked.connect(lambda: self.mark_result(True))
        self.btn_wrong.clicked.connect(lambda: self.mark_result(False))
        self.btn_close.clicked.connect(self.reject)

        btn_row.addWidget(self.btn_reveal)
        btn_row.addWidget(self.btn_correct)
        btn_row.addWidget(self.btn_wrong)
        btn_row.addStretch(1)
        btn_row.addWidget(self.btn_close)
        layout.addLayout(btn_row)

        self.show_card()

    def show_card(self):
        if self.index >= len(self.items):
            self.lbl_status.setText(f"Done. Score: {self.correct}/{len(self.items)}")
            self.lbl_front.setText("")
            self.lbl_back.setPlainText("")
            self.btn_reveal.setEnabled(False)
            self.btn_correct.setEnabled(False)
            self.btn_wrong.setEnabled(False)
            return
        item = self.items[self.index]
        front = f"[{item['item_type']}] {item['term']}  {('(' + (item['reading'] or '') + ')') if item['reading'] else ''}"
        self.lbl_front.setText(front.strip())
        self.lbl_back.setPlainText("")
        self.lbl_status.setText(f"Card {self.index+1}/{len(self.items)} • Score: {self.correct}")
        self.ed_guess.clear()
        self.revealed = False
        self.btn_correct.setEnabled(False)
        self.btn_wrong.setEnabled(False)

    def on_reveal(self):
        if self.index >= len(self.items):
            return
        item = self.items[self.index]
        text = (
            f"Nghĩa: {item['meaning']}\n\n"
            f"Ví dụ: {item['example']}\n\n"
            f"Tags: {item['tags']}"
        )
        self.lbl_back.setPlainText(text)
        self.revealed = True
        self.btn_correct.setEnabled(True)
        self.btn_wrong.setEnabled(True)

    def mark_result(self, ok: bool):
        if not self.revealed:
            return
        if ok:
            self.correct += 1
        self.index += 1
        self.show_card()


class ImportWorker(QObject):
    progress = Signal(int, int, str)  # done, total, file name
    finished = Signal(ImportResult)
    error = Signal(str)

    def __init__(self, view: "ImportView", tasks: List[Tuple[str, Optional[str]]]):
        super().__init__()
        self.view = view
        self.tasks = tasks
        self._stop = False

    def stop(self):
        self._stop = True

    def _count_rows(self, path: str) -> int:
        try:
            with open(path, "r", encoding="utf-8-sig") as f:
                return max(0, sum(1 for _ in f) - 1)
        except Exception:
            return 0

    def run(self):
        try:
            db = new_db_connection()
            init_db(db)
            total_rows = sum(self._count_rows(p) for p, _ in self.tasks)
            total_rows = total_rows if total_rows > 0 else 1
            processed = 0
            agg = ImportResult()

            for path, level_tag in self.tasks:
                rows_in_file = max(1, self._count_rows(path))

                def progress_cb(done_file: int, total_file: int):
                    if self._stop:
                        raise RuntimeError("cancelled")
                    self.progress.emit(processed + done_file, total_rows, os.path.basename(path))

                result = self.view._import_csv(
                    path,
                    level_tag=level_tag,
                    progress_cb=progress_cb,
                    db_conn=db,
                    total_rows_hint=rows_in_file,
                )
                processed += rows_in_file
                agg.imported += result.imported
                agg.errors += result.errors
                agg.skipped += result.skipped
                agg.new_ids.extend(result.new_ids)
                agg.error_rows.extend(result.error_rows)
                agg.duplicate_rows.extend(result.duplicate_rows)
                agg.warning_rows.extend(result.warning_rows)

            self.finished.emit(agg)
        except Exception as e:
            self.error.emit(str(e))


class ImportView(QWidget):
    def __init__(self, db: sqlite3.Connection, on_navigate: Callable[[str], None]):
        super().__init__()
        self.db = db
        self.on_navigate = on_navigate
        self.data_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "data"))

        self._pending_missing: List[str] = []
        self._import_mode = "manual"

        layout = QVBoxLayout(self)
        layout.setSpacing(10)

        title = QLabel("A - Nạp (Import CSV / Thêm thẻ)")
        title.setStyleSheet("font-size: 16px; font-weight: 700;")
        layout.addWidget(title)

        self.info = QLabel("")
        self.info.setStyleSheet("color:#555;")
        layout.addWidget(self.info)

        actions = QHBoxLayout()
        self.btn_import = QPushButton("Import CSV")
        self.btn_auto_import = QPushButton("Auto Import")
        self.cb_level = QComboBox()
        self.cb_level.addItems(["N5", "N4", "N3", "N2", "N1", "All"])
        self.btn_add = QPushButton("Thêm thẻ")
        self.btn_back = QPushButton("Về Home")

        for b in [self.btn_import, self.btn_auto_import, self.btn_add, self.btn_back]:
            b.setCursor(Qt.PointingHandCursor)

        self.btn_import.clicked.connect(self.on_import_csv)
        self.btn_auto_import.clicked.connect(self.on_auto_import)
        self.btn_add.clicked.connect(self.on_add_item)
        self.btn_back.clicked.connect(lambda: self.on_navigate("home"))

        actions.addWidget(self.btn_import)
        actions.addWidget(self.btn_auto_import)
        actions.addWidget(QLabel("Level:"))
        actions.addWidget(self.cb_level)
        actions.addWidget(self.btn_add)
        actions.addStretch(1)
        actions.addWidget(self.btn_back)
        layout.addLayout(actions)

        self.table = QTableWidget(0, 6)
        self.table.setHorizontalHeaderLabels(["type", "term", "reading", "meaning", "example", "tags"])
        self.table.horizontalHeader().setStretchLastSection(True)
        self.table.setWordWrap(True)
        layout.addWidget(self.table, 1)

        self.refresh()

    def refresh(self) -> None:
        total = count_items(self.db)
        self.info.setText(f"Tổng mục hiện có: {total}. Import xong, thẻ SRS sẽ đến hạn ngay hôm nay.")
        cur = self.db.execute(
            """SELECT item_type, term, reading, meaning, example, tags
                 FROM items ORDER BY id DESC LIMIT 100"""
        )
        rows = list(cur.fetchall())
        self.table.setRowCount(len(rows))
        for r, row in enumerate(rows):
            for c, key in enumerate(["item_type", "term", "reading", "meaning", "example", "tags"]):
                item = QTableWidgetItem(str(row[key] if row[key] is not None else ""))
                item.setFlags(item.flags() ^ Qt.ItemIsEditable)
                self.table.setItem(r, c, item)

    def on_add_item(self):
        dlg = AddItemDialog(self)
        if dlg.exec() == QDialog.Accepted:
            data = dlg.data()
            if not data["term"] or not data["meaning"]:
                QMessageBox.warning(self, "Thiếu thông tin", "Cần nhập tối thiểu: term + meaning.")
                return
            _, created = create_item_with_card(
                self.db,
                item_type=data["item_type"],
                term=data["term"],
                reading=data["reading"],
                meaning=data["meaning"],
                example=data["example"],
                tags=data["tags"],
            )
            self.refresh()
            if created:
                QMessageBox.information(self, "OK", "Đã thêm mục và tạo thẻ SRS (đến hạn hôm nay).")
            else:
                QMessageBox.information(
                    self,
                    "Đã tồn tại",
                    "Term + reading đã tồn tại, đã merge tags/example và giữ thẻ cũ (đến hạn hôm nay).",
                )

    def _merge_tags(self, tags: str, level_tag: Optional[str]) -> str:
        tags = tags or ""
        parts = [t.strip() for t in tags.split(",") if t.strip()]
        if level_tag:
            level_upper = level_tag.upper()
            if level_upper not in {t.upper() for t in parts}:
                parts.insert(0, level_tag)
        return ", ".join(parts)

    def _data_path_for_level(self, level: str) -> Optional[str]:
        level_key = (level or "").strip().lower()
        if not level_key:
            return None
        candidates = [
            os.path.join(self.data_dir, f"{level_key}.csv"),
            os.path.join(self.data_dir, f"jlpt_{level_key}.csv"),
        ]
        if level_key == "n4":
            candidates.append(os.path.join(self.data_dir, "n4_sample.csv"))
        for path in candidates:
            if os.path.exists(path):
                return path
        return None

    def _detect_dialect(self, sample: str) -> csv.Dialect:
        try:
            return csv.Sniffer().sniff(sample, delimiters=[",", "\t", ";"])
        except Exception:
            return csv.excel

    def _map_row(self, row: dict, level_tag: Optional[str]) -> dict:
        keys = {k.lower(): k for k in row.keys()}

        def pick(*names: str) -> str:
            for n in names:
                if n in keys:
                    return (row.get(keys[n]) or "").strip()
            return ""

        item_type = pick("item_type", "type")
        if item_type not in ("vocab", "kanji", "grammar"):
            item_type = "vocab"

        term = pick("term", "front", "expression", "word")
        reading = pick("reading", "pronunciation", "kana", "furigana")
        meaning = pick("meaning", "back", "definition", "gloss")
        example = pick("example", "sentence", "context", "note")
        tags = pick("tags")
        deck = pick("deck")
        if deck and not tags:
            tags = deck

        if level_tag:
            tags = self._merge_tags(tags, level_tag)

        if not term or not meaning:
            raise ValueError("Missing term/meaning")

        return {
            "item_type": item_type,
            "term": term,
            "reading": reading,
            "meaning": meaning,
            "example": example,
            "tags": tags,
        }

    def _count_rows(self, path: str) -> int:
        try:
            with open(path, "r", encoding="utf-8-sig") as f:
                return max(0, sum(1 for _ in f) - 1)
        except Exception:
            return 0

    def _import_csv(
        self,
        path: str,
        level_tag: Optional[str] = None,
        progress_cb: Optional[Callable[[int, int], None]] = None,
        db_conn: Optional[sqlite3.Connection] = None,
        total_rows_hint: Optional[int] = None,
    ) -> ImportResult:
        db = db_conn or self.db
        imported = 0
        errors = 0
        skipped = 0
        error_rows: List[str] = []
        duplicate_rows: List[str] = []
        warning_rows: List[str] = []
        new_ids: List[int] = []

        total_rows = total_rows_hint or self._count_rows(path) or 1
        processed_file = 0

        with open(path, "r", encoding="utf-8-sig", newline="") as f:
            sample = f.read(2048)
            f.seek(0)
            dialect = self._detect_dialect(sample)
            reader = csv.DictReader(f, dialect=dialect)
            if reader.fieldnames is None:
                raise ValueError("CSV missing header.")

            for row_num, row in enumerate(reader, start=2):
                try:
                    data = self._map_row(row, level_tag=level_tag)
                    if data["example"]:
                        _, _, used_fallback, reason = build_cloze_preview(data["example"], data["term"])
                        if used_fallback:
                            warning_rows.append(f"Row {row_num}: cloze fallback ({reason}) - term không có trong câu?")
                    new_id, created = create_item_with_card(
                        db,
                        item_type=data["item_type"],
                        term=data["term"],
                        reading=data["reading"],
                        meaning=data["meaning"],
                        example=data["example"],
                        tags=data["tags"],
                    )
                    if created:
                        new_ids.append(new_id)
                        imported += 1
                    else:
                        skipped += 1
                        duplicate_rows.append(f"Row {row_num}: trùng term+reading (id={new_id})")
                except Exception as e:
                    errors += 1
                    msg = str(e).strip() or e.__class__.__name__
                    error_rows.append(f"Row {row_num}: {msg}")
                finally:
                    processed_file += 1
                    if progress_cb:
                        progress_cb(min(processed_file, total_rows), total_rows)

        return ImportResult(
            imported=imported,
            errors=errors,
            skipped=skipped,
            new_ids=new_ids,
            error_rows=error_rows,
            duplicate_rows=duplicate_rows,
            warning_rows=warning_rows,
        )

    def _start_worker(self, tasks: List[Tuple[str, Optional[str]]], mode: str, missing: Optional[List[str]] = None):
        if not tasks:
            return
        self._import_mode = mode
        self._pending_missing = missing or []
        dialog = QProgressDialog("Đang import...", "Hủy", 0, 100, self)
        dialog.setWindowModality(Qt.WindowModal)
        dialog.setMinimumDuration(0)

        thread = QThread(self)
        worker = ImportWorker(self, tasks)
        worker.moveToThread(thread)

        def on_progress(done: int, total: int, fname: str):
            percent = int(done / total * 100) if total else 0
            dialog.setLabelText(f"Đang import {fname} ({done}/{total})")
            dialog.setValue(percent)

        def cleanup():
            dialog.close()
            worker.deleteLater()
            thread.quit()
            thread.wait()

        def on_finished(result: ImportResult):
            cleanup()
            self._handle_result(result)

        def on_error(msg: str):
            cleanup()
            QMessageBox.critical(self, "Import lỗi", msg)

        worker.progress.connect(on_progress)
        worker.finished.connect(on_finished)
        worker.error.connect(on_error)
        dialog.canceled.connect(worker.stop)
        thread.started.connect(worker.run)
        thread.start()

    def on_auto_import(self):
        level = (self.cb_level.currentText() or "").strip().upper()
        if level == "ALL":
            levels = ["N5", "N4", "N3", "N2", "N1"]
        else:
            levels = [level]

        tasks: List[Tuple[str, Optional[str]]] = []
        missing: List[str] = []
        for lvl in levels:
            path = self._data_path_for_level(lvl)
            if not path:
                missing.append(lvl)
                continue
            tasks.append((path, lvl))

        if not tasks and missing:
            QMessageBox.warning(self, "Missing data", "No data files found for: " + ", ".join(missing))
            return

        self._start_worker(tasks, mode="auto", missing=missing)

    def on_import_csv(self):
        path, _ = QFileDialog.getOpenFileName(
            self, "Chọn file CSV", "", "CSV Files (*.csv);;All Files (*)"
        )
        if not path:
            return
        self._start_worker([(path, None)], mode="manual")

    def _handle_result(self, result: ImportResult):
        self.refresh()
        msg = (
            f"Đã import: {result.imported} dòng. "
            f"Trùng (merge/skip): {result.skipped} dòng. "
            f"Lỗi: {result.errors} dòng."
        )
        if self._pending_missing:
            msg += " Missing files for: " + ", ".join(self._pending_missing) + "."
        if result.errors and result.error_rows:
            preview = "\n".join(result.error_rows[:8])
            if result.errors > len(result.error_rows):
                preview += "\n..."
            msg += "\nError rows (preview):\n" + preview
        if result.skipped and result.duplicate_rows:
            preview_dup = "\n".join(result.duplicate_rows[:8])
            if result.skipped > len(result.duplicate_rows):
                preview_dup += "\n..."
            msg += "\nDuplicates (preview):\n" + preview_dup
        if result.warning_rows:
            preview_warn = "\n".join(result.warning_rows[:8])
            if len(result.warning_rows) > 8:
                preview_warn += "\n..."
            msg += "\nCloze warnings:\n" + preview_warn

        title = "Auto import done" if self._import_mode == "auto" else "Import xong"
        QMessageBox.information(self, title, msg)
        self._launch_quiz_with_ids(result.new_ids)

    def _launch_quiz_with_ids(self, ids: List[int]) -> None:
        if not ids:
            return
        items = get_items_by_ids(self.db, ids)
        if not items:
            return
        sample = random.sample(items, k=10) if len(items) > 10 else items
        dlg = QuickQuizDialog(sample, self)
        dlg.exec()
