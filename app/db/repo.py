from __future__ import annotations
import sqlite3
from typing import List, Optional, Dict, Any, Iterable
from app.core.time_utils import today_date_str, now_iso, add_days

def create_item_with_card(
    db: sqlite3.Connection,
    item_type: str,
    term: str,
    reading: str,
    meaning: str,
    example: str = "",
    tags: str = ""
) -> int:
    cur = db.cursor()
    cur.execute(
        """INSERT INTO items(item_type, term, reading, meaning, example, tags, created_at)
             VALUES(?,?,?,?,?,?,?)""",
        (item_type, term, reading, meaning, example, tags, now_iso()),
    )
    item_id = cur.lastrowid

    # Create an initial card due today (so it appears in SRS queue immediately)
    cur.execute(
        """INSERT INTO cards(item_id, due_date, interval_days, ease, lapses, last_grade, is_leech, created_at, updated_at)
             VALUES(?,?,?,?,?,?,?,?,?)""",
        (item_id, today_date_str(), 0, 2.2, 0, None, 0, now_iso(), now_iso()),
    )

    # Store example sentence if present
    if example and example.strip():
        cur.execute(
            """INSERT INTO sentences(item_id, sentence, kind, created_at)
                 VALUES(?,?,?,?)""",
            (item_id, example.strip(), "example", now_iso()),
        )

    db.commit()
    return int(item_id)

def count_due_cards(db: sqlite3.Connection, date_str: Optional[str] = None) -> int:
    date_str = date_str or today_date_str()
    cur = db.execute("SELECT COUNT(*) AS c FROM cards WHERE due_date <= ?", (date_str,))
    return int(cur.fetchone()[0])

def count_items(db: sqlite3.Connection) -> int:
    cur = db.execute("SELECT COUNT(*) AS c FROM items")
    return int(cur.fetchone()[0])

def fetch_due_cards(db: sqlite3.Connection, limit: int = 50, leech_only: bool = False) -> List[sqlite3.Row]:
    # Fetch due cards joined with item fields
    query = """
        SELECT c.*, i.item_type, i.term, i.reading, i.meaning, i.example, i.tags
        FROM cards c
        JOIN items i ON i.id = c.item_id
        WHERE c.due_date <= ?
    """
    params: List[Any] = [today_date_str()]
    if leech_only:
        query += " AND c.is_leech = 1"
    query += " ORDER BY c.is_leech DESC, c.lapses DESC, c.due_date ASC, c.id ASC LIMIT ?"
    params.append(limit)
    cur = db.execute(query, params)
    return list(cur.fetchall())

def update_card(
    db: sqlite3.Connection,
    card_id: int,
    due_date: str,
    interval_days: int,
    ease: float,
    lapses: int,
    last_grade: str,
    is_leech: int
) -> None:
    db.execute(
        """UPDATE cards
             SET due_date=?, interval_days=?, ease=?, lapses=?, last_grade=?, is_leech=?, updated_at=?
             WHERE id=?""",
        (due_date, interval_days, ease, lapses, last_grade, is_leech, now_iso(), card_id),
    )
    db.commit()


def log_review(db: sqlite3.Connection, card_id: int, grade: str, is_correct: bool) -> None:
    db.execute(
        """INSERT INTO review_logs(card_id, grade, is_correct, created_at)
             VALUES(?,?,?,?)""",
        (card_id, grade, 1 if is_correct else 0, now_iso()),
    )
    db.commit()


def get_review_stats(db: sqlite3.Connection, date_str: Optional[str] = None) -> Dict[str, Any]:
    date_str = date_str or today_date_str()
    cur = db.execute(
        """SELECT COUNT(*) AS total, SUM(is_correct) AS correct
             FROM review_logs
             WHERE substr(created_at,1,10)=?""",
        (date_str,),
    )
    row = cur.fetchone()
    total = int(row["total"] or 0)
    correct = int(row["correct"] or 0)
    accuracy = (correct / total * 100) if total > 0 else 0.0
    return {"date": date_str, "total": total, "correct": correct, "accuracy": accuracy}


def get_streak(db: sqlite3.Connection, max_days: int = 60) -> int:
    # Count consecutive days (including today) with at least one review log
    streak = 0
    today = today_date_str()
    cur_date = today
    for _ in range(max_days):
        cur = db.execute(
            "SELECT 1 FROM review_logs WHERE substr(created_at,1,10)=? LIMIT 1",
            (cur_date,),
        )
        if cur.fetchone() is None:
            break
        streak += 1
        cur_date = add_days(cur_date, -1)
    return streak


def get_level_breakdown(db: sqlite3.Connection, due_only: bool = True) -> Dict[str, int]:
    """
    Count cards per JLPT tag (N5..N1). Very lightweight, using tags text.
    If due_only=True, only counts cards due today or earlier.
    """
    levels = ["N5", "N4", "N3", "N2", "N1"]
    counts = {lvl: 0 for lvl in levels}
    if due_only:
        rows = fetch_due_cards(db, limit=10000, leech_only=False)
    else:
        cur = db.execute(
            """SELECT c.*, i.tags
                 FROM cards c JOIN items i ON i.id = c.item_id"""
        )
        rows = cur.fetchall()
    for row in rows:
        tags = (row["tags"] or "")
        for lvl in levels:
            if lvl.lower() in tags.lower():
                counts[lvl] += 1
    return counts


def get_leech_due_count(db: sqlite3.Connection) -> int:
    cur = db.execute(
        "SELECT COUNT(*) AS c FROM cards WHERE is_leech=1 AND due_date <= ?",
        (today_date_str(),),
    )
    return int(cur.fetchone()[0])


def get_items_by_ids(db: sqlite3.Connection, ids: Iterable[int]) -> List[sqlite3.Row]:
    ids = list(ids)
    if not ids:
        return []
    placeholders = ",".join("?" for _ in ids)
    cur = db.execute(
        f"SELECT * FROM items WHERE id IN ({placeholders}) ORDER BY id DESC",
        ids,
    )
    return list(cur.fetchall())
