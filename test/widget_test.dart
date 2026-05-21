import 'package:flutter_test/flutter_test.dart';
import 'package:prm_lab3_group2/examples/abstract_class/animal.dart';
import 'package:prm_lab3_group2/main.dart';

void main() {
  testWidgets('Menu opens and Animal demo shows polymorphism', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PrmLab3App());
    await tester.pumpAndSettle();

    expect(find.text('Abstract Class Lab'), findsOneWidget);
    await tester.tap(find.text('1. Animal (Dart)'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Woof'), findsOneWidget);
    expect(find.textContaining('Animal'), findsWidgets);
    expect(find.textContaining('Dog'), findsWidgets);
  });

  test('Animal abstract demo output', () {
    final lines = runAnimalDemo();
    expect(lines.length, 2);
    expect(lines.first, contains('Woof'));
  });
}
