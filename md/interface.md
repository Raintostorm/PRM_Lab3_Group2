# Interface (`implements`)

> **Trạng thái:** Done — phần nhóm đảm nhiệm cho Lab 3 Question 3.

## 1. Định nghĩa

Dart **không có từ khóa `interface` riêng** như Java hay C#. Thay vào đó, mọi class trong Dart **tự động trở thành một implicit interface**. Ta dùng `abstract class` kết hợp từ khóa **`implements`** để mô phỏng interface.

```dart
// Khai báo interface — abstract class chỉ chứa chữ ký method
abstract class PaymentMethod {
  String get name;
  Future<PaymentResult> pay(double amount);
}

// Ký "hợp đồng" — phải override TẤT CẢ member của interface
class CreditCardPayment implements PaymentMethod {
  @override
  String get name => 'Thẻ tín dụng';

  @override
  Future<PaymentResult> pay(double amount) async { ... }
}
```

**So sánh từ khóa:**

| Từ khóa | Kế thừa code | Kế thừa hợp đồng | Ghi chú |
|---------|:---:|:---:|---------|
| `extends` | ✅ | ✅ | Kế thừa implementation + contract |
| `implements` | ❌ | ✅ | Chỉ contract — buộc viết lại tất cả |
| `with` (mixin) | ✅ | — | Ghép ngang, không tạo quan hệ "là-a" |

Một class có thể `implements` **nhiều interface** cùng lúc — đây là cách Dart giải quyết bài toán đa kế thừa an toàn.

## 2. Architectural purpose trong Flutter

Flutter dùng interface (implicit hoặc qua `abstract class`) để **tạo ranh giới giữa các tầng kiến trúc**, đảm bảo tầng trên không phụ thuộc vào chi tiết triển khai bên dưới.

| Mục đích kiến trúc | Giải thích |
|--------------------|------------|
| **Contract thuần** | Định nghĩa "phải làm gì" mà không quy định "làm như thế nào" — lớp con tự do chọn cách triển khai. |
| **Loose coupling** | UI/BLoC chỉ phụ thuộc interface, không phụ thuộc class cụ thể. Đổi data source (API → database) mà không sửa UI. |
| **Dependency Injection** | Truyền interface vào constructor thay vì tạo implementation bên trong. Dễ swap cho môi trường production / test. |
| **Dễ test** | Thay thế implementation thật bằng mock trong unit test mà không đổi code logic. |
| **Đa hành vi** | Một class implements nhiều interface — tách biệt từng "khả năng" (ví dụ: cả `Serializable` lẫn `Printable`). |
| **Open/Closed Principle** | Thêm cổng thanh toán / kênh thông báo mới chỉ cần tạo class mới `implements` — không sửa code cũ. |

**Luồng kiến trúc điển hình:**

```
UI Layer / BLoC
    │  gọi qua interface (không biết implementation)
    ▼
[Interface — "hợp đồng"]
    │
    ├── Implementation A  (production)
    └── Implementation B  (mock / test)
```

## 3. Ví dụ trong Flutter framework

### `Listenable` (interface cho observable objects)

`Animation`, `ChangeNotifier`, `ValueNotifier` đều `implements Listenable`. Widget dùng `Listenable listenable` — không quan tâm loại cụ thể:

```dart
abstract class Listenable {
  void addListener(VoidCallback listener);
  void removeListener(VoidCallback listener);
}
```

### Repository pattern (Clean Architecture)

Chuẩn phổ biến trong Flutter project quy mô lớn (BLoC, Riverpod):

```dart
// Interface — tầng domain không biết data đến từ đâu
abstract class UserRepository {
  Future<User> getById(String id);
  Future<void> save(User user);
}

// Tầng data implement interface
class FirebaseUserRepository implements UserRepository { ... }
class MockUserRepository implements UserRepository { ... }  // dùng khi test
```

### `RouteFactory`, `WidgetBuilder`

Nhiều typedef trong Flutter (`WidgetBuilder`, `RouteFactory`) là function signature — dạng interface thu gọn. Class không cần khai báo `implements`; chỉ cần khớp chữ ký.

## 4. Ví dụ code (snippet — tham khảo nhanh)

```dart
// Một class implements nhiều interface cùng lúc
abstract class Serializable {
  Map<String, dynamic> toJson();
}

abstract class Printable {
  void printInfo();
}

class User implements Serializable, Printable {
  final String name;
  User(this.name);

  @override
  Map<String, dynamic> toJson() => {'name': name};

  @override
  void printInfo() => print('User: $name');
}
```

**Code chạy đầy đủ** nằm trong repo — xem **mục 6** bên dưới.

## 5. Tóm tắt

| Khía cạnh | Interface trong Flutter |
|-----------|------------------------|
| Cú pháp | `abstract class` + `implements` |
| Vai trò | Contract thuần — chỉ "hợp đồng", không có code dùng chung |
| Lợi ích | Loose coupling, dễ test, đa hành vi, mở rộng không phá vỡ code cũ |
| So với `extends` | Không kế thừa code — phải viết lại tất cả; nhưng implements được nhiều interface |
| So với `abstract class` (extends) | Abstract class vừa là contract vừa có logic dùng chung; interface chỉ là contract |
| So với `mixin` | Mixin cung cấp code tái sử dụng theo chiều ngang; interface chỉ ràng buộc chữ ký |

## 6. Code mẫu trong project (bắt buộc đọc kèm)

| Mục | File | Ý chính |
|-----|------|---------|
| **6.1** | [`lib/examples/interface/interfaces.dart`](../lib/examples/interface/interfaces.dart) | `PaymentMethod` + `NotificationService` — hai interface được định nghĩa bằng `abstract class` |
| **6.2** | [`lib/examples/interface/implementations.dart`](../lib/examples/interface/implementations.dart) | 6 class `implements`: `CreditCardPayment`, `BankTransferPayment`, `EWalletPayment`, `EmailNotification`, `SmsNotification`, `PushNotification` |
| **6.3** | [`lib/examples/interface/order_processor.dart`](../lib/examples/interface/order_processor.dart) | `OrderProcessor` nhận interface qua constructor (Dependency Injection) — không biết implementation cụ thể |
| **Demo UI** | [`lib/examples/interface/interface_demo_screen.dart`](../lib/examples/interface/interface_demo_screen.dart) | Màn hình tương tác: chọn payment + notification → xem execution log từng bước |
| **Menu** | [`lib/examples/interface/interface_menu_screen.dart`](../lib/examples/interface/interface_menu_screen.dart) | Menu điều hướng + tóm tắt lý thuyết inline |
| **Entry** | [`lib/main.dart`](../lib/main.dart) | Nút `"Interface Demo"` dẫn vào `InterfaceMenuScreen` |

### 6.1 — `interfaces.dart` (định nghĩa hợp đồng)

- `PaymentMethod`: khai báo `name`, `icon`, `color`, `pay(double amount)` — không có implementation.
- `NotificationService`: khai báo `channelName`, `channelIcon`, `sendConfirmation(...)`.
- Các data class `PaymentResult`, `OrderResult` dùng để trả kết quả — không phải interface.

### 6.2 — `implementations.dart` (triển khai hợp đồng)

- **3 Payment**: `CreditCardPayment`, `BankTransferPayment`, `EWalletPayment` — cùng `implements PaymentMethod`, khác thời gian xử lý và logic.
- **3 Notification**: `EmailNotification`, `SmsNotification`, `PushNotification` — cùng `implements NotificationService`, mỗi class giả lập gọi service khác nhau.
- Compiler báo lỗi ngay nếu bất kỳ class nào thiếu một method trong interface.

### 6.3 — `order_processor.dart` (Dependency Injection)

- `OrderProcessor` giữ 2 field kiểu **interface**: `final PaymentMethod _payment` và `final NotificationService _notification`.
- Không có `if/switch` để kiểm tra loại thanh toán — gọi thẳng `_payment.pay()` và `_notification.sendConfirmation()`.
- **3 payment × 3 notification = 9 combination** dùng chung một đoạn code xử lý.

### 6.4 — `interface_demo_screen.dart` (UI minh họa)

- Người dùng chọn payment method và notification channel → bấm **"Thanh toán ngay"**.
- Execution log hiện từng bước: thấy rõ `OrderProcessor` gọi interface mà không biết implementation.
- Insight banner cuối: giải thích sức mạnh của interface với 9 combination.

## 7. Chạy thử

```bash
flutter pub get
flutter run
```

Từ **Home Screen** → bấm **"Interface Demo"** → chọn **"1. Hệ thống thanh toán"**.

Thử thay đổi các tổ hợp phương thức thanh toán + kênh thông báo để thấy `OrderProcessor` xử lý giống nhau dù implementation khác nhau.

```bash
flutter analyze
```

Quy ước chung cho nhóm (folder `examples/`, commit, checklist): [CODE_CONVENTIONS.md](./CODE_CONVENTIONS.md).

---

_Xem [README.md](./README.md) để phân công các phần còn lại._
