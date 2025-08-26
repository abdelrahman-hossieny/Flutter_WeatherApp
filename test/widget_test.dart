import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:weather_app/main.dart';

void main() {
  testWidgets('Weather App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(WeatherApp());

    // Wait for the mock data to load
    await tester.pumpAndSettle(Duration(seconds: 3));

    // Verify that the weather app loads correctly
    expect(find.text('Weather App'), findsOneWidget);

    // Check if we can find weather-related elements
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // Look for search functionality
    expect(find.byIcon(Icons.search), findsOneWidget);

    // Test search dialog
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    expect(find.text('Search City'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);

    // Close dialog
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
  });

  testWidgets('Weather search functionality test', (WidgetTester tester) async {
    await tester.pumpWidget(WeatherApp());
    await tester.pumpAndSettle(Duration(seconds: 3));

    // Open search dialog
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // Enter a city name
    await tester.enterText(find.byType(TextField), 'London');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    // The dialog should close after search
    expect(find.text('Search City'), findsNothing);
  });
}