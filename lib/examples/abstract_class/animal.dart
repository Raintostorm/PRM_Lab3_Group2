// Ví dụ 1 — Abstract class thuần Dart (không UI).
// Doc: md/abstract-class.md mục 6.1

abstract class Animal {
  String get name;

  /// Abstract method — lớp con bắt buộc implement.
  String speak();

  /// Concrete method — logic dùng chung, không cần override.
  String breathe() => '$name is breathing';
}

class Dog extends Animal {
  Dog(this.name);

  @override
  final String name;

  @override
  String speak() => '$name says: Woof!';
}

class Cat extends Animal {
  Cat(this.name);

  @override
  final String name;

  @override
  String speak() => '$name says: Meow!';
}

/// Gom kết quả demo để hiển thị trên UI.
List<String> runAnimalDemo() {
  final animals = <Animal>[Dog('Buddy'), Cat('Mimi')];
  return animals
      .map((a) => '${a.speak()}\n${a.breathe()}')
      .toList(growable: false);
}
