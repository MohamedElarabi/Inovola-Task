import 'package:flutter_test/flutter_test.dart';
import '../lib/features/expense/data/datasources/expense_remote_datasource.dart';

void main() {
  group('Currency Calculation Tests', () {
    late ExpenseRemoteDataSourceImpl dataSource;

    setUp(() {
      dataSource = ExpenseRemoteDataSourceImpl();
    });

    test('should convert same currency to itself', () async {
      // Arrange
      const fromCurrency = 'USD';
      const toCurrency = 'USD';
      const amount = 100.0;

      // Act
      final result = await dataSource.convertCurrency(fromCurrency, toCurrency, amount);

      // Assert
      expect(result, equals(100.0));
    });

    test('should convert USD to EUR', () async {
      // Arrange
      const fromCurrency = 'USD';
      const toCurrency = 'EUR';
      const amount = 100.0;

      // Act
      final result = await dataSource.convertCurrency(fromCurrency, toCurrency, amount);

      // Assert
      expect(result, equals(85.0)); // Based on mock rate 0.85
    });

    test('should convert EUR to USD', () async {
      // Arrange
      const fromCurrency = 'EUR';
      const toCurrency = 'USD';
      const amount = 85.0;

      // Act
      final result = await dataSource.convertCurrency(fromCurrency, toCurrency, amount);

      // Assert
      expect(result, equals(100.0)); // 85 * (1.0 / 0.85) = 100
    });

    test('should convert USD to JPY', () async {
      // Arrange
      const fromCurrency = 'USD';
      const toCurrency = 'JPY';
      const amount = 1.0;

      // Act
      final result = await dataSource.convertCurrency(fromCurrency, toCurrency, amount);

      // Assert
      expect(result, equals(110.0)); // Based on mock rate 110.0
    });

    test('should convert JPY to USD', () async {
      // Arrange
      const fromCurrency = 'JPY';
      const toCurrency = 'USD';
      const amount = 110.0;

      // Act
      final result = await dataSource.convertCurrency(fromCurrency, toCurrency, amount);

      // Assert
      expect(result, equals(1.0)); // 110 * (1.0 / 110.0) = 1.0
    });

    test('should convert USD to EGP', () async {
      // Arrange
      const fromCurrency = 'USD';
      const toCurrency = 'EGP';
      const amount = 10.0;

      // Act
      final result = await dataSource.convertCurrency(fromCurrency, toCurrency, amount);

      // Assert
      expect(result, equals(300.0)); // Based on mock rate 30.0
    });

    test('should convert EGP to USD', () async {
      // Arrange
      const fromCurrency = 'EGP';
      const toCurrency = 'USD';
      const amount = 300.0;

      // Act
      final result = await dataSource.convertCurrency(fromCurrency, toCurrency, amount);

      // Assert
      expect(result, equals(10.0)); // 300 * (1.0 / 30.0) = 10.0
    });

    test('should handle zero amount', () async {
      // Arrange
      const fromCurrency = 'USD';
      const toCurrency = 'EUR';
      const amount = 0.0;

      // Act
      final result = await dataSource.convertCurrency(fromCurrency, toCurrency, amount);

      // Assert
      expect(result, equals(0.0));
    });

    test('should handle unknown currency with default rate', () async {
      // Arrange
      const fromCurrency = 'UNKNOWN';
      const toCurrency = 'USD';
      const amount = 100.0;

      // Act
      final result = await dataSource.convertCurrency(fromCurrency, toCurrency, amount);

      // Assert
      expect(result, equals(100.0)); // Default rate is 1.0
    });

    test('should calculate conversion correctly for large amounts', () async {
      // Arrange
      const fromCurrency = 'USD';
      const toCurrency = 'EUR';
      const amount = 10000.0;

      // Act
      final result = await dataSource.convertCurrency(fromCurrency, toCurrency, amount);

      // Assert
      expect(result, equals(8500.0)); // 10000 * 0.85
    });
  });
}
