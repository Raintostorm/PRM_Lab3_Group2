# Inheritance (`extends`)

## 1. Định nghĩa

**Inheritance (Kế thừa)** là cơ chế cho phép một class (*lớp con / subclass*) tái sử dụng toàn bộ fields và methods của class khác (*lớp cha / superclass*), đồng thời có thể mở rộng hoặc ghi đè hành vi đó.

Trong Dart, kế thừa được khai báo bằng từ khóa `extends`:

```dart
class Car extends Vehicle { ... }
```

Các từ khóa liên quan:

| Từ khóa | Vai trò |
|---------|---------|
| `extends` | Khai báo lớp con kế thừa lớp cha |
| `@override` | Đánh dấu method đang ghi đè method của lớp cha |
| `super` | Truy cập constructor / method của lớp cha |
| `is` | Kiểm tra kiểu — `car is Vehicle` trả về `true` |

> Dart **chỉ hỗ trợ single inheritance** (một lớp con, một lớp cha trực tiếp). Để kết hợp nhiều hành vi, dùng thêm `mixin`.

---

## 2. Architectural purpose trong Flutter

| Mục đích | Giải thích |
|----------|-----------|
| **Tái sử dụng code** | Lớp con nhận toàn bộ fields + methods từ lớp cha, không cần viết lại. |
| **Mở rộng hành vi** | Override method cụ thể mà không ảnh hưởng các method còn lại. |
| **Đa hình (Polymorphism)** | Biến kiểu `Vehicle` có thể giữ object `Car` hay `Truck` — code gọi chung qua interface của lớp cha. |
| **Template Method pattern** | Lớp cha định nghĩa "bộ khung" (skeleton), lớp con điền nội dung cụ thể — Flutter dùng pattern này trong `StatelessWidget.build`. |

---

## 3. Ví dụ trong Flutter framework

Flutter sử dụng inheritance ở khắp nơi:

```
Object
 └── Widget
      ├── StatelessWidget   ← extends Widget
      │    └── (custom widgets của bạn)
      └── StatefulWidget    ← extends Widget
           └── (custom widgets có state)
```

- **`StatelessWidget`** kế thừa `Widget`, bắt buộc override `build(BuildContext)`.
- **`State<T>`** kế thừa `State`, bắt buộc override `build` và tuỳ chọn override `initState`, `dispose`.
- **`MaterialApp`** → `StatefulWidget` → `Widget`: kế thừa nhiều tầng nhưng developer chỉ làm việc với API của tầng gần nhất.

---

## 4. Ví dụ code

### 4.1 Vehicle — Inheritance cơ bản

Minh họa: `extends`, `@override`, `super`, toán tử `is`.

```dart
class Vehicle {
  final String brand;
  final int year;

  Vehicle(this.brand, this.year);

  String describe() => 'Vehicle: $brand ($year)';
  String fuelType() => 'Unknown';
}

class Car extends Vehicle {
  final int doors;

  Car(super.brand, super.year, this.doors);   // super parameter

  @override
  String describe() => '${super.describe()} — Car, $doors cửa';

  @override
  String fuelType() => 'Gasoline';
}

class ElectricCar extends Car {               // multi-level
  final int rangeKm;

  ElectricCar(super.brand, super.year, super.doors, this.rangeKm);

  @override
  String describe() => '${super.describe()} [Electric, ${rangeKm}km]';

  @override
  String fuelType() => 'Electric';
}
```

**Output:**
```
Toyota (2022) — Car, 4 cửa        | Fuel: Gasoline
Tesla (2024) — Car, 4 cửa [Electric, 500km] | Fuel: Electric
car is Vehicle  → true
car is Car      → true
```

---

### 4.2 Shape — Multi-level & constructor chaining

Minh họa: kế thừa 4 tầng, truyền tham số cố định qua initializer list.

```dart
class Shape { ... }
class Polygon extends Shape { final int sides; ... }
class Rectangle extends Polygon {
  Rectangle(String color, this.width, this.height) : super(color, 4);
}
class Square extends Rectangle {
  Square(String color, double side) : super(color, side, side);
}
```

> **Lưu ý Dart:** Khi dùng `: super(...)` trong initializer list, không được dùng `super.param` cho cùng constructor — phải dùng tham số thường và chuyển thủ công.

---

### 4.3 Flutter Widget Inheritance

Minh họa: tạo widget hierarchy riêng bằng cách kế thừa `StatelessWidget`.

```dart
abstract class BaseCard extends StatelessWidget {
  Widget buildContent(BuildContext context); // hook cho lớp con

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        _header(),
        buildContent(context),   // lớp con quyết định nội dung
      ]),
    );
  }
}

class InfoCard extends BaseCard { ... }   // chỉ override buildContent
class StatsCard extends BaseCard { ... }  // chỉ override buildContent
```

---

## 5. Liên kết doc ↔ code

| Mục | File Dart |
|-----|-----------|
| 4.1 Vehicle | [lib/examples/inheritance/vehicle.dart](../lib/examples/inheritance/vehicle.dart) |
| 4.2 Shape | [lib/examples/inheritance/shape.dart](../lib/examples/inheritance/shape.dart) |
| 4.3 Flutter Widget | [lib/examples/inheritance/flutter_widget_inheritance.dart](../lib/examples/inheritance/flutter_widget_inheritance.dart) |
| Demo UI 1 | [lib/examples/inheritance/vehicle_demo_screen.dart](../lib/examples/inheritance/vehicle_demo_screen.dart) |
| Demo UI 2 | [lib/examples/inheritance/shape_demo_screen.dart](../lib/examples/inheritance/shape_demo_screen.dart) |
| Demo UI 3 | [lib/examples/inheritance/flutter_widget_demo_screen.dart](../lib/examples/inheritance/flutter_widget_demo_screen.dart) |
| Menu | [lib/examples/inheritance/inheritance_menu_screen.dart](../lib/examples/inheritance/inheritance_menu_screen.dart) |

---

## 6. Chạy thử

```bash
flutter run
```

Từ Home Screen → nhấn **"Inheritance Demo"** → chọn ví dụ trong menu.
