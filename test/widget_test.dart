import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fit_bite/main.dart';

void main() {
  testWidgets('FitBite loads splash screen without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const FitBiteApp());

    // Initial splash screen content
    expect(find.byType(MaterialApp), findsOneWidget);

    // Pump time forward by 3 seconds (simulate splash timer)
    await tester.pump(const Duration(seconds: 3));

    // Optionally check for navigation to login screen
    expect(find.text('Login'), findsOneWidget); // if login screen has 'Login' text
  });
}
