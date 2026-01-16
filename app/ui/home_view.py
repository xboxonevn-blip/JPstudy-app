from __future__ import annotations
import sqlite3
import csv
from typing import Callable, List, Optional
from PySide6.QtWidgets import QWidget, QVBoxLayout, QLabel, QFrame, QPushButton, QFileDialog
from PySide6.QtCore import Qt
try:
    from PySide6.QtCharts import QChart, QChartView, QBarSet, QBarSeries, QBarCategoryAxis, QValueAxis, QLineSeries
except Exception:
    QChart = None  # type: ignore

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
        self.chart_view: Optional[QChartView] = None

        layout = QVBoxLayout(self)
        layout.setSpacing(12)

        title = QLabel("Daily Plan - (A) Import + (B) SRS + (C) Cloze + (D) Test")
        title.setProperty("role", "title")
        layout.addWidget(title)

        self.stats = QLabel("")
        self.stats.setProperty("role", "subtitle")
        layout.addWidget(self.stats)

        self.review_stats = QLabel("")
        self.review_stats.setProperty("role", "subtitle")
        layout.addWidget(self.review_stats)

        self.level_stats = QLabel("")
        self.level_stats.setProperty("role", "subtitle")
        layout.addWidget(self.level_stats)

        self.daily_stats = QLabel("")
        self.daily_stats.setProperty("role", "subtitle")
        layout.addWidget(self.daily_stats)

        if QChart:
            self.chart_view = QChartView()
            self.chart_view.setMinimumHeight(220)
            layout.addWidget(self.chart_view)

        card = QFrame()
        card.setProperty("role", "card")
        card.setFrameShape(QFrame.StyledPanel)
        card_layout = QVBoxLayout(card)
        card_layout.setSpacing(10)

        self.btn_start_srs = QPushButton("Start SRS (due today)")
        self.btn_start_srs.clicked.connect(lambda: self.on_navigate("srs"))
        self.btn_start_import = QPushButton("Import data (CSV / Add)")
        self.btn_start_import.clicked.connect(lambda: self.on_navigate("import"))
        self.btn_export = QPushButton("Export attempts CSV (30 days)")
        self.btn_export.clicked.connect(self.export_csv)

        self.btn_start_srs.setCursor(Qt.PointingHandCursor)
        self.btn_start_import.setCursor(Qt.PointingHandCursor)
        self.btn_export.setCursor(Qt.PointingHandCursor)

        card_layout.addWidget(self.btn_start_srs)
        card_layout.addWidget(self.btn_start_import)
        card_layout.addWidget(self.btn_export)

        layout.addWidget(card)

        tips = QLabel(
            "Tip: After import, cards get scheduled for today immediately.\n"
            "Goal: do SRS daily, then expand with Cloze/Test."
        )
        tips.setProperty("role", "subtitle")
        layout.addWidget(tips)

        layout.addStretch(1)
        self.refresh()

    def refresh(self) -> None:
        due = count_due_cards(self.db)
        items = count_items(self.db)
        self.stats.setText(f"Total items: {items} | Due today: {due}")

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
                source_parts.append(f"{lbl}: {data['total']} ({data['accuracy']:.0f}% correct)")
        extra_sources = [k for k in activity["by_source"].keys() if k not in labels]
        for src in extra_sources:
            data = activity["by_source"][src]
            source_parts.append(f"{src}: {data['total']} ({data['accuracy']:.0f}% correct)")
        source_text = " | ".join(source_parts) if source_parts else "No activity yet"
        self.review_stats.setText(
            f"Today: {activity['total']} | Acc: {activity['accuracy']:.1f}% | {source_text} | "
            f"Streak: {streak} days | Goal: {daily_goal}/day"
        )

        level_counts = get_level_breakdown(self.db, due_only=True)
        leech_due = get_leech_due_count(self.db)
        level_text = " | ".join([f"{lvl}: {level_counts[lvl]}" for lvl in ["N5", "N4", "N3", "N2", "N1"]])
        self.level_stats.setText(
            f"Leech due: {leech_due} | Due by level: {level_text} | SRS reviews: {review['total']} ({review['accuracy']:.1f}% acc)"
        )

        timeseries = get_attempt_timeseries(self.db, days=7)
        if timeseries:
            lines: List[str] = []
            for row in timeseries:
                lines.append(f"{row['date']}: {row['total']} ({row['accuracy']:.0f}% correct)")
            self.daily_stats.setText("Last 7 days: " + " | ".join(lines))
            self._update_chart(timeseries)
        else:
            self.daily_stats.setText("No activity in the last 7 days.")
            if self.chart_view:
                self.chart_view.setChart(QChart())

        self.btn_start_srs.setEnabled(due > 0)

    def export_csv(self) -> None:
        path, _ = QFileDialog.getSaveFileName(
            self, "Save attempts CSV", "", "CSV Files (*.csv);;All Files (*)"
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

    def _update_chart(self, timeseries: List[dict]) -> None:
        if not self.chart_view or not QChart:
            return
        chart = QChart()
        chart.setAnimationOptions(QChart.SeriesAnimations)
        categories = [row["date"] for row in reversed(timeseries)]

        bar_set = QBarSet("Attempts")
        for row in reversed(timeseries):
            bar_set << row["total"]
        bar_series = QBarSeries()
        bar_series.append(bar_set)

        line_series = QLineSeries()
        line_series.setName("Accuracy %")
        for idx, row in enumerate(reversed(timeseries)):
            line_series.append(idx, row["accuracy"])

        chart.addSeries(bar_series)
        chart.addSeries(line_series)

        axis_x = QBarCategoryAxis()
        axis_x.append(categories)
        chart.addAxis(axis_x, Qt.AlignBottom)
        bar_series.attachAxis(axis_x)
        line_series.attachAxis(axis_x)

        axis_y = QValueAxis()
        axis_y.setTitleText("Attempts")
        chart.addAxis(axis_y, Qt.AlignLeft)
        bar_series.attachAxis(axis_y)

        axis_y2 = QValueAxis()
        axis_y2.setRange(0, 100)
        axis_y2.setTitleText("Accuracy %")
        chart.addAxis(axis_y2, Qt.AlignRight)
        line_series.attachAxis(axis_y2)

        chart.setTitle("Last 7 days")
        self.chart_view.setChart(chart)
