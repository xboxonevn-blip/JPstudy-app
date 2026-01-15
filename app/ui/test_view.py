from __future__ import annotations
import sqlite3
from typing import Callable, Optional

from PySide6.QtWidgets import (
    QWidget,
    QVBoxLayout,
    QLabel,
    QFrame,
    QPushButton,
    QHBoxLayout,
    QLineEdit,
    QSpinBox,
    QCheckBox,
    QComboBox,
)
from PySide6.QtCore import Qt

from app.db.repo import (
    get_test_batch,
    record_attempt,
    record_mistake,
    resolve_mistake,
    record_error,
    resolve_errors_for_item,
    get_or_create_test,
    create_test_attempt,
    update_test_attempt,
)


class MiniTestView(QWidget):
    def __init__(self, db: sqlite3.Connection, on_navigate: Callable[[str], None]):
        super().__init__()
        self.db = db
        self.on_navigate = on_navigate

        self.questions = []
        self.index = 0
        self.correct = 0
        self.test_id: Optional[int] = None
        self.test_attempt_id: Optional[int] = None

        layout = QVBoxLayout(self)
        layout.setSpacing(10)

        title = QLabel("D - Mini Test (tùy biến)")
        title.setStyleSheet("font-size: 16px; font-weight: 700;")
        layout.addWidget(title)

        cfg_row = QHBoxLayout()
        self.sp_total = QSpinBox()
        self.sp_total.setRange(5, 30)
        self.sp_total.setValue(15)
        self.cb_only_mistake = QCheckBox("Chỉ Mistake")
        self.cb_only_due = QCheckBox("Chỉ Due")
        self.cb_level = QComboBox()
        self.cb_level.addItems(["Tất cả", "N5", "N4", "N3", "N2", "N1"])
        self.ed_tag = QLineEdit()
        self.ed_tag.setPlaceholderText("Lọc tag chứa...")
        self.btn_reload = QPushButton("Làm bài")
        self.btn_reload.clicked.connect(self.start_new_test)
        for b in [self.cb_only_mistake, self.cb_only_due, self.btn_reload]:
            b.setCursor(Qt.PointingHandCursor)

        cfg_row.addWidget(QLabel("Số câu:"))
        cfg_row.addWidget(self.sp_total)
        cfg_row.addWidget(self.cb_only_mistake)
        cfg_row.addWidget(self.cb_only_due)
        cfg_row.addWidget(QLabel("JLPT:"))
        cfg_row.addWidget(self.cb_level)
        cfg_row.addWidget(self.ed_tag)
        cfg_row.addStretch(1)
        cfg_row.addWidget(self.btn_reload)
        layout.addLayout(cfg_row)

        self.status = QLabel("")
        self.status.setStyleSheet("color:#555;")
        layout.addWidget(self.status)

        self.card_frame = QFrame()
        self.card_frame.setFrameShape(QFrame.StyledPanel)
        self.card_frame.setStyleSheet("QFrame{border:1px solid #ddd; border-radius:10px; padding:12px;}")
        c_layout = QVBoxLayout(self.card_frame)
        c_layout.setSpacing(8)

        self.lbl_cloze = QLabel("")
        self.lbl_cloze.setWordWrap(True)
        self.lbl_cloze.setStyleSheet("font-size: 18px; font-weight: 700;")
        c_layout.addWidget(self.lbl_cloze)

        self.lbl_hint = QLabel("")
        self.lbl_hint.setWordWrap(True)
        self.lbl_hint.setStyleSheet("color:#444;")
        c_layout.addWidget(self.lbl_hint)

        self.ed_answer = QLineEdit()
        self.ed_answer.setPlaceholderText("Điền đáp án vào chỗ trống")
        c_layout.addWidget(self.ed_answer)

        self.lbl_feedback = QLabel("")
        self.lbl_feedback.setWordWrap(True)
        c_layout.addWidget(self.lbl_feedback)

        layout.addWidget(self.card_frame, 1)

        btn_row = QHBoxLayout()
        self.btn_check = QPushButton("Check")
        self.btn_show = QPushButton("Xem đáp án")
        self.btn_next = QPushButton("Tiếp")
        self.btn_restart = QPushButton("Làm lại")
        self.btn_back = QPushButton("Về Home")
        for b in [self.btn_check, self.btn_show, self.btn_next, self.btn_restart, self.btn_back]:
            b.setCursor(Qt.PointingHandCursor)

        self.btn_check.clicked.connect(self.on_check)
        self.btn_show.clicked.connect(self.on_show)
        self.btn_next.clicked.connect(self._next_question)
        self.btn_restart.clicked.connect(self.start_new_test)
        self.btn_back.clicked.connect(lambda: self.on_navigate("home"))

        btn_row.addWidget(self.btn_check)
        btn_row.addWidget(self.btn_show)
        btn_row.addWidget(self.btn_next)
        btn_row.addStretch(1)
        btn_row.addWidget(self.btn_restart)
        btn_row.addWidget(self.btn_back)
        layout.addLayout(btn_row)

        self.start_new_test()

    def start_new_test(self) -> None:
        level = self.cb_level.currentText()
        level_filter = None if level == "Tất cả" else level
        tag_filter = self.ed_tag.text().strip() or None
        self.questions = get_test_batch(
            self.db,
            total=self.sp_total.value(),
            only_mistake=self.cb_only_mistake.isChecked(),
            only_due=self.cb_only_due.isChecked(),
            tag_filter=tag_filter,
            level_filter=level_filter,
        )
        self.index = 0
        self.correct = 0
        self.test_id = get_or_create_test(self.db, title="Mini Test")
        self.test_attempt_id = create_test_attempt(self.db, test_id=self.test_id)
        self._next_question()

    def _update_status(self) -> None:
        total = len(self.questions)
        level = self.cb_level.currentText()
        tag_filter = self.ed_tag.text().strip() or "all"
        mode = "mistake" if self.cb_only_mistake.isChecked() else ("due" if self.cb_only_due.isChecked() else "mix")
        self.status.setText(
            f"Câu {self.index+1}/{total} | Đúng: {self.correct} | mode={mode} | JLPT={level} | tag={tag_filter}"
        )

    def _next_question(self) -> None:
        self.lbl_feedback.setText("")
        self.ed_answer.setText("")
        if not self.questions:
            self.lbl_cloze.setText("Chưa có câu nào. Hãy thêm dữ liệu hoặc import.")
            self.lbl_hint.setText("")
            return

        if self.index >= len(self.questions):
            total = len(self.questions)
            score = (self.correct / total) * 100 if total else 0.0
            self.lbl_cloze.setText(f"Done! Score: {self.correct}/{total} ({score:.1f}%)")
            self.lbl_hint.setText("Sai sẽ được ghi vào sổ lỗi và xuất hiện lại ở B/C.")
            self.btn_check.setEnabled(False)
            self.btn_show.setEnabled(False)
            self.btn_next.setEnabled(False)
            if self.test_attempt_id is not None:
                update_test_attempt(self.db, self.test_attempt_id, score=score)
            return

        self.btn_check.setEnabled(True)
        self.btn_show.setEnabled(True)
        self.btn_next.setEnabled(True)

        q = self.questions[self.index]
        self.lbl_cloze.setText(q["cloze"] or "____")
        meaning = q.get("meaning") or ""
        term = q.get("term") or ""
        reading = q.get("reading") or ""
        source = q.get("question_source") or ""
        self.lbl_hint.setText(f"Gợi ý: {meaning} ({term} {reading}) | nguồn: {source}")
        self._update_status()
        self.ed_answer.setFocus()

    def on_show(self) -> None:
        if self.index >= len(self.questions):
            return
        expected = self.questions[self.index].get("answer") or self.questions[self.index].get("term") or ""
        self.lbl_feedback.setStyleSheet("color:#006400;")
        self.lbl_feedback.setText(f"Đáp án: {expected}")

    def on_check(self) -> None:
        if self.index >= len(self.questions):
            return
        q = self.questions[self.index]
        response = self.ed_answer.text().strip()
        expected = (q.get("answer") or q.get("term") or "").strip()
        is_correct = response.lower() == expected.lower() if expected else False
        item_id = q.get("item_id")

        attempt_id = record_attempt(
            self.db,
            source="test",
            item_id=q.get("item_id"),
            card_id=q.get("card_id"),
            sentence_id=q.get("sentence_id"),
            test_id=self.test_id,
            test_attempt_id=self.test_attempt_id,
            prompt=q.get("cloze") or "",
            response=response,
            expected=expected,
            is_correct=is_correct,
        )

        if not is_correct and item_id is not None:
            record_mistake(
                self.db,
                item_id=int(item_id),
                source="test",
                card_id=q.get("card_id"),
                last_attempt_id=attempt_id,
            )
            record_error(
                self.db,
                item_id=int(item_id),
                source="D",
                error_type="test_wrong",
                note=f"expected={expected}; response={response}",
            )
        elif is_correct and item_id is not None:
            resolve_mistake(
                self.db,
                item_id=int(item_id),
                source="test",
            )
            resolve_errors_for_item(self.db, item_id=int(item_id), source="D")

        if is_correct:
            self.correct += 1
            self.lbl_feedback.setStyleSheet("color:#006400;")
            self.lbl_feedback.setText("Chuẩn! Tiếp tục.")
            self.index += 1
            self._next_question()
        else:
            self.lbl_feedback.setStyleSheet("color:#aa0000;")
            self.lbl_feedback.setText(f"Sai rồi. Đáp án: {expected}")
            self.index += 1
            self._update_status()
