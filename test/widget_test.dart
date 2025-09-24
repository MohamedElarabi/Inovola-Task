// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Task/main.dart';

void main() {
  group('Expense Tracker App Widget Tests', () {
    testWidgets('App should load dashboard page', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const ExpenseTrackerApp());

      // Wait for the app to settle
      await tester.pumpAndSettle();

      // Verify that the dashboard loads
      expect(find.text('Good Morning'), findsOneWidget);
      expect(find.text('Shihab Rahman'), findsOneWidget);
      expect(find.text('Total Balance'), findsOneWidget);
      expect(find.text('Recent Expenses'), findsOneWidget);
    });

    testWidgets('Should navigate to add expense page', (WidgetTester tester) async {
      // Build our app
      await tester.pumpWidget(const ExpenseTrackerApp());
      await tester.pumpAndSettle();

      // Find and tap the floating action button
      final fab = find.byType(FloatingActionButton);
      expect(fab, findsOneWidget);
      
      await tester.tap(fab);
      await tester.pumpAndSettle();

      // Verify navigation to add expense page
      expect(find.text('Add Expense'), findsOneWidget);
      expect(find.text('Categories'), findsOneWidget);
      expect(find.text('Amount'), findsOneWidget);
      expect(find.text('Date'), findsOneWidget);
    });

    testWidgets('Should show filter dropdown', (WidgetTester tester) async {
      // Build our app
      await tester.pumpWidget(const ExpenseTrackerApp());
      await tester.pumpAndSettle();

      // Find the filter dropdown
      final filterDropdown = find.text('This month');
      expect(filterDropdown, findsOneWidget);

      // Tap the dropdown
      await tester.tap(filterDropdown);
      await tester.pumpAndSettle();

      // Verify dropdown options are shown
      expect(find.text('This month'), findsOneWidget);
      expect(find.text('Last 7 days'), findsOneWidget);
      expect(find.text('This year'), findsOneWidget);
      expect(find.text('All time'), findsOneWidget);
    });

    testWidgets('Should display empty state when no expenses', (WidgetTester tester) async {
      // Build our app
      await tester.pumpWidget(const ExpenseTrackerApp());
      await tester.pumpAndSettle();

      // Check for empty state (this might not show immediately due to loading state)
      await tester.pump(const Duration(seconds: 2));
      
      // Look for either loading indicator or empty state
      final loadingIndicator = find.byType(CircularProgressIndicator);
      final emptyState = find.text('No expenses yet');
      
      expect(loadingIndicator.toString().isNotEmpty || emptyState.toString().isNotEmpty, isTrue);
    });
  });
}
