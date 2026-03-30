// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streakly_app_flutter/features/onboarding/presentation/widgets/template_card.dart';

void main() {
  testWidgets('Template card renders', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TemplateCard(
            title: 'Drink Water',
            subtitle: 'Stay hydrated',
            leading: const Text('💧'),
            selected: true,
            onTap: () {},
          ),
        ),
      ),
    );
    expect(find.text('Drink Water'), findsOneWidget);
  });
}
