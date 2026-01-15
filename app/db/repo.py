from __future__ import annotations
import re
import sqlite3
from typing import List, Optional, Dict, Any, Iterable, Tuple, Sequence
from app.core.time_utils import today_date_str, now_iso, add_days

def _normalize_key(term: str, reading: str) -> Tuple[str, str]:
    return term.strip(), (reading or "").strip()


def _merge_tags(existing: str, new: str) -> str:
    parts: List[str] = []
    seen = set()
    for raw in (existing or "").split(",") + (new or "").split(","):
        tag = raw.strip()
        if not tag:
            continue
        key = tag.lower()
        if key in seen:
            continue
        seen.add(key)
        parts.append(tag)
    return ", ".join(parts)


def _find_item_by_term_reading(db: sqlite3.Connection, term: str, reading: str) -> Optional[sqlite3.Row]:
    term_key, reading_key = _normalize_key(term, reading)
    cur = db.execute(
        """
        SELECT *
        FROM items
        WHERE lower(term)=lower(?) AND lower(COALESCE(reading,''))=lower(?)
        LIMIT 1
        """,
        (term_key, reading_key),
    )
    return cur.fetchone()


def _ensure_card_for_item(db: sqlite3.Connection, item_id: int) -> None:
    cur = db.execute("SELECT id FROM cards WHERE item_id=? LIMIT 1", (item_id,))
    if cur.fetchone() is None:
        db.execute(
            """INSERT INTO cards(item_id, due_date, interval_days, ease, lapses, last_grade, is_leech, created_at, updated_at)
                 VALUES(?,?,?,?,?,?,?,?,?)""",
            (item_id, today_date_str(), 0, 2.2, 0, None, 0, now_iso(), now_iso()),
        )


def _ensure_sentence_for_item(db: sqlite3.Connection, item_id: int, sentence: str, answer: str) -> None:
    sentence = sentence.strip()
    if not sentence:
        return
    cur = db.execute(
        "SELECT 1 FROM sentences WHERE item_id=? AND sentence=? LIMIT 1",
        (item_id, sentence),
    )
    if cur.fetchone() is not None:
        return
    cloze, ans = build_cloze(sentence, answer)
    db.execute(
        """INSERT INTO sentences(item_id, sentence, cloze, answer, kind, created_at)
             VALUES(?,?,?,?,?,?)""",
        (item_id, sentence, cloze, ans, "example", now_iso()),
    )


def create_item_with_card(
    db: sqlite3.Connection,
    item_type: str,
    term: str,
    reading: str,
    meaning: str,
    example: str = "",
    tags: str = ""
) -> Tuple[int, bool]:
    term = term.strip()
    reading = (reading or "").strip()
    meaning = meaning.strip()
    example = (example or "").strip()
    tags = (tags or "").strip()

    # Dedupe by term + reading
    existing = _find_item_by_term_reading(db, term, reading)
    if existing:
        item_id = int(existing["id"])
        merged_tags = _merge_tags(existing.get("tags") or "", tags)
        updates = {}
        if merged_tags != (existing.get("tags") or ""):
            updates["tags"] = merged_tags
        if example and not (existing.get("example") or "").strip():
            updates["example"] = example
        if meaning and not (existing.get("meaning") or "").strip():
            updates["meaning"] = meaning
        if updates:
            sets = ", ".join(f"{k}=?" for k in updates.keys())
            db.execute(f"UPDATE items SET {sets} WHERE id=?", (*updates.values(), item_id))
        if example:
            _ensure_sentence_for_item(db, item_id=item_id, sentence=example, answer=term)
        _ensure_card_for_item(db, item_id)
        db.commit()
        return item_id, False

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
    return int(item_id), True


_JP_TOKEN = re.compile(r"[\u3400-\u9FFF\u3040-\u30FF\u3005\u30FC]+")


def build_cloze_preview(sentence: str, answer: str) -> Tuple[str, str, bool, str]:
    """
    Create a cloze and report whether a fallback was used.
    Returns (cloze, answer, used_fallback, reason).
    """
    placeholder = "____"
    sentence = sentence or ""
    ans = (answer or "").strip()
    if ans and ans in sentence:
        return (sentence.replace(ans, placeholder, 1), ans, False, "exact-term")

    m = _JP_TOKEN.search(sentence)
    if m:
        target = m.group(0)
        return (sentence.replace(target, placeholder, 1), ans or target, True, "jp-token")

    stripped = sentence.strip()
    if stripped:
        target = stripped[:2] if len(stripped) > 1 else stripped
        return (sentence.replace(target, placeholder, 1), ans or target, True, "prefix")

    return (placeholder, ans, True, "empty")


def build_cloze(sentence: str, answer: str) -> Tuple[str, str]:
    cloze, ans, _, _ = build_cloze_preview(sentence, answer)
    return cloze, ans


def _tag_tokens(tags: str) -> List[str]:
    parts = re.split(r"[,\s/|]+", tags or "")
    cleaned = []
    for p in parts:
        token = p.strip().strip("#[]()")
        if token:
            cleaned.append(token)
    return cleaned

def count_due_cards(db: sqlite3.Connection, date_str: Optional[str] = None) -> int:
    date_str = date_str or today_date_str()
    cur = db.execute("SELECT COUNT(*) AS c FROM cards WHERE due_date <= ?", (date_str,))
    return int(cur.fetchone()[0])

def count_items(db: sqlite3.Connection) -> int:
    cur = db.execute("SELECT COUNT(*) AS c FROM items")
    return int(cur.fetchone()[0])

def _apply_tag_filter_sql(
    base_query: str,
    params: List[Any],
    tag_filter: Optional[str],
    level_filter: Optional[str],
) -> Tuple[str, List[Any]]:
    if tag_filter:
        base_query += " AND lower(COALESCE(i.tags,'')) LIKE '%'||lower(?)||'%'"
        params.append(tag_filter.strip())
    if level_filter:
        lvl = level_filter.strip()
        if lvl:
            base_query += " AND (','||lower(COALESCE(i.tags,''))||',') LIKE '%'||lower(?)||'%'"
            params.append(lvl)
    return base_query, params


def fetch_due_cards(
    db: sqlite3.Connection,
    limit: int = 50,
    leech_only: bool = False,
    tag_filter: Optional[str] = None,
    level_filter: Optional[str] = None,
) -> List[sqlite3.Row]:
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
    query, params = _apply_tag_filter_sql(query, params, tag_filter, level_filter)
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


def record_error(
    db: sqlite3.Connection,
    item_id: Optional[int],
    source: str,
    error_type: str,
    note: str = "",
    commit: bool = True,
) -> Optional[int]:
    """
    Log into errors table for post-mortem analysis.
    """
    if item_id is None:
        return None
    cur = db.execute(
        """INSERT INTO errors(item_id, source, error_type, note, created_at, resolved)
             VALUES(?,?,?,?,?,0)""",
        (item_id, source, error_type, note, now_iso()),
    )
    if commit:
        db.commit()
    return int(cur.lastrowid)


def resolve_errors_for_item(
    db: sqlite3.Connection,
    item_id: int,
    source: Optional[str] = None,
    commit: bool = True,
) -> int:
    """
    Mark errors as resolved when user answers correctly later.
    """
    if source:
        cur = db.execute("UPDATE errors SET resolved=1 WHERE item_id=? AND source=?", (item_id, source))
    else:
        cur = db.execute("UPDATE errors SET resolved=1 WHERE item_id=?", (item_id,))
    if commit:
        db.commit()
    return cur.rowcount


def resolve_mistake(
    db: sqlite3.Connection,
    item_id: int,
    source: str,
    reduce_by: int = 1,
    commit: bool = True
) -> bool:
    """
    Decrease mistake count for an item/source. Deletes row when it reaches zero.
    """
    cur = db.execute(
        "SELECT id, mistake_count FROM mistakes WHERE item_id=? AND source=?",
        (item_id, source),
    )
    row = cur.fetchone()
    if row is None:
        return False

    current = int(row["mistake_count"] or 0)
    new_count = max(0, current - max(1, reduce_by))
    mistake_id = int(row["id"])
    if new_count <= 0:
        db.execute("DELETE FROM mistakes WHERE id=?", (mistake_id,))
    else:
        db.execute(
            "UPDATE mistakes SET mistake_count=?, last_mistake_at=? WHERE id=?",
            (new_count, now_iso(), mistake_id),
        )

    if commit:
        db.commit()
    return True


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

    if item_id is not None:
        if not is_correct:
            record_mistake(
                db,
                item_id=item_id,
                source="srs",
                card_id=card_id,
                last_attempt_id=attempt_id,
                commit=False,
            )
        else:
            resolve_mistake(
                db,
                item_id=item_id,
                source="srs",
                reduce_by=1,
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


def get_attempt_timeseries(db: sqlite3.Connection, days: int = 7) -> List[Dict[str, Any]]:
    """
    Aggregate attempts per day for the last N days (including today).
    """
    cur = db.execute(
        """
        SELECT substr(created_at,1,10) AS d, COUNT(*) AS total, SUM(is_correct) AS correct
        FROM attempts
        WHERE is_correct IS NOT NULL AND date(created_at) >= date('now', ?)
        GROUP BY d
        ORDER BY d DESC
        LIMIT ?
        """,
        (f"-{max(0, days-1)} days", days),
    )
    rows = cur.fetchall()
    out: List[Dict[str, Any]] = []
    for row in rows:
        total = int(row["total"] or 0)
        correct = int(row["correct"] or 0)
        out.append(
            {
                "date": row["d"],
                "total": total,
                "correct": correct,
                "accuracy": (correct / total * 100) if total else 0.0,
            }
        )
    return out


def get_attempt_stats(db: sqlite3.Connection, date_str: Optional[str] = None) -> Dict[str, Any]:
    """
    Aggregate attempts (SRS, cloze, test, etc.) for a day to surface holistic activity.
    """
    date_str = date_str or today_date_str()
    cur = db.execute(
        """
        SELECT source, COUNT(*) AS total, SUM(is_correct) AS correct
        FROM attempts
        WHERE substr(created_at,1,10)=? AND is_correct IS NOT NULL
        GROUP BY source
        """,
        (date_str,),
    )
    by_source: Dict[str, Dict[str, Any]] = {}
    total = 0
    correct = 0
    for row in cur.fetchall():
        src = row["source"]
        t = int(row["total"] or 0)
        c = int(row["correct"] or 0)
        by_source[src] = {
            "total": t,
            "correct": c,
            "accuracy": (c / t * 100) if t else 0.0,
        }
        total += t
        correct += c

    accuracy = (correct / total * 100) if total > 0 else 0.0
    return {"date": date_str, "total": total, "correct": correct, "accuracy": accuracy, "by_source": by_source}


def get_streak(db: sqlite3.Connection, max_days: int = 60) -> int:
    """
    Count consecutive days (including today) with at least one activity
    (SRS review log or any attempt).
    """
    streak = 0
    today = today_date_str()
    cur_date = today
    for _ in range(max_days):
        cur = db.execute(
            """
            SELECT 1 FROM (
                SELECT created_at FROM review_logs
                UNION ALL
                SELECT created_at FROM attempts
            )
            WHERE substr(created_at,1,10)=?
            LIMIT 1
            """,
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
        tag_set = {t.lower() for t in _tag_tokens(row["tags"] or "")}
        if not tag_set:
            continue
        for lvl in levels:
            if lvl.lower() in tag_set:
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


def get_cloze_queue(
    db: sqlite3.Connection,
    limit: int = 50,
    tag_filter: Optional[str] = None,
    level_filter: Optional[str] = None,
) -> List[Dict[str, Any]]:
    """
    Fetch sentences with cloze/answer for practice, prioritizing items with mistakes (sentence/test).
    """
    query = """
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
    """
    params: List[Any] = []
    query, params = _apply_tag_filter_sql(query, params, tag_filter, level_filter)
    query += """
        ORDER BY (m.last_mistake_at IS NOT NULL) DESC, m.last_mistake_at DESC, s.id DESC
        LIMIT ?
    """
    params.append(limit)

    cur = db.execute(query, params)
    rows = cur.fetchall()

    out: List[Dict[str, Any]] = []
    updates: List[Tuple[str, str, int]] = []  # cloze, answer, id
    for row in rows:
        answer = row["answer"] or row["term"]
        cloze = row["cloze"]
        used_fallback = False
        reason = ""
        if not cloze:
            cloze, answer, used_fallback, reason = build_cloze_preview(row["sentence"], answer)
            updates.append((cloze, answer, row["sentence_id"]))
        else:
            _, _, used_fallback, reason = build_cloze_preview(row["sentence"], answer)
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
                "cloze_fallback": used_fallback,
                "cloze_reason": reason,
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


def get_test_batch(
    db: sqlite3.Connection,
    total: int = 15,
    only_mistake: bool = False,
    only_due: bool = False,
    tag_filter: Optional[str] = None,
    level_filter: Optional[str] = None,
) -> List[Dict[str, Any]]:
    """
    Build a mini-test batch mixing: mistakes (sentence/test/srs), due, and fresh sentences.
    """
    total = max(5, min(total, 30))
    want_mistake = total if only_mistake else min(8, total // 3 + 2)
    want_due = total if only_due else min(8, total // 3 + 2)
    want_new = total * 2  # grab extra then trim

    updates: List[Tuple[str, str, int]] = []
    questions: List[Dict[str, Any]] = []

    def fetch(query: str, params: List[Any], label: str, limit: int) -> None:
        nonlocal questions
        q = query + " LIMIT ?"
        cur = db.execute(q, params + [limit])
        for row in cur.fetchall():
            questions.append(_question_from_row(row, label, updates))

    # Mistake first
    mq = """
        SELECT
            s.id AS sentence_id, s.sentence, s.cloze, s.answer,
            i.id AS item_id, i.item_type, i.term, i.reading, i.meaning, i.tags,
            NULL AS card_id
        FROM mistakes m
        JOIN sentences s ON s.item_id = m.item_id
        JOIN items i ON i.id = s.item_id
        WHERE m.source IN ('sentence','test','srs')
    """
    mparams: List[Any] = []
    mq, mparams = _apply_tag_filter_sql(mq, mparams, tag_filter, level_filter)
    mq += " ORDER BY m.last_mistake_at DESC"
    fetch(mq, mparams, "mistake", want_mistake)

    if not only_mistake:
        dq = """
            SELECT
                s.id AS sentence_id, s.sentence, s.cloze, s.answer,
                i.id AS item_id, i.item_type, i.term, i.reading, i.meaning, i.tags,
                c.id AS card_id
            FROM cards c
            JOIN items i ON i.id = c.item_id
            JOIN sentences s ON s.item_id = c.item_id
            WHERE c.due_date <= ?
        """
        dparams: List[Any] = [today_date_str()]
        dq, dparams = _apply_tag_filter_sql(dq, dparams, tag_filter, level_filter)
        dq += " ORDER BY c.due_date ASC"
        fetch(dq, dparams, "due", want_due if not only_due else total)

    if not only_mistake and not only_due:
        nq = """
            SELECT
                s.id AS sentence_id, s.sentence, s.cloze, s.answer,
                i.id AS item_id, i.item_type, i.term, i.reading, i.meaning, i.tags,
                c.id AS card_id
            FROM sentences s
            JOIN items i ON i.id = s.item_id
            LEFT JOIN cards c ON c.item_id = i.id
            WHERE 1=1
        """
        nparams: List[Any] = []
        nq, nparams = _apply_tag_filter_sql(nq, nparams, tag_filter, level_filter)
        nq += " ORDER BY s.id DESC"
        fetch(nq, nparams, "new", want_new)

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


def get_attempt_rows_for_export(
    db: sqlite3.Connection,
    sources: Optional[Sequence[str]] = None,
    days: int = 30,
    limit: int = 2000,
) -> List[sqlite3.Row]:
    """
    Fetch attempts for CSV export.
    """
    where = ["1=1"]
    params: List[Any] = []
    if sources:
        placeholders = ",".join("?" for _ in sources)
        where.append(f"source IN ({placeholders})")
        params.extend(sources)
    if days:
        where.append("date(created_at) >= date('now', ?)")
        params.append(f"-{max(0, days-1)} days")
    sql = f"""
        SELECT created_at, source, item_id, card_id, sentence_id, test_id, test_attempt_id,
               prompt, response, expected, is_correct, score
        FROM attempts
        WHERE {' AND '.join(where)}
        ORDER BY created_at DESC
        LIMIT ?
    """
    params.append(limit)
    cur = db.execute(sql, params)
    return list(cur.fetchall())
