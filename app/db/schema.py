from __future__ import annotations
import sqlite3

def ensure_schema(db: sqlite3.Connection) -> None:
    db.executescript("""
    CREATE TABLE IF NOT EXISTS items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_type TEXT NOT NULL CHECK(item_type IN ('vocab','kanji','grammar')),
        term TEXT NOT NULL,
        reading TEXT,
        meaning TEXT NOT NULL,
        example TEXT,
        tags TEXT,
        created_at TEXT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS cards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_id INTEGER NOT NULL,
        due_date TEXT NOT NULL,
        interval_days INTEGER NOT NULL DEFAULT 0,
        ease REAL NOT NULL DEFAULT 2.2,
        lapses INTEGER NOT NULL DEFAULT 0,
        last_grade TEXT,
        is_leech INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY(item_id) REFERENCES items(id) ON DELETE CASCADE
    );

    CREATE TABLE IF NOT EXISTS sentences (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_id INTEGER,
        sentence TEXT NOT NULL,
        kind TEXT NOT NULL DEFAULT 'example', -- example | user
        created_at TEXT NOT NULL,
        FOREIGN KEY(item_id) REFERENCES items(id) ON DELETE SET NULL
    );

    CREATE TABLE IF NOT EXISTS errors (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_id INTEGER,
        source TEXT NOT NULL CHECK(source IN ('C','D')), -- luyện câu / thi thử
        error_type TEXT NOT NULL,
        note TEXT,
        created_at TEXT NOT NULL,
        resolved INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY(item_id) REFERENCES items(id) ON DELETE SET NULL
    );

    CREATE TABLE IF NOT EXISTS tests (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        created_at TEXT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS test_attempts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        test_id INTEGER,
        score REAL NOT NULL DEFAULT 0,
        detail_json TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY(test_id) REFERENCES tests(id) ON DELETE SET NULL
    );

    CREATE TABLE IF NOT EXISTS review_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        card_id INTEGER NOT NULL,
        grade TEXT NOT NULL,
        is_correct INTEGER NOT NULL,
        created_at TEXT NOT NULL,
        FOREIGN KEY(card_id) REFERENCES cards(id) ON DELETE CASCADE
    );

    CREATE INDEX IF NOT EXISTS idx_cards_due ON cards(due_date);
    CREATE INDEX IF NOT EXISTS idx_items_type ON items(item_type);
    CREATE INDEX IF NOT EXISTS idx_errors_item ON errors(item_id);
    CREATE INDEX IF NOT EXISTS idx_review_logs_date ON review_logs(substr(created_at,1,10));
    """)
    db.commit()
