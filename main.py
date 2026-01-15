import sys
from PySide6.QtWidgets import QApplication
from app.ui.main_window import MainWindow
from app.db.database import get_db, init_db

def main():
    app = QApplication(sys.argv)

    db = get_db()
    init_db(db)

    win = MainWindow(db=db)
    win.show()
    sys.exit(app.exec())

if __name__ == "__main__":
    main()
