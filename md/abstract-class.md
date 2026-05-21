# Abstract class

> **Trạng thái:** Done — phần nhóm đảm nhiệm cho Lab 3 Question 3.

## 1. Định nghĩa

Trong Dart, **abstract class** là class khai báo với từ khóa `abstract`. Nó có thể:

- Chứa **method đã implement** (logic dùng chung cho lớp con).
- Chứa **abstract method** — chỉ khai báo chữ ký, **không** có thân; lớp con **bắt buộc** `@override` và implement.
- **Không thể** gọi constructor để tạo instance trực tiếp (`AbstractFoo()` bị lỗi biên dịch).

```dart
abstract class Animal {
  void speak(); // abstract method

  void breathe() {
    print('breathing'); // concrete — dùng chung
  }
}
```

Khác với `interface`/`implements`: abstract class thường dùng **`extends`** để vừa thừa hưởng code sẵn, vừa bị ràng buộc implement phần còn thiếu.

## 2. Architectural purpose trong Flutter

Flutter dùng abstract class để **định nghĩa “khung” (contract + hành vi mặc định)** mà hàng trăm widget và lớp nội bộ phải tuân theo, mà không cho phép khởi tạo bừa một “widget chung chung”.

| Mục đích kiến trúc | Giải thích |
|--------------------|------------|
| **Contract có chọn lọc** | Bắt lớp con implement phần biến đổi (`build`, `createState`, …) nhưng vẫn cung cấp method/property dùng chung từ lớp cha. |
| **Tránh instance vô nghĩa** | Không ai tạo trực tiếp `Widget()` — chỉ `Text()`, `Column()`, … Cây widget luôn là các lớp cụ thể. |
| **Tái sử dụng logic framework** | Logic như `setState`, lifecycle, key, `Element`/`RenderObject` gắn với hierarchy abstract — lập trình viên chỉ override điểm khác biệt. |
| **Phân tầng rõ** | Tách “định nghĩa UI immutable” (`Widget`) khỏi “trạng thái mutable” (`State`) bằng các abstract class khác nhau. |
| **Mở rộng an toàn** | Team Flutter thêm API mới trên base abstract; app và package override đúng chỗ, compiler báo lỗi nếu thiếu method. |

Tóm lại: **abstract class = biên giới kiến trúc + code dùng chung** trong cây kế thừa Flutter, thay vì chỉ một danh sách method trống như `implements` thuần.

## 3. Ví dụ trong Flutter framework

### `Widget` (abstract)

Mọi thành phần UI đều `extends Widget`. `Widget` khai báo abstract `build` (qua subclass) và các thuộc tính như `key`. Bạn không bao giờ `return Widget()` — luôn là `Container`, `ListView`, v.v.

### `StatelessWidget` / `StatefulWidget` (abstract)

- `StatelessWidget`: bắt subclass implement `build(BuildContext context)`.
- `StatefulWidget`: bắt `createState()` trả về `State<T>` tương ứng.

Đây là **template method pattern**: framework định nghĩa luồng render; app chỉ điền `build` / `createState`.

### `State<T>` (abstract)

`State` gắn với `Element`, quản lý lifecycle (`initState`, `dispose`, …). `setState` nằm trên base class; widget con chỉ override hook cần thiết.

### Các abstract class khác (tham khảo)

- `RenderObject` — tầng layout/paint.
- `InheritedWidget` — truyền data xuống cây widget.
- `PlatformView` / nhiều lớp trong `flutter/rendering`, `flutter/widgets`.

## 4. Ví dụ code (snippet — tham khảo nhanh)

```dart
// Không thể instantiate abstract class:
// final w = Widget();   // Error
// final s = State();    // Error
final w = Text('OK');    // Concrete subclass — hợp lệ
```

**Code chạy đầy đủ** nằm trong repo Flutter — xem **mục 6** bên dưới.

## 5. Tóm tắt

| Khía cạnh | Abstract class trong Flutter |
|-----------|----------------------------|
| Cú pháp | `abstract class` + `extends` |
| Vai trò | Contract + implementation dùng chung |
| Lợi ích | Cây widget/state nhất quán, compiler ép override, tránh class “rỗng” |
| So với `implements` | Có thể kế thừa code; thường một chuỗi `extends` dọc hierarchy |
| So với `mixin` | Abstract class định nghĩa **nhánh “là-a”** chính; mixin bổ sung capability ngang |

## 6. Code mẫu trong project (bắt buộc đọc kèm)

| Mục | File | Ý chính |
|-----|------|---------|
| **6.1** | [`lib/examples/abstract_class/animal.dart`](../lib/examples/abstract_class/animal.dart) | `Animal` abstract + `Dog`/`Cat` extends; `speak()` abstract, `breathe()` concrete |
| **6.2** | [`lib/examples/abstract_class/task_repository.dart`](../lib/examples/abstract_class/task_repository.dart) | `TaskRepository` — `toggleDone()` dùng chung, `persist()` abstract |
| **6.3** | [`lib/examples/abstract_class/app_page.dart`](../lib/examples/abstract_class/app_page.dart) | `AppPage` giống `StatelessWidget`: abstract `build()`, `AppPageHost` hiển thị |
| **6.4** | [`lib/examples/abstract_class/framework_note.dart`](../lib/examples/abstract_class/framework_note.dart) | Ghi chú `Widget` / `State` / `setState` trong framework |
| **Demo UI** | [`lib/examples/abstract_class/abstract_class_demo_screen.dart`](../lib/examples/abstract_class/abstract_class_demo_screen.dart) | Gộp 4 ví dụ trên một màn hình |
| **Entry** | [`lib/main.dart`](../lib/main.dart) | `PrmLab3App` extends `StatelessWidget` (abstract class có sẵn) |

### 6.1 — `Animal` (Dart thuần)

- `abstract class Animal` khai báo `speak()` không có body.
- `breathe()` có implementation — lớp con kế thừa, không cần viết lại.
- `runAnimalDemo()` trả về chuỗi hiển thị trên UI.

### 6.2 — `TaskRepository` (kiến trúc app)

- UI/demo chỉ giữ `TaskRepository repo`, inject `InMemoryTaskRepository`.
- `toggleDone` là **template method** trên abstract class: logic chung, gọi `persist` do subclass implement.
- Đổi sang API/DB sau: tạo class mới `extends TaskRepository`, UI không đổi.

### 6.3 — `AppPage` (pattern giống widget)

- Không thể `AppPage()` — chỉ `HomePage`, `AboutPage`.
- `AppPageHost` nhận `AppPage page` — polymorphism qua abstract type.

### 6.4 — Framework Flutter

- `PrmLab3App extends StatelessWidget` → bắt buộc `@override Widget build(...)`.
- Đó chính là abstract class do Flutter định nghĩa; app chỉ điền phần khác biệt.

## 7. Chạy thử

```bash
flutter pub get
flutter run
```

Màn hình **Abstract Class Demo** hiển thị lần lượt 4 section tương ứng mục 6.

```bash
flutter test
flutter analyze
```

Quy ước chung cho nhóm (folder `examples/`, commit, checklist): [CODE_CONVENTIONS.md](./CODE_CONVENTIONS.md).

---

_Xem [README.md](./README.md) để phân công các phần còn lại._
