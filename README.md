# PRM_Lab3_Group2

Lab 3 — **Question 3: Advanced OOP & Flutter Architecture** (Flutter + Dart).

Giải thích *architectural purpose* của: inheritance, abstract class, interface, mixin — kèm **code mẫu chạy được**.

## Cấu trúc repo

```
PRM_Lab3_Group2/
├── lib/
│   ├── main.dart
│   └── examples/
│       └── abstract_class/     # Done
├── md/
│   ├── README.md               # Phân công
│   ├── CODE_CONVENTIONS.md     # Quy định doc ↔ code
│   ├── abstract-class.md     # Done
│   ├── inheritance.md          # TODO
│   ├── interface.md            # TODO
│   └── mixin.md                # TODO
├── test/
└── pubspec.yaml
```

## Tiến độ

| Phần | Doc | Code | Trạng thái |
|------|-----|------|------------|
| Inheritance | [md/inheritance.md](md/inheritance.md) | `lib/examples/inheritance/` | TODO |
| Abstract class | [md/abstract-class.md](md/abstract-class.md) | [lib/examples/abstract_class/](lib/examples/abstract_class/) | **Done** |
| Interface | [md/interface.md](md/interface.md) | `lib/examples/interface/` | TODO |
| Mixin | [md/mixin.md](md/mixin.md) | `lib/examples/mixin/` | TODO |

## Chạy nhanh

```bash
git clone https://github.com/Raintostorm/PRM_Lab3_Group2.git
cd PRM_Lab3_Group2
flutter pub get
flutter run
```

App mở màn **Abstract Class Demo** (4 ví dụ: Animal, Repository, AppPage, framework notes).

```bash
flutter test
flutter analyze
```

## Đóng góp

- Quy ước: [md/CODE_CONVENTIONS.md](md/CODE_CONVENTIONS.md)  
- Phân công: [md/README.md](md/README.md)

## Repo

https://github.com/Raintostorm/PRM_Lab3_Group2
