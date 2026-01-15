from __future__ import annotations
import sqlite3


def _has_column(db: sqlite3.Connection, table: str, column: str) -> bool:
    cur = db.execute(f"PRAGMA table_info({table})")
    return any(row["name"] == column for row in cur.fetchall())


def _ensure_column(db: sqlite3.Connection, table: str, column: str, ddl: str) -> None:
    if not _has_column(db, table, column):
        db.execute(f"ALTER TABLE {table} ADD COLUMN {column} {ddl}")


def ensure_schema(db: sqlite3.Connection) -> None:
    db.executescript(
        """
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
        cloze TEXT,
        answer TEXT,
        kind TEXT NOT NULL DEFAULT 'example', -- example | user
        created_at TEXT NOT NULL,
        FOREIGN KEY(item_id) REFERENCES items(id) ON DELETE SET NULL
    );

    CREATE TABLE IF NOT EXISTS errors (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_id INTEGER,
        source TEXT NOT NULL CHECK(source IN ('C','D')), -- luyen cau / thi thu
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

    CREATE TABLE IF NOT EXISTS attempts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_id INTEGER,
        card_id INTEGER,
        sentence_id INTEGER,
        test_id INTEGER,
        test_attempt_id INTEGER,
        source TEXT NOT NULL CHECK(source IN ('srs','sentence','test','quiz','manual')),
        prompt TEXT,
        response TEXT,
        expected TEXT,
        is_correct INTEGER,
        score REAL,
        duration_ms INTEGER,
        created_at TEXT NOT NULL,
        FOREIGN KEY(item_id) REFERENCES items(id) ON DELETE SET NULL,
        FOREIGN KEY(card_id) REFERENCES cards(id) ON DELETE SET NULL,
        FOREIGN KEY(sentence_id) REFERENCES sentences(id) ON DELETE SET NULL,
        FOREIGN KEY(test_id) REFERENCES tests(id) ON DELETE SET NULL,
        FOREIGN KEY(test_attempt_id) REFERENCES test_attempts(id) ON DELETE SET NULL
    );

    CREATE TABLE IF NOT EXISTS mistakes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_id INTEGER NOT NULL,
        card_id INTEGER,
        source TEXT NOT NULL CHECK(source IN ('srs','sentence','test','quiz','manual')),
        mistake_count INTEGER NOT NULL DEFAULT 1,
        last_mistake_at TEXT NOT NULL,
        last_attempt_id INTEGER,
        FOREIGN KEY(item_id) REFERENCES items(id) ON DELETE CASCADE,
        FOREIGN KEY(card_id) REFERENCES cards(id) ON DELETE SET NULL,
        FOREIGN KEY(last_attempt_id) REFERENCES attempts(id) ON DELETE SET NULL,
        UNIQUE(item_id, source)
    );

    CREATE INDEX IF NOT EXISTS idx_cards_due ON cards(due_date);
    CREATE INDEX IF NOT EXISTS idx_items_type ON items(item_type);
    CREATE INDEX IF NOT EXISTS idx_errors_item ON errors(item_id);
    CREATE INDEX IF NOT EXISTS idx_review_logs_date ON review_logs(substr(created_at,1,10));
    CREATE INDEX IF NOT EXISTS idx_attempts_item ON attempts(item_id);
    CREATE INDEX IF NOT EXISTS idx_attempts_card ON attempts(card_id);
    CREATE INDEX IF NOT EXISTS idx_attempts_created ON attempts(substr(created_at,1,10));
    CREATE INDEX IF NOT EXISTS idx_mistakes_item ON mistakes(item_id);
    CREATE INDEX IF NOT EXISTS idx_mistakes_last ON mistakes(last_mistake_at DESC);
    """
    )

    _ensure_column(db, "sentences", "cloze", "TEXT")
    _ensure_column(db, "sentences", "answer", "TEXT")

    db.commit()
