from __future__ import annotations
import datetime as _dt

DATE_FMT = "%Y-%m-%d"

def today_date_str() -> str:
    return _dt.date.today().strftime(DATE_FMT)

def parse_date(s: str) -> _dt.date:
    return _dt.datetime.strptime(s, DATE_FMT).date()

def add_days(date_str: str, days: int) -> str:
    d = parse_date(date_str)
    return (d + _dt.timedelta(days=days)).strftime(DATE_FMT)

def now_iso() -> str:
    return _dt.datetime.now().replace(microsecond=0).isoformat()
