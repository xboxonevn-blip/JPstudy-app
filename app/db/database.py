from __future__ import annotations
import os
import sqlite3
from typing import Optional

_DB_CONN: Optional[sqlite3.Connection] = None

def _project_root() -> str:
    # root is folder containing main.py
    return os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))

def _db_path() -> str:
    root = _project_root()
    data_dir = os.path.join(root, "app_data")
    os.makedirs(data_dir, exist_ok=True)
    return os.path.join(data_dir, "app.db")

def get_db() -> sqlite3.Connection:
    global _DB_CONN
    if _DB_CONN is None:
        path = _db_path()
        _DB_CONN = sqlite3.connect(path)
        _DB_CONN.row_factory = sqlite3.Row
        _DB_CONN.execute("PRAGMA foreign_keys = ON;")
    return _DB_CONN

def init_db(db: sqlite3.Connection) -> None:
    # idempotent schema creation
    from .schema import ensure_schema
    ensure_schema(db)


def new_db_connection() -> sqlite3.Connection:
    """
    Create a new SQLite connection for background work (thread-safe).
    """
    path = _db_path()
    conn = sqlite3.connect(path, check_same_thread=False)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys = ON;")
    return conn
