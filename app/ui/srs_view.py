from __future__ import annotations
import sqlite3
from typing import Callable

from PySide6.QtWidgets import (
    QWidget, QVBoxLayout, QLabel, QFrame, QPushButton, QHBoxLayout, QMessageBox, QCheckBox
)
from PySide6.QtCore import Qt

from app.db.repo import fetch_due_cards, update_card, log_review
from app.srs.engine import SrsState, apply_grade


class SrsReviewView(QWidget):
    def __init__(self, db: sqlite3.Connection, on_navigate: Callable[[str], None]):
        super().__init__()
        self.db = db
        self.on_navigate = on_navigate

        self.queue = []
        self.current = None
        self.revealed = False

        layout = QVBoxLayout(self)
        layout.setSpacing(10)

        title = QLabel("SRS Review (Due)")
        title.setStyleSheet("font-size: 16px; font-weight: 700;")
        layout.addWidget(title)

        top_row = QHBoxLayout()
        self.status = QLabel("")
        self.status.setStyleSheet("color:#555;")
        self.chk_leech = QCheckBox("Leech only")
        self.chk_leech.stateChanged.connect(self.refresh)
        top_row.addWidget(self.status, 1)
        top_row.addWidget(self.chk_leech)
        layout.addLayout(top_row)

        self.card_frame = QFrame()
        self.card_frame.setFrameShape(QFrame.StyledPanel)
        self.card_frame.setStyleSheet("QFrame{border:1px solid #ddd; border-radius:10px; padding:12px;}")
        c_layout = QVBoxLayout(self.card_frame)

        self.front = QLabel("")
        self.front.setWordWrap(True)
        self.front.setStyleSheet("font-size: 18px; font-weight: 700;")
        c_layout.addWidget(self.front)

        self.back = QLabel("")
        self.back.setWordWrap(True)
        self.back.setStyleSheet("font-size: 14px; color:#333;")
        c_layout.addWidget(self.back)

        layout.addWidget(self.card_frame, 1)

        btn_row = QHBoxLayout()
        self.btn_reveal = QPushButton("Show answer")
        self.btn_again = QPushButton("Again")
        self.btn_hard = QPushButton("Hard")
        self.btn_good = QPushButton("Good")
        self.btn_easy = QPushButton("Easy")
        self.btn_back = QPushButton("Back Home")

        for b in [self.btn_reveal, self.btn_again, self.btn_hard, self.btn_good, self.btn_easy, self.btn_back]:
            b.setCursor(Qt.PointingHandCursor)

        self.btn_reveal.clicked.connect(self.on_reveal)
        self.btn_again.clicked.connect(lambda: self.on_grade("again"))
        self.btn_hard.clicked.connect(lambda: self.on_grade("hard"))
        self.btn_good.clicked.connect(lambda: self.on_grade("good"))
        self.btn_easy.clicked.connect(lambda: self.on_grade("easy"))
        self.btn_back.clicked.connect(lambda: self.on_navigate("home"))

        btn_row.addWidget(self.btn_reveal)
        btn_row.addStretch(1)
        btn_row.addWidget(self.btn_again)
        btn_row.addWidget(self.btn_hard)
        btn_row.addWidget(self.btn_good)
        btn_row.addWidget(self.btn_easy)
        btn_row.addWidget(self.btn_back)

        layout.addLayout(btn_row)

        self.refresh()

    def refresh(self) -> None:
        self.queue = fetch_due_cards(self.db, limit=300, leech_only=self.chk_leech.isChecked())
        self.status.setText(f"Queue: {len(self.queue)} cards (leech only: {self.chk_leech.isChecked()})")
        self._next_card()

    def _next_card(self) -> None:
        self.revealed = False
        self.back.setText("")
        if not self.queue:
            self.current = None
            self.front.setText("Hết thẻ đến hạn hôm nay!")
            self.status.setText("Bạn có thể quay lại Home hoặc Nạp thêm dữ liệu.")
            self.btn_reveal.setEnabled(False)
            for b in [self.btn_again, self.btn_hard, self.btn_good, self.btn_easy]:
                b.setEnabled(False)
            return

        self.current = self.queue.pop(0)
        self.btn_reveal.setEnabled(True)
        for b in [self.btn_again, self.btn_hard, self.btn_good, self.btn_easy]:
            b.setEnabled(False)

        term = self.current["term"]
        reading = self.current["reading"] or ""
        item_type = self.current["item_type"]
        self.front.setText(f"[{item_type}] {term}  {('(' + reading + ')') if reading else ''}".strip())
        self.status.setText(f"Con lai: {len(self.queue)+1} the")

    def on_reveal(self) -> None:
        if not self.current:
            return
        self.revealed = True
        meaning = self.current["meaning"] or ""
        example = self.current["example"] or ""
        tags = self.current["tags"] or ""
        lapses = int(self.current["lapses"])
        ease = float(self.current["ease"])
        is_leech = int(self.current["is_leech"])
        meta = f"ease={ease:.2f} • lapses={lapses}" + (" • LEECH" if is_leech else "")
        text = (
            f"Nghia: {meaning}\n\n"
            f"Vi du: {example}\n\n"
            f"Tags: {tags}\n\n"
            f"{meta}"
        )
        self.back.setText(text)
        for b in [self.btn_again, self.btn_hard, self.btn_good, self.btn_easy]:
            b.setEnabled(True)

    def on_grade(self, grade: str) -> None:
        if not self.current:
            return
        if not self.revealed:
            QMessageBox.information(self, "Goi y", "Hay bam 'Show answer' truoc khi chon diem.")
            return

        state = SrsState(
            due_date=str(self.current["due_date"]),
            interval_days=int(self.current["interval_days"]),
            ease=float(self.current["ease"]),
            lapses=int(self.current["lapses"]),
            is_leech=int(self.current["is_leech"]),
        )
        new_state = apply_grade(state, grade)  # type: ignore

        update_card(
            self.db,
            card_id=int(self.current["id"]),
            due_date=new_state.due_date,
            interval_days=new_state.interval_days,
            ease=new_state.ease,
            lapses=new_state.lapses,
            last_grade=grade,
            is_leech=new_state.is_leech,
        )
        log_review(
            self.db,
            card_id=int(self.current["id"]),
            grade=grade,
            is_correct=(grade != "again"),
            item_id=int(self.current["item_id"]),
            prompt=self.front.text(),
            expected=self.current["meaning"] or "",
            response=grade,
        )
        self._next_card()
