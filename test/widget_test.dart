import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rapidcare/main.dart';

void main() {
  testWidgets('RapidCare smoke and splash screen load test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RapidCareApp());

    // Verify that the standard subtitle text is rendered
    expect(find.text('Emergency Medical Response'), findsOneWidget);
    expect(find.text('INITIALIZING SYSTEMS'), findsOneWidget);

    // Advance the mock clock by 4 seconds to execute all timers and clean up
    await tester.pump(const Duration(seconds: 4));
  });
}
