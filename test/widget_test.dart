import 'package:flutter_test/flutter_test.dart';
import 'package:prm_lab3_group2/examples/abstract_class/animal.dart';
import 'package:prm_lab3_group2/main.dart';

void main() {
  testWidgets('App shows abstract class demo', (WidgetTester tester) async {
    await tester.pumpWidget(const PrmLab3App());
    await tester.pumpAndSettle();

    expect(find.text('Abstract Class Demo'), findsOneWidget);
    expect(find.textContaining('Woof'), findsOneWidget);
  });

  test('Animal abstract demo output', () {
    final lines = runAnimalDemo();
    expect(lines.length, 2);
    expect(lines.first, contains('Woof'));
  });
}
