from __future__ import annotations
from dataclasses import dataclass
from typing import Literal
from app.core.time_utils import today_date_str, add_days

Grade = Literal["again", "hard", "good", "easy"]

@dataclass
class SrsState:
    due_date: str
    interval_days: int
    ease: float
    lapses: int
    is_leech: int

def clamp(x: float, lo: float, hi: float) -> float:
    return max(lo, min(hi, x))

def apply_grade(state: SrsState, grade: Grade) -> SrsState:
    # SM-2 rút gọn, dễ hiểu, đủ xài cho MVP
    ease = state.ease
    interval = state.interval_days
    lapses = state.lapses
    is_leech = state.is_leech

    if grade == "again":
        interval = 1
        lapses += 1
        ease -= 0.2
        due = add_days(today_date_str(), 0)  # due lại ngay (hoặc hôm nay)
    elif grade == "hard":
        interval = max(1, int(round(interval * 1.2)) if interval > 0 else 1)
        ease -= 0.05
        due = add_days(today_date_str(), interval)
    elif grade == "good":
        interval = max(1, int(round(interval * ease)) if interval > 0 else 2)
        due = add_days(today_date_str(), interval)
    elif grade == "easy":
        interval = max(2, int(round(interval * ease * 1.3)) if interval > 0 else 4)
        ease += 0.05
        due = add_days(today_date_str(), interval)
    else:
        raise ValueError(f"Unknown grade: {grade}")

    ease = clamp(ease, 1.3, 2.8)

    # Leech rule (đơn giản): sai >= 8 lần
    if lapses >= 8:
        is_leech = 1

    return SrsState(
        due_date=due,
        interval_days=interval,
        ease=ease,
        lapses=lapses,
        is_leech=is_leech
    )
