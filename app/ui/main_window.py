from __future__ import annotations
import sqlite3
from PySide6.QtWidgets import (
    QFrame,
    QHBoxLayout,
    QLabel,
    QMainWindow,
    QPushButton,
    QStackedWidget,
    QVBoxLayout,
    QWidget,
)
from PySide6.QtCore import Qt

from app.ui.home_view import HomeView
from app.ui.import_view import ImportView
from app.ui.srs_view import SrsReviewView
from app.ui.cloze_view import ClozePracticeView
from app.ui.test_view import MiniTestView


class MainWindow(QMainWindow):
    def __init__(self, db: sqlite3.Connection):
        super().__init__()
        self.db = db
        self.setWindowTitle("JP Study - A/B/C/D")
        self.resize(980, 640)

        self._apply_theme()

        root = QWidget()
        self.setCentralWidget(root)

        self.stack = QStackedWidget()

        self.home = HomeView(db=self.db, on_navigate=self.navigate)
        self.import_view = ImportView(db=self.db, on_navigate=self.navigate)
        self.srs_view = SrsReviewView(db=self.db, on_navigate=self.navigate)
        self.cloze_view = ClozePracticeView(db=self.db, on_navigate=self.navigate)
        self.test_view = MiniTestView(db=self.db, on_navigate=self.navigate)

        self.stack.addWidget(self.home)
        self.stack.addWidget(self.import_view)
        self.stack.addWidget(self.srs_view)
        self.stack.addWidget(self.cloze_view)
        self.stack.addWidget(self.test_view)

        layout = QVBoxLayout(root)
        layout.setContentsMargins(12, 12, 12, 12)
        layout.setSpacing(10)

        # Nav bar
        self.btn_home = QPushButton("Home")
        self.btn_import = QPushButton("A - Import")
        self.btn_srs = QPushButton("B - SRS")
        self.btn_c = QPushButton("C - Cloze")
        self.btn_d = QPushButton("D - Test")

        self.nav_buttons = {
            "home": self.btn_home,
            "import": self.btn_import,
            "srs": self.btn_srs,
            "cloze": self.btn_c,
            "test": self.btn_d,
        }
        for b in self.nav_buttons.values():
            b.setCursor(Qt.PointingHandCursor)
            b.setProperty("role", "nav")

        self.btn_home.clicked.connect(lambda: self.navigate("home"))
        self.btn_import.clicked.connect(lambda: self.navigate("import"))
        self.btn_srs.clicked.connect(lambda: self.navigate("srs"))
        self.btn_c.clicked.connect(lambda: self.navigate("cloze"))
        self.btn_d.clicked.connect(lambda: self.navigate("test"))

        nav_frame = QFrame()
        nav_frame.setProperty("role", "nav-bar")
        nav_layout = QHBoxLayout(nav_frame)
        nav_layout.setContentsMargins(10, 6, 10, 6)
        nav_layout.setSpacing(8)
        nav_brand = QLabel("JP Study")
        nav_brand.setProperty("role", "title")
        nav_layout.addWidget(nav_brand)
        nav_layout.addSpacing(6)
        nav_layout.addWidget(self.btn_home)
        nav_layout.addWidget(self.btn_import)
        nav_layout.addWidget(self.btn_srs)
        nav_layout.addWidget(self.btn_c)
        nav_layout.addWidget(self.btn_d)
        nav_layout.addStretch(1)

        layout.addWidget(nav_frame)
        layout.addWidget(self.stack, 1)

        self.navigate("home")

    def _apply_theme(self) -> None:
        """Apply an Anki-inspired neutral palette and pill buttons."""
        self.setStyleSheet(
            """
QMainWindow, QWidget {
    background: #e7eaef;
    color: #1f2733;
    font-family: "Segoe UI", "Noto Sans", sans-serif;
    font-size: 13px;
}

QFrame[role="nav-bar"] {
    background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #f7f9fc, stop:1 #dfe4ed);
    border: 1px solid #c4ccda;
    border-radius: 8px;
    padding: 6px 8px;
}

QPushButton {
    background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #f8fafd, stop:1 #e4e8f1);
    border: 1px solid #bdc6d6;
    border-radius: 5px;
    padding: 6px 12px;
}
QPushButton:hover { background: #fdfefe; border-color: #9fb0c8; }
QPushButton:pressed { background: #d4dbea; }

QPushButton[role="nav"] {
    min-width: 92px;
    font-weight: 600;
    color: #1e2b3a;
}
QPushButton[role="nav"][active="true"] {
    background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #3d5b8c, stop:1 #2f456d);
    border-color: #2a3d60;
    color: #f6f8fb;
}

QPushButton[role="grade-again"] {
    background: #d9534f;
    border-color: #c13c39;
    color: #fff;
    font-weight: 700;
}
QPushButton[role="grade-hard"] {
    background: #f0ad4e;
    border-color: #d18c25;
    color: #3b2a00;
    font-weight: 700;
}
QPushButton[role="grade-good"] {
    background: #5cb85c;
    border-color: #469e46;
    color: #fff;
    font-weight: 700;
}
QPushButton[role="grade-easy"] {
    background: #5bc0de;
    border-color: #3aa5c5;
    color: #0e2b3a;
    font-weight: 700;
}
QPushButton[role="grade-again"]:hover { background: #e16560; }
QPushButton[role="grade-hard"]:hover { background: #f2b863; }
QPushButton[role="grade-good"]:hover { background: #6bc36b; }
QPushButton[role="grade-easy"]:hover { background: #6ecae4; }

QFrame[role="card"] {
    background: #fdfdff;
    border: 1px solid #cfd7e3;
    border-radius: 10px;
    padding: 14px;
}

QLabel[role="title"] {
    font-size: 19px;
    font-weight: 700;
    color: #1f3d68;
}
QLabel[role="subtitle"] {
    color: #4b5563;
    font-size: 13px;
}

QLineEdit, QComboBox, QTextEdit, QSpinBox, QTableWidget, QTableView {
    background: #fefefe;
    border: 1px solid #c7d0de;
    border-radius: 6px;
    padding: 6px;
}

QTableWidget::item {
    padding: 6px 4px;
}
"""
        )

    def navigate(self, route: str) -> None:
        route = (route or "").lower().strip()
        self._set_active_nav(route)
        if route == "home":
            self.home.refresh()
            self.stack.setCurrentWidget(self.home)
        elif route == "import":
            self.import_view.refresh()
            self.stack.setCurrentWidget(self.import_view)
        elif route == "srs":
            self.srs_view.refresh()
            self.stack.setCurrentWidget(self.srs_view)
        elif route == "cloze":
            self.cloze_view.refresh()
            self.stack.setCurrentWidget(self.cloze_view)
        elif route == "test":
            self.test_view.start_new_test()
            self.stack.setCurrentWidget(self.test_view)
        else:
            self.home.refresh()
            self.stack.setCurrentWidget(self.home)

    def _set_active_nav(self, route: str) -> None:
        for key, btn in self.nav_buttons.items():
            btn.setProperty("active", key == route)
            btn.style().unpolish(btn)
            btn.style().polish(btn)
            btn.update()
