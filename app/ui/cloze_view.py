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
    QComboBox,
)
from PySide6.QtCore import Qt

from app.db.repo import (
    get_cloze_queue,
    record_attempt,
    record_mistake,
    resolve_mistake,
    record_error,
    resolve_errors_for_item,
)


class ClozePracticeView(QWidget):
    def __init__(self, db: sqlite3.Connection, on_navigate: Callable[[str], None]):
        super().__init__()
        self.db = db
        self.on_navigate = on_navigate

        self.queue = []
        self.current: Optional[dict] = None

        layout = QVBoxLayout(self)
        layout.setSpacing(10)

        title = QLabel("C - Cloze Practice")
        title.setProperty("role", "title")
        layout.addWidget(title)

        top_row = QHBoxLayout()
        self.status = QLabel("")
        self.status.setProperty("role", "subtitle")
        self.cb_level = QComboBox()
        self.cb_level.addItems(["All", "N5", "N4", "N3", "N2", "N1"])
        self.cb_level.currentIndexChanged.connect(self.refresh)
        self.ed_tag = QLineEdit()
        self.ed_tag.setPlaceholderText("Filter by tag...")
        self.ed_tag.returnPressed.connect(self.refresh)
        top_row.addWidget(self.status, 1)
        top_row.addWidget(QLabel("JLPT:"))
        top_row.addWidget(self.cb_level)
        top_row.addWidget(self.ed_tag)
        layout.addLayout(top_row)

        self.card_frame = QFrame()
        self.card_frame.setProperty("role", "card")
        self.card_frame.setFrameShape(QFrame.StyledPanel)
        c_layout = QVBoxLayout(self.card_frame)
        c_layout.setSpacing(8)

        self.lbl_cloze = QLabel("")
        self.lbl_cloze.setAlignment(Qt.AlignCenter)
        self.lbl_cloze.setWordWrap(True)
        self.lbl_cloze.setStyleSheet("font-size: 18px; font-weight: 700;")
        c_layout.addWidget(self.lbl_cloze)

        self.lbl_hint = QLabel("")
        self.lbl_hint.setAlignment(Qt.AlignCenter)
        self.lbl_hint.setWordWrap(True)
        self.lbl_hint.setProperty("role", "subtitle")
        c_layout.addWidget(self.lbl_hint)

        self.ed_answer = QLineEdit()
        self.ed_answer.setPlaceholderText("Fill in the missing term")
        c_layout.addWidget(self.ed_answer)

        self.lbl_feedback = QLabel("")
        self.lbl_feedback.setAlignment(Qt.AlignCenter)
        self.lbl_feedback.setWordWrap(True)
        self.lbl_feedback.setStyleSheet("color:#aa0000;")
        c_layout.addWidget(self.lbl_feedback)

        layout.addWidget(self.card_frame, 1)

        btn_row = QHBoxLayout()
        self.btn_check = QPushButton("Check")
        self.btn_show = QPushButton("Show Answer")
        self.btn_next = QPushButton("Next")
        self.btn_back = QPushButton("Back to Home")
        for b in [self.btn_check, self.btn_show, self.btn_next, self.btn_back]:
            b.setCursor(Qt.PointingHandCursor)

        self.btn_check.clicked.connect(self.on_check)
        self.btn_show.clicked.connect(self.on_show)
        self.btn_next.clicked.connect(self._next_card)
        self.btn_back.clicked.connect(lambda: self.on_navigate("home"))

        btn_row.addWidget(self.btn_check)
        btn_row.addWidget(self.btn_show)
        btn_row.addWidget(self.btn_next)
        btn_row.addStretch(1)
        btn_row.addWidget(self.btn_back)
        layout.addLayout(btn_row)

        self.refresh()

    def _filters(self):
        level = self.cb_level.currentText()
        level_filter = None if level == "All" else level
        tag_filter = self.ed_tag.text().strip() or None
        return level_filter, tag_filter

    def refresh(self) -> None:
        level_filter, tag_filter = self._filters()
        self.queue = get_cloze_queue(
            self.db,
            limit=50,
            tag_filter=tag_filter,
            level_filter=level_filter,
        )
        self.status.setText(
            f"Queue: {len(self.queue)} (mistakes first) | JLPT: {level_filter or 'all'} | tag: {tag_filter or 'all'}"
        )
        self._next_card()

    def _next_card(self) -> None:
        self.lbl_feedback.setText("")
        self.ed_answer.setText("")
        if not self.queue:
            self.current = None
            self.lbl_cloze.setText("No sentences to practice. Add data or come back later.")
            self.lbl_hint.setText("")
            self.btn_check.setEnabled(False)
            self.btn_show.setEnabled(False)
            self.btn_next.setEnabled(False)
            return

        self.btn_check.setEnabled(True)
        self.btn_show.setEnabled(True)
        self.btn_next.setEnabled(True)

        self.current = self.queue.pop(0)
        cloze = self.current.get("cloze") or "____"
        meaning = self.current.get("meaning") or ""
        reading = self.current.get("reading") or ""
        term = self.current.get("term") or ""
        fallback = self.current.get("cloze_fallback")
        reason = self.current.get("cloze_reason") or ""
        warn = " (cloze fallback)" if fallback else ""
        self.lbl_cloze.setText(cloze)
        self.lbl_hint.setText(f"Hint: {meaning} ({term} {reading}){warn}".strip())
        self.status.setText(f"Remaining: {len(self.queue)+1} | {reason}")
        self.ed_answer.setFocus()

    def on_show(self) -> None:
        if not self.current:
            return
        answer = self.current.get("answer") or self.current.get("term") or ""
        self.lbl_feedback.setStyleSheet("color:#006400;")
        self.lbl_feedback.setText(f"Answer: {answer}")

    def on_check(self) -> None:
        if not self.current:
            return
        response = self.ed_answer.text().strip()
        expected = (self.current.get("answer") or self.current.get("term") or "").strip()
        is_correct = response.lower() == expected.lower() if expected else False
        item_id = self.current.get("item_id")

        attempt_id = record_attempt(
            self.db,
            source="sentence",
            item_id=item_id,
            sentence_id=self.current.get("sentence_id"),
            prompt=self.current.get("cloze") or "",
            response=response,
            expected=expected,
            is_correct=is_correct,
        )

        if not is_correct and item_id is not None:
            record_mistake(
                self.db,
                item_id=int(item_id),
                source="sentence",
                card_id=None,
                last_attempt_id=attempt_id,
            )
            record_error(
                self.db,
                item_id=int(item_id),
                source="C",
                error_type="cloze_wrong",
                note=f"expected={expected}; response={response}",
            )
        elif is_correct and item_id is not None:
            resolve_mistake(
                self.db,
                item_id=int(item_id),
                source="sentence",
            )
            resolve_errors_for_item(self.db, item_id=int(item_id), source="C")

        if is_correct:
            self.lbl_feedback.setStyleSheet("color:#006400;")
            self.lbl_feedback.setText("Correct! Moving on.")
            self._next_card()
        else:
            self.lbl_feedback.setStyleSheet("color:#aa0000;")
            self.lbl_feedback.setText(f"Incorrect. Answer: {expected}")
