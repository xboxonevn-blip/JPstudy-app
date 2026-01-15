from __future__ import annotations
import sqlite3
from typing import List, Optional, Dict, Any, Iterable, Tuple
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
        cloze, answer = build_cloze(example.strip(), term.strip())
        cur.execute(
            """INSERT INTO sentences(item_id, sentence, cloze, answer, kind, created_at)
                 VALUES(?,?,?,?,?,?)""",
            (item_id, example.strip(), cloze, answer, "example", now_iso()),
        )

    db.commit()
    return int(item_id)


def build_cloze(sentence: str, answer: str) -> Tuple[str, str]:
    """
    Create a simple cloze by replacing the first occurrence of the answer with ____.
    If the answer is not found, blank out the first token as a fallback.
    """
    placeholder = "____"
    sentence = sentence or ""
    ans = (answer or "").strip()
    if ans and ans in sentence:
        return (sentence.replace(ans, placeholder, 1), ans)
    parts = sentence.split()
    if parts:
        parts[0] = placeholder
        return (" ".join(parts), ans)
    return (placeholder, ans)

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


def record_attempt(
    db: sqlite3.Connection,
    source: str,
    item_id: Optional[int] = None,
    card_id: Optional[int] = None,
    sentence_id: Optional[int] = None,
    test_id: Optional[int] = None,
    test_attempt_id: Optional[int] = None,
    prompt: str = "",
    response: str = "",
    expected: str = "",
    is_correct: Optional[bool] = None,
    score: Optional[float] = None,
    duration_ms: Optional[int] = None,
    commit: bool = True
) -> int:
    correct_val = None
    if is_correct is True:
        correct_val = 1
    elif is_correct is False:
        correct_val = 0

    cur = db.execute(
        """INSERT INTO attempts(
                item_id, card_id, sentence_id, test_id, test_attempt_id,
                source, prompt, response, expected, is_correct, score, duration_ms, created_at
            )
            VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)""",
        (
            item_id,
            card_id,
            sentence_id,
            test_id,
            test_attempt_id,
            source,
            prompt,
            response,
            expected,
            correct_val,
            score,
            duration_ms,
            now_iso(),
        ),
    )
    attempt_id = int(cur.lastrowid)
    if commit:
        db.commit()
    return attempt_id


def record_mistake(
    db: sqlite3.Connection,
    item_id: int,
    source: str,
    card_id: Optional[int] = None,
    last_attempt_id: Optional[int] = None,
    commit: bool = True
) -> int:
    now = now_iso()
    cur = db.execute(
        "SELECT id, mistake_count FROM mistakes WHERE item_id=? AND source=?",
        (item_id, source),
    )
    row = cur.fetchone()
    if row:
        mistake_id = int(row["id"])
        count = int(row["mistake_count"] or 0) + 1
        db.execute(
            """UPDATE mistakes
                 SET mistake_count=?, last_mistake_at=?, card_id=COALESCE(?, card_id), last_attempt_id=?
                 WHERE id=?""",
            (count, now, card_id, last_attempt_id, mistake_id),
        )
    else:
        cur = db.execute(
            """INSERT INTO mistakes(item_id, card_id, source, mistake_count, last_mistake_at, last_attempt_id)
                 VALUES(?,?,?,?,?,?)""",
            (item_id, card_id, source, 1, now, last_attempt_id),
        )
        mistake_id = int(cur.lastrowid)

    if commit:
        db.commit()
    return mistake_id


def log_review(
    db: sqlite3.Connection,
    card_id: int,
    grade: str,
    is_correct: bool,
    item_id: Optional[int] = None,
    prompt: str = "",
    expected: str = "",
    response: Optional[str] = None
) -> None:
    db.execute(
        """INSERT INTO review_logs(card_id, grade, is_correct, created_at)
             VALUES(?,?,?,?)""",
        (card_id, grade, 1 if is_correct else 0, now_iso()),
    )

    attempt_id = record_attempt(
        db,
        source="srs",
        item_id=item_id,
        card_id=card_id,
        prompt=prompt,
        response=response or grade,
        expected=expected,
        is_correct=is_correct,
        commit=False,
    )

    if (item_id is not None) and not is_correct:
        record_mistake(
            db,
            item_id=item_id,
            source="srs",
            card_id=card_id,
            last_attempt_id=attempt_id,
            commit=False,
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


def get_cloze_queue(db: sqlite3.Connection, limit: int = 50) -> List[Dict[str, Any]]:
    """
    Fetch sentences with cloze/answer for practice, prioritizing items with mistakes (sentence/test).
    """
    cur = db.execute(
        """
        SELECT
            s.id AS sentence_id,
            s.sentence,
            s.cloze,
            s.answer,
            i.id AS item_id,
            i.item_type,
            i.term,
            i.reading,
            i.meaning,
            i.tags,
            m.mistake_count,
            m.last_mistake_at
        FROM sentences s
        JOIN items i ON i.id = s.item_id
        LEFT JOIN mistakes m ON m.item_id = s.item_id AND m.source IN ('sentence','test')
        WHERE s.sentence IS NOT NULL AND trim(s.sentence) <> ''
        ORDER BY (m.last_mistake_at IS NOT NULL) DESC, m.last_mistake_at DESC, s.id DESC
        LIMIT ?
        """,
        (limit,),
    )
    rows = cur.fetchall()

    out: List[Dict[str, Any]] = []
    updates: List[Tuple[str, str, int]] = []  # cloze, answer, id
    for row in rows:
        cloze = row["cloze"]
        answer = row["answer"] or row["term"]
        if not cloze:
            cloze, answer = build_cloze(row["sentence"], answer)
            updates.append((cloze, answer, row["sentence_id"]))
        out.append(
            {
                "sentence_id": row["sentence_id"],
                "sentence": row["sentence"],
                "cloze": cloze,
                "answer": answer,
                "item_id": row["item_id"],
                "item_type": row["item_type"],
                "term": row["term"],
                "reading": row["reading"],
                "meaning": row["meaning"],
                "tags": row["tags"],
                "mistake_count": row["mistake_count"],
                "last_mistake_at": row["last_mistake_at"],
            }
        )

    if updates:
        db.executemany(
            "UPDATE sentences SET cloze=?, answer=? WHERE id=?",
            updates,
        )
        db.commit()

    return out


def get_or_create_test(db: sqlite3.Connection, title: str = "Mini Test") -> int:
    cur = db.execute("SELECT id FROM tests WHERE title=? LIMIT 1", (title,))
    row = cur.fetchone()
    if row:
        return int(row["id"])
    cur = db.execute(
        "INSERT INTO tests(title, created_at) VALUES(?,?)",
        (title, now_iso()),
    )
    db.commit()
    return int(cur.lastrowid)


def create_test_attempt(db: sqlite3.Connection, test_id: int, detail_json: Optional[str] = None) -> int:
    cur = db.execute(
        "INSERT INTO test_attempts(test_id, score, detail_json, created_at) VALUES(?,?,?,?)",
        (test_id, 0.0, detail_json, now_iso()),
    )
    db.commit()
    return int(cur.lastrowid)


def update_test_attempt(db: sqlite3.Connection, attempt_id: int, score: float, detail_json: Optional[str] = None) -> None:
    db.execute(
        "UPDATE test_attempts SET score=?, detail_json=? WHERE id=?",
        (score, detail_json, attempt_id),
    )
    db.commit()


def _ensure_cloze_data(row: sqlite3.Row, updates: List[Tuple[str, str, int]]) -> Tuple[str, str]:
    cloze = row["cloze"]
    answer = row["answer"] or row["term"]
    if not cloze:
        cloze, answer = build_cloze(row["sentence"], answer)
        updates.append((cloze, answer, row["sentence_id"]))
    return cloze, answer


def _question_from_row(row: sqlite3.Row, source_label: str, updates: List[Tuple[str, str, int]]) -> Dict[str, Any]:
    cloze, answer = _ensure_cloze_data(row, updates)
    card_id = None
    try:
        card_id = row["card_id"]
    except Exception:
        card_id = None
    return {
        "sentence_id": row["sentence_id"],
        "sentence": row["sentence"],
        "cloze": cloze,
        "answer": answer,
        "item_id": row["item_id"],
        "item_type": row["item_type"],
        "term": row["term"],
        "reading": row["reading"],
        "meaning": row["meaning"],
        "tags": row["tags"],
        "card_id": card_id,
        "question_source": source_label,
    }


def get_test_batch(db: sqlite3.Connection, total: int = 15) -> List[Dict[str, Any]]:
    """
    Build a mini-test batch mixing: mistakes (sentence/test/srs), due, and fresh sentences.
    """
    total = max(5, min(total, 30))
    want_mistake = min(8, total // 3 + 2)
    want_due = min(8, total // 3 + 2)
    want_new = total * 2  # grab extra then trim

    updates: List[Tuple[str, str, int]] = []
    questions: List[Dict[str, Any]] = []

    def fetch(query: str, params: tuple, label: str, limit: int) -> None:
        nonlocal questions
        cur = db.execute(query + " LIMIT ?", params + (limit,))
        for row in cur.fetchall():
            questions.append(_question_from_row(row, label, updates))

    fetch(
        """
        SELECT
            s.id AS sentence_id, s.sentence, s.cloze, s.answer,
            i.id AS item_id, i.item_type, i.term, i.reading, i.meaning, i.tags,
            NULL AS card_id
        FROM mistakes m
        JOIN sentences s ON s.item_id = m.item_id
        JOIN items i ON i.id = s.item_id
        WHERE m.source IN ('sentence','test','srs')
        ORDER BY m.last_mistake_at DESC
        """,
        tuple(),
        "mistake",
        want_mistake,
    )

    fetch(
        """
        SELECT
            s.id AS sentence_id, s.sentence, s.cloze, s.answer,
            i.id AS item_id, i.item_type, i.term, i.reading, i.meaning, i.tags,
            c.id AS card_id
        FROM cards c
        JOIN items i ON i.id = c.item_id
        JOIN sentences s ON s.item_id = c.item_id
        WHERE c.due_date <= ?
        ORDER BY c.due_date ASC
        """,
        (today_date_str(),),
        "due",
        want_due,
    )

    fetch(
        """
        SELECT
            s.id AS sentence_id, s.sentence, s.cloze, s.answer,
            i.id AS item_id, i.item_type, i.term, i.reading, i.meaning, i.tags,
            c.id AS card_id
        FROM sentences s
        JOIN items i ON i.id = s.item_id
        LEFT JOIN cards c ON c.item_id = i.id
        ORDER BY s.id DESC
        """,
        tuple(),
        "new",
        want_new,
    )

    if updates:
        db.executemany(
            "UPDATE sentences SET cloze=?, answer=? WHERE id=?",
            updates,
        )
        db.commit()

    # Deduplicate by sentence_id preserving order and trim to total
    seen = set()
    unique_questions: List[Dict[str, Any]] = []
    for q in questions:
        sid = q["sentence_id"]
        if sid in seen:
            continue
        seen.add(sid)
        unique_questions.append(q)
        if len(unique_questions) >= total:
            break

    return unique_questions
