from __future__ import annotations
import sqlite3
from typing import Callable
from PySide6.QtWidgets import QWidget, QVBoxLayout, QLabel, QFrame, QPushButton
from PySide6.QtCore import Qt

from app.db.repo import (
    count_due_cards,
    count_items,
    get_attempt_stats,
    get_review_stats,
    get_streak,
    get_leech_due_count,
    get_level_breakdown,
)


class HomeView(QWidget):
    def __init__(self, db: sqlite3.Connection, on_navigate: Callable[[str], None]):
        super().__init__()
        self.db = db
        self.on_navigate = on_navigate

        layout = QVBoxLayout(self)
        layout.setSpacing(12)

        title = QLabel("Daily Plan - (A) Nap + (B) SRS + (C) Cau + (D) Test")
        title.setStyleSheet("font-size: 18px; font-weight: 700;")
        layout.addWidget(title)

        self.stats = QLabel("")
        self.stats.setStyleSheet("font-size: 14px;")
        layout.addWidget(self.stats)

        self.review_stats = QLabel("")
        self.review_stats.setStyleSheet("font-size: 13px; color:#444;")
        layout.addWidget(self.review_stats)

        self.level_stats = QLabel("")
        self.level_stats.setStyleSheet("font-size: 13px; color:#444;")
        layout.addWidget(self.level_stats)

        card = QFrame()
        card.setFrameShape(QFrame.StyledPanel)
        card.setStyleSheet("QFrame{border:1px solid #ddd; border-radius:10px; padding:10px;}")
        card_layout = QVBoxLayout(card)
        card_layout.setSpacing(10)

        self.btn_start_srs = QPushButton("Bat dau SRS (review the den han)")
        self.btn_start_srs.clicked.connect(lambda: self.on_navigate("srs"))
        self.btn_start_import = QPushButton("Nap du lieu (Import CSV / Add)")
        self.btn_start_import.clicked.connect(lambda: self.on_navigate("import"))

        self.btn_start_srs.setCursor(Qt.PointingHandCursor)
        self.btn_start_import.setCursor(Qt.PointingHandCursor)

        card_layout.addWidget(self.btn_start_srs)
        card_layout.addWidget(self.btn_start_import)

        layout.addWidget(card)

        tips = QLabel(
            "Tip: Sau khi import, the se duoc tao va den han ngay hom nay.\n"
            "Muc tieu: lam SRS moi ngay, roi mo rong C/D sau."
        )
        tips.setStyleSheet("color:#555;")
        layout.addWidget(tips)

        layout.addStretch(1)
        self.refresh()

    def refresh(self) -> None:
        due = count_due_cards(self.db)
        items = count_items(self.db)
        self.stats.setText(f"Tong muc da nap: {items} | The den han hom nay: {due}")

        activity = get_attempt_stats(self.db)
        review = get_review_stats(self.db)
        streak = get_streak(self.db)
        daily_goal = 30
        source_parts = []
        labels = {
            "srs": "B/SRS",
            "sentence": "C/Cloze",
            "test": "D/Test",
            "quiz": "Quiz",
            "manual": "Manual",
        }
        for src, lbl in labels.items():
            data = activity["by_source"].get(src)
            if data:
                source_parts.append(f"{lbl}: {data['total']} ({data['accuracy']:.0f}% dA­ng)")
        extra_sources = [k for k in activity["by_source"].keys() if k not in labels]
        for src in extra_sources:
            data = activity["by_source"][src]
            source_parts.append(f"{src}: {data['total']} ({data['accuracy']:.0f}% dA­ng)")
        source_text = " | ".join(source_parts) if source_parts else "Ch’øa co hoat dA§ng"
        self.review_stats.setText(
            f"Hoat dA§ng hom nay: {activity['total']} | Acc: {activity['accuracy']:.1f}% "
            f"| {source_text} | Streak: {streak} ngay | Goal: {daily_goal}/day"
        )

        level_counts = get_level_breakdown(self.db, due_only=True)
        leech_due = get_leech_due_count(self.db)
        level_text = " | ".join([f"{lvl}: {level_counts[lvl]}" for lvl in ["N5", "N4", "N3", "N2", "N1"]])
        self.level_stats.setText(
            f"Leech due: {leech_due} | Due by level: {level_text} | SRS: {review['total']} ({review['accuracy']:.1f}% acc)"
        )

        self.btn_start_srs.setEnabled(due > 0)
