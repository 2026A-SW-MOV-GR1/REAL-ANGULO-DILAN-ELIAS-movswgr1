import 'package:flutter_test/flutter_test.dart';
import 'package:inter_app_communication/main.dart';

void main() {
  testWidgets('Prueba de humo: Verifica el título y las pestañas', (WidgetTester tester) async {
    // Construye la aplicación.
    await tester.pumpWidget(const MyApp());

    // Verifica que el título principal esté presente en la AppBar.
    expect(find.text('Comunicación Inter-App'), findsOneWidget);

    // Verifica que las pestañas de navegación estén presentes.
    expect(find.text('Salientes'), findsOneWidget);
    expect(find.text('Entrantes'), findsOneWidget);
  });
}
