import 'package:course_app/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('adds and removes a product', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Cart()));

    expect(find.byType(ListTile), findsNothing);

    await tester.enterText(find.byType(TextField), 'Leite');
    await tester.tap(find.text('Add Item'));
    await tester.pump();

    expect(find.text('Leite'), findsOneWidget);
    expect(find.textContaining('Qty: 1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    expect(find.text('Leite'), findsNothing);
    expect(find.byType(ListTile), findsNothing);

    // CartItemTile starts a 2s simulated fetch in initState
    await tester.pump(const Duration(seconds: 2));
  });
}
