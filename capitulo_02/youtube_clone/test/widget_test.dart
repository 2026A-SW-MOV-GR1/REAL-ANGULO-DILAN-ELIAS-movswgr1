import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youtube_clone/main.dart';

void main() {
  testWidgets('YouTube Clone UI Full Test', (WidgetTester tester) async {
    // 1. Cargar la app
    await tester.pumpWidget(const YouTubeCloneApp());

    // 2. Verificar elementos estáticos (NavBar)
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Subscriptions'), findsOneWidget);

    // 3. Verificar que al menos existe el Shorts de la barra inferior
    expect(find.text('Shorts'), findsAtLeastNWidgets(1));

    // 4. Simular Scroll para encontrar la sección de Shorts en el Feed
    // Esto prueba que la lista (SliverList) funciona y es eficiente
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -500));
    await tester.pump(); // Actualizar frames

    // Ahora debería encontrar la sección de Shorts que estaba oculta
    expect(find.text('Shorts'), findsAtLeastNWidgets(1));
    
    // 5. Verificar iconos de acción
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byIcon(Icons.cast), findsOneWidget);
  });
}
