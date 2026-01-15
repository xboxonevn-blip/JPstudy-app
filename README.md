# App học tiếng Nhật (Template) — Python + PySide6 + SQLite

Template này bám theo chiến lược:
(A) Nạp → (B) Ghi nhớ (SRS) → (C) Dùng được trong câu → (D) Thi thử & sửa lỗi

Trong bản template này, bạn có sẵn:
- DB SQLite + tạo bảng tự động khi chạy lần đầu
- Màn **Home** (Daily Plan: đếm thẻ due)
- Màn **Nạp**: Import CSV + thêm mục thủ công
- Màn **SRS Review**: review thẻ đến hạn, chấm Again/Hard/Good/Easy (SM-2 rút gọn)

> Các phần (C) và (D) được để sẵn “khung/placeholder” để bạn mở rộng tiếp.

---

## 1) Cài đặt

### Windows (khuyến nghị)
1. Cài **Python 3.12** (tick “Add python to PATH”)
2. Mở Terminal trong thư mục dự án:

```bash
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
python main.py
```

### macOS/Linux
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python main.py
```

---

## 2) Import CSV (Nạp)

File mẫu: `data/n4_sample.csv`

Cột bắt buộc (header):
- item_type: vocab | kanji | grammar
- term
- reading
- meaning
- example
- tags (tuỳ chọn)

Bạn có thể tự tạo CSV theo format này rồi import.

---

## 3) Nơi lưu database

DB mặc định: `app_data/app.db` (nằm cạnh file `main.py`).

---

## 4) Cấu trúc thư mục

- `main.py` : entrypoint
- `app/`
  - `db/` : database + schema
  - `srs/` : thuật toán SRS
  - `ui/` : các màn hình PySide6
  - `core/` : tiện ích chung (date, validation)
- `data/` : CSV mẫu
- `app_data/` : SQLite database (tự tạo khi chạy)

---

## 5) Roadmap gợi ý để bạn phát triển tiếp

- Thêm màn (C): Cloze / sắp xếp từ / viết câu → sai thì ghi `errors` + tạo “error card”
- Thêm màn (D): thi thử theo phần → thống kê lỗi → tạo deck sửa lỗi
- Thêm “Sổ lỗi” (Error Notebook) để ưu tiên ôn đúng chỗ sai
- Đồng bộ/backup (Google Drive, OneDrive...) nếu cần

Chúc bạn build app vui vẻ!

## 6) Auto Import (JLPT N5-N1)
Put CSV files in `data/` named `n5.csv`, `n4.csv`, `n3.csv`, `n2.csv`, `n1.csv`
or `jlpt_n5.csv` ... `jlpt_n1.csv`. The Auto Import button will tag items with
`N5`..`N1` automatically. If `n4.csv` is missing, `n4_sample.csv` is used.

## 7) New study helpers
- Leech filtered deck: trong SRS, bật `Leech only` để ôn riêng thẻ sai nhiều.
- Quick Quiz sau import: sau khi import, app hỏi nhanh 10 thẻ mới để active recall.
- Dashboard: Home hiển thị số review hôm nay, accuracy, streak và đếm leech/due theo level.

## 8) Import từ Anki CSV
- Xuất deck Anki ra CSV/TXT (có header) với các cột phổ biến: `Front`/`Back`/`Tags` (hoặc `Expression`/`Reading`/`Meaning`/`Sentence`). App tự map: Front→term, Back→meaning, Reading→reading, Sentence→example, Tags→tags. Nếu không có `item_type`, mặc định dùng `vocab`.
- Hỗ trợ cả dấu phẩy hoặc tab phân tách (auto detect). Sau khi import vẫn tạo thẻ SRS đến hạn ngay.
