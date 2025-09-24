import '../entities/expense.dart';

abstract class ExpenseRepository {
  Future<List<Expense>> getExpenses({
    int page = 1,
    int limit = 10,
    String? filter,
    String? category,
  });

  Future<Expense> addExpense({
    required String category,
    required double amount,
    required String currency,
    required DateTime date,
    String? receiptPath,
    String? description,
  });

  Future<void> deleteExpense(String expenseId);

  Future<Expense> updateExpense(
    String expenseId, {
    String? category,
    double? amount,
    String? currency,
    DateTime? date,
    String? receiptPath,
    String? description,
  });

  Future<double> getTotalBalance();
  Future<double> getTotalIncome();
  Future<double> getTotalExpenses();
}
