from __future__ import annotations
import sqlite3
from PySide6.QtWidgets import QMainWindow, QWidget, QStackedWidget, QVBoxLayout, QHBoxLayout, QPushButton
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
        self.setWindowTitle("App học tiếng Nhật - A/B/C/D")
        self.resize(980, 640)

        root = QWidget()
        self.setCentralWidget(root)

        self.stack = QStackedWidget()

        self.home = HomeView(db=self.db, on_navigate=self.navigate)
        self.import_view = ImportView(db=self.db, on_navigate=self.navigate)
        self.srs_view = SrsReviewView(db=self.db, on_navigate=self.navigate)
        self.cloze_view = ClozePracticeView(db=self.db, on_navigate=self.navigate)
        self.test_view = MiniTestView(db=self.db, on_navigate=self.navigate)

        self.stack.addWidget(self.home)        # index 0
        self.stack.addWidget(self.import_view) # index 1
        self.stack.addWidget(self.srs_view)    # index 2
        self.stack.addWidget(self.cloze_view)  # index 3
        self.stack.addWidget(self.test_view)   # index 4

        layout = QVBoxLayout(root)
        layout.setContentsMargins(12, 12, 12, 12)
        layout.setSpacing(10)

        # Simple top nav
        nav = QHBoxLayout()
        nav.setSpacing(8)

        self.btn_home = QPushButton("Home")
        self.btn_import = QPushButton("A - Nhập")
        self.btn_srs = QPushButton("B - SRS")
        self.btn_c = QPushButton("C - Luyện câu")
        self.btn_d = QPushButton("D - Thi thử")

        for b in [self.btn_home, self.btn_import, self.btn_srs, self.btn_c, self.btn_d]:
            b.setCursor(Qt.PointingHandCursor)

        self.btn_home.clicked.connect(lambda: self.navigate("home"))
        self.btn_import.clicked.connect(lambda: self.navigate("import"))
        self.btn_srs.clicked.connect(lambda: self.navigate("srs"))
        self.btn_c.clicked.connect(lambda: self.navigate("cloze"))
        self.btn_d.clicked.connect(lambda: self.navigate("test"))

        nav.addWidget(self.btn_home)
        nav.addWidget(self.btn_import)
        nav.addWidget(self.btn_srs)
        nav.addWidget(self.btn_c)
        nav.addWidget(self.btn_d)
        nav.addStretch(1)

        layout.addLayout(nav)
        layout.addWidget(self.stack, 1)

        self.navigate("home")

    def navigate(self, route: str) -> None:
        route = (route or "").lower().strip()
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
