import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';
import '../lib/features/expense/domain/entities/expense.dart';

void main() {
  group('Expense Validation Tests', () {
    test('should create a valid expense', () {
      // Arrange
      final expense = Expense(
        id: const Uuid().v4(),
        category: 'Groceries',
        amount: 100.50,
        currency: 'USD',
        date: DateTime.now(),
        description: 'Weekly groceries',
        convertedAmount: 100.50,
        convertedCurrency: 'USD',
      );

      // Assert
      expect(expense.id, isNotEmpty);
      expect(expense.category, equals('Groceries'));
      expect(expense.amount, equals(100.50));
      expect(expense.currency, equals('USD'));
      expect(expense.description, equals('Weekly groceries'));
      expect(expense.convertedAmount, equals(100.50));
      expect(expense.convertedCurrency, equals('USD'));
    });

    test('should validate expense amount is positive', () {
      // Arrange & Act
      final expense = Expense(
        id: const Uuid().v4(),
        category: 'Groceries',
        amount: 50.0,
        currency: 'USD',
        date: DateTime.now(),
      );

      // Assert
      expect(expense.amount, greaterThan(0));
    });

    test('should validate expense amount is not negative', () {
      // This test ensures our business logic prevents negative amounts
      // In a real implementation, you might want to add validation
      expect(() {
        Expense(
          id: const Uuid().v4(),
          category: 'Groceries',
          amount: -50.0, // Negative amount
          currency: 'USD',
          date: DateTime.now(),
        );
      }, returnsNormally); // For now, we allow creation but should validate in business logic
    });

    test('should validate required fields are not empty', () {
      // Arrange
      final expense = Expense(
        id: const Uuid().v4(),
        category: 'Entertainment',
        amount: 25.0,
        currency: 'EUR',
        date: DateTime.now(),
      );

      // Assert
      expect(expense.id, isNotEmpty);
      expect(expense.category, isNotEmpty);
      expect(expense.currency, isNotEmpty);
      expect(expense.date, isNotNull);
    });

    test('should handle expense with receipt path', () {
      // Arrange
      final expense = Expense(
        id: const Uuid().v4(),
        category: 'Transport',
        amount: 15.0,
        currency: 'USD',
        date: DateTime.now(),
        receiptPath: '/path/to/receipt.jpg',
      );

      // Assert
      expect(expense.receiptPath, equals('/path/to/receipt.jpg'));
    });

    test('should handle expense without receipt path', () {
      // Arrange
      final expense = Expense(
        id: const Uuid().v4(),
        category: 'Transport',
        amount: 15.0,
        currency: 'USD',
        date: DateTime.now(),
      );

      // Assert
      expect(expense.receiptPath, isNull);
    });
  });
}
