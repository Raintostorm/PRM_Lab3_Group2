// Ví dụ 2 — Multi-level inheritance: Shape → Polygon → Rectangle → Square.
// Doc: md/inheritance.md mục 4.2

// ── Level 1 ───────────────────────────────────────────────────────────────────

class Shape {
  final String color;

  Shape(this.color);

  double area() => 0;
  double perimeter() => 0;

  String describe() =>
      '$runtimeType [$color] '
      '| area=${area().toStringAsFixed(2)} '
      '| perimeter=${perimeter().toStringAsFixed(2)}';
}

// ── Level 2 ───────────────────────────────────────────────────────────────────

class Polygon extends Shape {
  final int sides;

  Polygon(super.color, this.sides);

  @override
  String describe() => '${super.describe()} | sides=$sides';
}

// ── Level 3 ───────────────────────────────────────────────────────────────────

class Rectangle extends Polygon {
  final double width;
  final double height;

  // Dùng tham số thường khi cần truyền thêm giá trị cố định (4 cạnh) lên super.
  Rectangle(String color, this.width, this.height) : super(color, 4);

  @override
  double area() => width * height;

  @override
  double perimeter() => 2 * (width + height);
}

// ── Level 4 ───────────────────────────────────────────────────────────────────

class Square extends Rectangle {
  // Chỉ nhận 1 tham số side — kế thừa toàn bộ logic từ Rectangle.
  Square(String color, double side) : super(color, side, side);
}

// ── Demo helper ───────────────────────────────────────────────────────────────

List<Shape> buildShapeList() => [
      Rectangle('Blue', 6, 4),
      Square('Green', 5),
    ];
