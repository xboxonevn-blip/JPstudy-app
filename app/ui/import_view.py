from __future__ import annotations
import sqlite3
import csv
import os
import random
from typing import Callable, Optional, List

from PySide6.QtWidgets import (
    QWidget, QVBoxLayout, QLabel, QPushButton, QFileDialog, QHBoxLayout,
    QTableWidget, QTableWidgetItem, QMessageBox, QLineEdit, QComboBox, QTextEdit, QDialog, QDialogButtonBox
)
from PySide6.QtCore import Qt

from app.db.repo import create_item_with_card, count_items, get_items_by_ids


class AddItemDialog(QDialog):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("Them muc moi (A - Nap)")
        self.resize(520, 420)

        layout = QVBoxLayout(self)

        row1 = QHBoxLayout()
        self.cb_type = QComboBox()
        self.cb_type.addItems(["vocab", "kanji", "grammar"])
        self.ed_term = QLineEdit()
        self.ed_term.setPlaceholderText("term (tu / kanji / mau)")
        row1.addWidget(QLabel("Loai:"))
        row1.addWidget(self.cb_type, 1)
        row1.addWidget(QLabel("Term:"))
        row1.addWidget(self.ed_term, 2)
        layout.addLayout(row1)

        row2 = QHBoxLayout()
        self.ed_reading = QLineEdit()
        self.ed_reading.setPlaceholderText("reading (kana) co the de trong")
        self.ed_tags = QLineEdit()
        self.ed_tags.setPlaceholderText("tags: N4, food, ...")
        row2.addWidget(QLabel("Reading:"))
        row2.addWidget(self.ed_reading, 2)
        row2.addWidget(QLabel("Tags:"))
        row2.addWidget(self.ed_tags, 2)
        layout.addLayout(row2)

        self.ed_meaning = QLineEdit()
        self.ed_meaning.setPlaceholderText("meaning (nghia Tieng Viet)")
        layout.addWidget(QLabel("Meaning:"))
        layout.addWidget(self.ed_meaning)

        self.ed_example = QTextEdit()
        self.ed_example.setPlaceholderText("example sentence (cau vi du) nen co de luyen C sau nay")
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
        self.ed_guess.setPlaceholderText("Nhap thu nghia (optional)")
        layout.addWidget(self.ed_guess)

        self.lbl_back = QTextEdit()
        self.lbl_back.setReadOnly(True)
        layout.addWidget(self.lbl_back, 1)

        btn_row = QHBoxLayout()
        self.btn_reveal = QPushButton("Show answer")
        self.btn_correct = QPushButton("I got it")
        self.btn_wrong = QPushButton("I missed")
        self.btn_close = QPushButton("Close")
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
            f"Nghia: {item['meaning']}\n\n"
            f"Vi du: {item['example']}\n\n"
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


class ImportView(QWidget):
    def __init__(self, db: sqlite3.Connection, on_navigate: Callable[[str], None]):
        super().__init__()
        self.db = db
        self.on_navigate = on_navigate
        self.data_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "data"))

        layout = QVBoxLayout(self)
        layout.setSpacing(10)

        title = QLabel("A - Nap (Import CSV / Add the)")
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
        self.btn_add = QPushButton("Them the")
        self.btn_back = QPushButton("Ve Home")

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
        self.info.setText(f"Tong muc hien co: {total}. Import xong, the SRS se duoc tao va den han ngay hom nay.")
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
                QMessageBox.warning(self, "Thieu thong tin", "Can nhap toi thieu: term + meaning.")
                return
            create_item_with_card(
                self.db,
                item_type=data["item_type"],
                term=data["term"],
                reading=data["reading"],
                meaning=data["meaning"],
                example=data["example"],
                tags=data["tags"],
            )
            self.refresh()
            QMessageBox.information(self, "OK", "Da them muc va tao the SRS (den han hom nay).")

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
        # Normalize keys to lowercase for detection
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

    def _import_csv(self, path: str, level_tag: Optional[str] = None) -> tuple[int, int, List[int]]:
        imported = 0
        errors = 0
        new_ids: List[int] = []

        with open(path, "r", encoding="utf-8-sig", newline="") as f:
            sample = f.read(2048)
            f.seek(0)
            dialect = self._detect_dialect(sample)
            reader = csv.DictReader(f, dialect=dialect)
            if reader.fieldnames is None:
                raise ValueError("CSV missing header.")

            for _, row in enumerate(reader, start=2):
                try:
                    data = self._map_row(row, level_tag=level_tag)
                    new_id = create_item_with_card(
                        self.db,
                        item_type=data["item_type"],
                        term=data["term"],
                        reading=data["reading"],
                        meaning=data["meaning"],
                        example=data["example"],
                        tags=data["tags"],
                    )
                    new_ids.append(new_id)
                    imported += 1
                except Exception:
                    errors += 1

        return imported, errors, new_ids

    def on_auto_import(self):
        level = (self.cb_level.currentText() or "").strip().upper()
        if level == "ALL":
            levels = ["N5", "N4", "N3", "N2", "N1"]
        else:
            levels = [level]

        missing = []
        total_imported = 0
        total_errors = 0
        new_ids: List[int] = []

        for lvl in levels:
            path = self._data_path_for_level(lvl)
            if not path:
                missing.append(lvl)
                continue
            try:
                imported, errors, ids = self._import_csv(path, level_tag=lvl)
            except Exception as e:
                QMessageBox.critical(self, "Import error", f"{lvl}: {e}")
                return
            total_imported += imported
            total_errors += errors
            new_ids.extend(ids)

        if total_imported == 0 and total_errors == 0 and missing:
            QMessageBox.warning(
                self,
                "Missing data",
                "No data files found for: " + ", ".join(missing),
            )
            return

        self.refresh()
        msg = f"Imported: {total_imported} rows. Errors: {total_errors} rows."
        if missing:
            msg += " Missing files for: " + ", ".join(missing) + "."
        QMessageBox.information(self, "Auto import done", msg)
        self._launch_quiz_with_ids(new_ids)

    def on_import_csv(self):
        path, _ = QFileDialog.getOpenFileName(
            self, "Chon file CSV", "", "CSV Files (*.csv);;All Files (*)"
        )
        if not path:
            return

        try:
            imported, errors, new_ids = self._import_csv(path)
        except Exception as e:
            QMessageBox.critical(self, "Import loi", str(e))
            return

        self.refresh()
        QMessageBox.information(self, "Import xong", f"Da import: {imported} dong. Loi: {errors} dong.")
        self._launch_quiz_with_ids(new_ids)

    def _launch_quiz_with_ids(self, ids: List[int]) -> None:
        if not ids:
            return
        items = get_items_by_ids(self.db, ids)
        if not items:
            return
        sample = random.sample(items, k=10) if len(items) > 10 else items
        dlg = QuickQuizDialog(sample, self)
        dlg.exec()
