from __future__ import annotations
import sqlite3
import csv
from typing import Callable, List
from PySide6.QtWidgets import QWidget, QVBoxLayout, QLabel, QFrame, QPushButton, QFileDialog
from PySide6.QtCore import Qt

from app.db.repo import (
    count_due_cards,
    count_items,
    get_attempt_stats,
    get_review_stats,
    get_streak,
    get_leech_due_count,
    get_level_breakdown,
    get_attempt_timeseries,
    get_attempt_rows_for_export,
)


class HomeView(QWidget):
    def __init__(self, db: sqlite3.Connection, on_navigate: Callable[[str], None]):
        super().__init__()
        self.db = db
        self.on_navigate = on_navigate

        layout = QVBoxLayout(self)
        layout.setSpacing(12)

        title = QLabel("Daily Plan - (A) Nạp + (B) SRS + (C) Câu + (D) Test")
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

        self.daily_stats = QLabel("")
        self.daily_stats.setStyleSheet("font-size: 13px; color:#444;")
        layout.addWidget(self.daily_stats)

        card = QFrame()
        card.setFrameShape(QFrame.StyledPanel)
        card.setStyleSheet("QFrame{border:1px solid #ddd; border-radius:10px; padding:10px;}")
        card_layout = QVBoxLayout(card)
        card_layout.setSpacing(10)

        self.btn_start_srs = QPushButton("Bắt đầu SRS (thẻ đến hạn)")
        self.btn_start_srs.clicked.connect(lambda: self.on_navigate("srs"))
        self.btn_start_import = QPushButton("Nạp dữ liệu (Import CSV / Add)")
        self.btn_start_import.clicked.connect(lambda: self.on_navigate("import"))
        self.btn_export = QPushButton("Xuất kết quả CSV (30 ngày)")
        self.btn_export.clicked.connect(self.export_csv)

        self.btn_start_srs.setCursor(Qt.PointingHandCursor)
        self.btn_start_import.setCursor(Qt.PointingHandCursor)
        self.btn_export.setCursor(Qt.PointingHandCursor)

        card_layout.addWidget(self.btn_start_srs)
        card_layout.addWidget(self.btn_start_import)
        card_layout.addWidget(self.btn_export)

        layout.addWidget(card)

        tips = QLabel(
            "Tip: Sau khi import, thẻ sẽ được tạo và đến hạn ngay hôm nay.\n"
            "Mục tiêu: làm SRS mỗi ngày, rồi mở rộng C/D sau."
        )
        tips.setStyleSheet("color:#555;")
        layout.addWidget(tips)

        layout.addStretch(1)
        self.refresh()

    def refresh(self) -> None:
        due = count_due_cards(self.db)
        items = count_items(self.db)
        self.stats.setText(f"Tổng mục đã nạp: {items} | Thẻ đến hạn hôm nay: {due}")

        activity = get_attempt_stats(self.db)
        review = get_review_stats(self.db)
        streak = get_streak(self.db)
        daily_goal = 30
        source_parts: List[str] = []
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
                source_parts.append(f"{lbl}: {data['total']} ({data['accuracy']:.0f}% đúng)")
        extra_sources = [k for k in activity["by_source"].keys() if k not in labels]
        for src in extra_sources:
            data = activity["by_source"][src]
            source_parts.append(f"{src}: {data['total']} ({data['accuracy']:.0f}% đúng)")
        source_text = " | ".join(source_parts) if source_parts else "Chưa có hoạt động"
        self.review_stats.setText(
            f"Hoạt động hôm nay: {activity['total']} | Acc: {activity['accuracy']:.1f}% "
            f"| {source_text} | Streak: {streak} ngày | Goal: {daily_goal}/day"
        )

        level_counts = get_level_breakdown(self.db, due_only=True)
        leech_due = get_leech_due_count(self.db)
        level_text = " | ".join([f"{lvl}: {level_counts[lvl]}" for lvl in ["N5", "N4", "N3", "N2", "N1"]])
        self.level_stats.setText(
            f"Leech đến hạn: {leech_due} | Due by level: {level_text} | SRS: {review['total']} ({review['accuracy']:.1f}% acc)"
        )

        timeseries = get_attempt_timeseries(self.db, days=7)
        if timeseries:
            lines: List[str] = []
            for row in timeseries:
                lines.append(f"{row['date']}: {row['total']} ({row['accuracy']:.0f}% đúng)")
            self.daily_stats.setText("Tiến độ 7 ngày: " + " | ".join(lines))
        else:
            self.daily_stats.setText("Chưa có dữ liệu 7 ngày.")

        self.btn_start_srs.setEnabled(due > 0)

    def export_csv(self) -> None:
        path, _ = QFileDialog.getSaveFileName(
            self, "Lưu CSV kết quả", "", "CSV Files (*.csv);;All Files (*)"
        )
        if not path:
            return
        rows = get_attempt_rows_for_export(
            self.db,
            sources=["srs", "sentence", "test"],
            days=30,
            limit=2000,
        )
        headers = [
            "created_at",
            "source",
            "item_id",
            "card_id",
            "sentence_id",
            "test_id",
            "test_attempt_id",
            "prompt",
            "response",
            "expected",
            "is_correct",
            "score",
        ]
        with open(path, "w", encoding="utf-8", newline="") as f:
            writer = csv.writer(f)
            writer.writerow(headers)
            for r in rows:
                writer.writerow([r[h] for h in headers])
