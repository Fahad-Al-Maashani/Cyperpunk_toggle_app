import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/main.dart';

void main() {
  testWidgets('Adding and toggling items with neon popup', (WidgetTester tester) async {
    // Load the app
    await tester.pumpWidget(const CyberpunkToggleApp());
    await tester.pumpAndSettle();

    // Verify initial state (No items present)
    expect(find.byType(ListTile), findsNothing);

    // Add multiple items
    await tester.enterText(find.byType(TextField), 'Hack the Mainframe');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Explore Neon City');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Ensure items exist in the list
    expect(find.text('Hack the Mainframe'), findsOneWidget);
    expect(find.text('Explore Neon City'), findsOneWidget);

    // Toggle the first switch ON
    await tester.tap(find.byType(Switch).first);
    await tester.pumpAndSettle();

    // Verify popup appears with "System Upgrade Completed!"
    expect(find.text("⚡ System Upgrade Completed!"), findsOneWidget);

    // Close the popup
    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();
  });
}
