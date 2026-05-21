# Quy ước code & tài liệu (Lab 3)

Áp dụng cho toàn repo [PRM_Lab3_Group2](https://github.com/Raintostorm/PRM_Lab3_Group2).

## 1. Cấu trúc thư mục

```
lib/
├── main.dart                          # Entry — chỉ khởi chạy app, ít logic
└── examples/
    ├── abstract_class/                # Done — Question 3 (abstract class)
    ├── inheritance/                   # TODO — thành viên phụ trách
    ├── interface/                     # TODO
    └── mixin/                         # TODO

md/
├── README.md                          # Phân công
├── CODE_CONVENTIONS.md                # File này
├── abstract-class.md                  # Doc ↔ code abstract_class/
├── inheritance.md
├── interface.md
└── mixin.md
```

**Quy tắc:** Mỗi chủ đề OOP = **một folder** `lib/examples/<topic>/` + **một file** `md/<topic>.md` (kebab-case).

## 2. Trách nhiệm từng phần

| Thành phần | Ai làm | Nội dung bắt buộc |
|------------|--------|-------------------|
| `md/<topic>.md` | Người được gán topic | Định nghĩa, architectural purpose, ví dụ framework, **link tới file Dart** |
| `lib/examples/<topic>/` | Cùng người | Code chạy được, có comment `///` trỏ về mục trong `.md` |
| `md/<topic>.md` mục "Chạy thử" | Cùng người | Lệnh `flutter run`, màn hình nào hiển thị demo |

**Không** sửa folder `lib/examples/<topic>/` của người khác trừ khi được nhờ review.

## 3. Quy ước Dart / Flutter

1. **Tên file:** `snake_case.dart` — một concept chính hoặc một màn demo per file.  
2. **Abstract class:** khai báo `abstract class`; method abstract không có `{}` body (trừ khi dùng `;` legacy — ưu tiên không body).  
3. **Comment đầu file:**  
   ```dart
   /// Ví dụ N — Mô tả ngắn.
   /// Xem: md/abstract-class.md mục 6.N
   ```  
4. **Export demo UI:** file `*_demo_screen.dart` hoặc tích hợp vào `main.dart` qua menu (khi có nhiều topic).  
5. **Phụ thuộc:** code trong `examples/<topic>/` **không** import chéo sang `examples/<topic_khac>/`.  
6. **Test:** thêm test tối thiểu trong `test/` nếu có logic thuần Dart (không bắt buộc test UI đầy đủ).

## 4. Liên kết doc ↔ code (abstract class — mẫu)

| Mục trong `abstract-class.md` | File Dart |
|------------------------------|-----------|
| 6.1 Animal | `lib/examples/abstract_class/animal.dart` |
| 6.2 TaskRepository | `lib/examples/abstract_class/task_repository.dart` |
| 6.3 AppPage | `lib/examples/abstract_class/app_page.dart` |
| 6.4 Framework | `lib/examples/abstract_class/framework_note.dart` |
| Menu + demo UI | `abstract_class_menu_screen.dart`, `*_demo_screen.dart`, `demo_labels.dart` |

Các topic khác (inheritance, interface, mixin) **copy bảng tương tự** vào file `.md` của họ khi hoàn thành.

## 5. Commit message

```
feat(examples): add abstract_class demo
docs(abstract-class): link to lib/examples
```

## 6. Chạy project

```bash
cd PRM_Lab3_Group2
flutter pub get
flutter run
```

App mở thẳng màn **Abstract Class Demo**. Các topic sau có thể thêm `HomeScreen` với `ListTile` điều hướng — không bắt buộc trong phase 1.

## 7. Checklist trước khi push (người làm abstract class)

- [x] Code trong `lib/examples/abstract_class/`
- [x] `md/abstract-class.md` có mục 6 + 7 (code map)
- [x] `flutter analyze` không lỗi
- [ ] Các thành viên khác: folder `inheritance`, `interface`, `mixin` + md tương ứng
