import 'package:flutter_test/flutter_test.dart';
import 'package:projetomobilecarros/main.dart';

void main() {
  testWidgets('Aplicativo LA Motors inicia corretamente',
          (WidgetTester tester) async {
        await tester.pumpWidget(const LAMotorsApp());

        expect(find.byType(LAMotorsApp), findsOneWidget);
      });
}