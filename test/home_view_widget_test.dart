import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_time/main.dart';
import 'package:money_time/module/home/local_widgets/page_form.dart';

void main() {
  /// Tests for `HomeView` Widgets.
  testWidgets('Description Text is visible', (WidgetTester tester) async {
    await tester.pumpWidget(const AppRoot());

    final descriptionFinder = find.text(
        'Complete the relevant fields below, to see how much of your time that next purchase will cost you!');

    expect(descriptionFinder, findsOneWidget);
  });

  testWidgets('All TextFormFields are visible', (WidgetTester tester) async {
    await tester.pumpWidget(const AppRoot());

    final formFieldFinder = find.descendant(
        of: find.byType(PageForm), matching: find.byType(TextFormField));

    expect(formFieldFinder, findsNWidgets(5));
  });
}
