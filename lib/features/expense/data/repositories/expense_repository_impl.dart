import 'package:uuid/uuid.dart';
import '../../domain/entities/expense.dart';
import '../../domain/repositories/expense_repository.dart';
import '../datasources/expense_local_datasource.dart';
import '../../../currency/data/datasources/currency_remote_datasource.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  ExpenseRepositoryImpl({
    required ExpenseLocalDataSource localDataSource,
    required CurrencyRemoteDataSource currencyRemoteDataSource,
  })  : _localDataSource = localDataSource,
        _currencyRemoteDataSource = currencyRemoteDataSource;
  final ExpenseLocalDataSource _localDataSource;
  final CurrencyRemoteDataSource _currencyRemoteDataSource;

  @override
  Future<List<Expense>> getExpenses({
    int page = 1,
    int limit = 10,
    String? filter,
    String? category,
  }) async {
    try {
      return await _localDataSource.getExpenses(
        page: page,
        limit: limit,
        filter: filter,
        category: category,
      );
    } catch (e) {
      throw Exception('Failed to get expenses: $e');
    }
  }

  @override
  Future<Expense> addExpense({
    required String category,
    required double amount,
    required String currency,
    required DateTime date,
    String? receiptPath,
    String? description,
  }) async {
    try {
      // Convert currency to USD if needed
      double? convertedAmount;
      if (currency != 'USD') {
        print('Converting $amount $currency to USD...');
        convertedAmount = await _currencyRemoteDataSource.convertCurrency(
          currency,
          'USD',
          amount,
        );
        print('Converted amount: $convertedAmount USD');
      } else {
        convertedAmount = amount;
        print('Amount already in USD: $amount');
      }

      final expense = Expense(
        id: const Uuid().v4(),
        category: category,
        amount: amount,
        currency: currency,
        date: date,
        receiptPath: receiptPath,
        description: description,
        convertedAmount: convertedAmount,
      );

      await _localDataSource.addExpense(expense);
      return expense;
    } catch (e) {
      throw Exception('Failed to add expense: $e');
    }
  }

  @override
  Future<void> deleteExpense(String expenseId) async {
    try {
      await _localDataSource.deleteExpense(expenseId);
    } catch (e) {
      throw Exception('Failed to delete expense: $e');
    }
  }

  @override
  Future<Expense> updateExpense(
    String expenseId, {
    String? category,
    double? amount,
    String? currency,
    DateTime? date,
    String? receiptPath,
    String? description,
  }) async {
    try {
      final existingExpense = await _localDataSource.getExpenseById(expenseId);

      // Convert currency to USD if needed
      double? convertedAmount;
      if (currency != null && currency != 'USD') {
        convertedAmount = await _currencyRemoteDataSource.convertCurrency(
          currency,
          'USD',
          amount ?? existingExpense.amount,
        );
      } else if (currency == 'USD') {
        convertedAmount = amount ?? existingExpense.amount;
      } else {
        convertedAmount = existingExpense.convertedAmount;
      }

      final updatedExpense = existingExpense.copyWith(
        category: category,
        amount: amount,
        currency: currency,
        date: date,
        receiptPath: receiptPath,
        description: description,
        convertedAmount: convertedAmount,
      );

      await _localDataSource.updateExpense(updatedExpense);
      return updatedExpense;
    } catch (e) {
      throw Exception('Failed to update expense: $e');
    }
  }

  @override
  Future<double> getTotalBalance() async {
    try {
      return await _localDataSource.getTotalBalance();
    } catch (e) {
      throw Exception('Failed to get total balance: $e');
    }
  }

  @override
  Future<double> getTotalIncome() async {
    try {
      return await _localDataSource.getTotalIncome();
    } catch (e) {
      throw Exception('Failed to get total income: $e');
    }
  }

  @override
  Future<double> getTotalExpenses() async {
    try {
      return await _localDataSource.getTotalExpenses();
    } catch (e) {
      throw Exception('Failed to get total expenses: $e');
    }
  }
}
