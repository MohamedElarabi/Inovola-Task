import '../../../../core/utils/hive_helper.dart';
import '../../domain/entities/expense.dart';
import '../models/expense_model.dart';

abstract class ExpenseLocalDataSource {
  Future<List<Expense>> getExpenses({
    int page = 1,
    int limit = 10,
    String? filter,
    String? category,
  });
  Future<Expense> addExpense(Expense expense);
  Future<void> deleteExpense(String expenseId);
  Future<Expense> updateExpense(Expense expense);
  Future<Expense> getExpenseById(String expenseId);
  Future<double> getTotalBalance();
  Future<double> getTotalIncome();
  Future<double> getTotalExpenses();
}

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  @override
  Future<List<Expense>> getExpenses({
    int page = 1,
    int limit = 10,
    String? filter,
    String? category,
  }) async {
    try {
      final box = HiveHelper.expensesBox;
      var expenses = <Expense>[];

      // Handle both old Map format and new ExpenseModel format
      for (final value in box.values) {
        if (value is ExpenseModel) {
          // New format - direct ExpenseModel
          expenses.add(value.toEntity());
        } else if (value is Map) {
          // Old format - Map<String, dynamic>, convert to ExpenseModel
          final expenseModel = ExpenseModel.fromJson(Map<String, dynamic>.from(value));
          expenses.add(expenseModel.toEntity());
        }
      }
      // Apply filter if provided
      if (filter != null) {
        expenses = _applyFilter(expenses, filter);
      }

      // Apply category filter if provided
      if (category != null) {
        expenses = expenses.where((expense) => expense.category == category).toList();
      }

      // Sort by date (newest first)
      expenses.sort((a, b) => b.date.compareTo(a.date));

      // Apply pagination
      final startIndex = (page - 1) * limit;
      final endIndex = startIndex + limit;

      if (startIndex >= expenses.length) {
        return [];
      }

      final paginatedExpenses = expenses.sublist(
        startIndex,
        endIndex > expenses.length ? expenses.length : endIndex,
      );

      return paginatedExpenses;
    } catch (e) {
      throw Exception('Failed to get expenses from local storage: $e');
    }
  }

  @override
  Future<Expense> addExpense(Expense expense) async {
    try {
      final box = HiveHelper.expensesBox;
      final expenseModel = ExpenseModel.fromEntity(expense);
      await box.put(expense.id, expenseModel);
      return expense;
    } catch (e) {
      throw Exception('Failed to add expense to local storage: $e');
    }
  }

  @override
  Future<void> deleteExpense(String expenseId) async {
    try {
      final box = HiveHelper.expensesBox;
      await box.delete(expenseId);
    } catch (e) {
      throw Exception('Failed to delete expense from local storage: $e');
    }
  }

  @override
  Future<Expense> updateExpense(Expense expense) async {
    try {
      final box = HiveHelper.expensesBox;

      final expenseModel = ExpenseModel.fromEntity(expense);
      await box.put(expense.id, expenseModel);
      return expense;
    } catch (e) {
      throw Exception('Failed to update expense in local storage: $e');
    }
  }

  @override
  Future<Expense> getExpenseById(String expenseId) async {
    try {
      final box = HiveHelper.expensesBox;
      final value = box.get(expenseId);
      if (value == null) {
        throw Exception('Expense not found');
      }

      if (value is ExpenseModel) {
        return value.toEntity();
      } else if (value is Map) {
        final expenseModel = ExpenseModel.fromJson(Map<String, dynamic>.from(value));
        return expenseModel.toEntity();
      } else {
        throw Exception('Invalid data format');
      }
    } catch (e) {
      throw Exception('Failed to get expense by ID: $e');
    }
  }

  @override
  Future<double> getTotalBalance() async {
    try {
      final box = HiveHelper.expensesBox;

      var totalIncome = 0.0;
      var totalExpenses = 0.0;

      for (final value in box.values) {
        Expense expense;
        if (value is ExpenseModel) {
          expense = value.toEntity();
        } else if (value is Map) {
          final expenseModel = ExpenseModel.fromJson(Map<String, dynamic>.from(value));
          expense = expenseModel.toEntity();
        } else {
          continue; // Skip invalid data
        }

        final convertedAmount = expense.convertedAmount ?? expense.amount;
        if (expense.category.toLowerCase().contains('income')) {
          totalIncome += convertedAmount;
        } else {
          totalExpenses += convertedAmount;
        }
      }

      return totalIncome - totalExpenses;
    } catch (e) {
      throw Exception('Failed to calculate total balance: $e');
    }
  }

  @override
  Future<double> getTotalIncome() async {
    try {
      final box = HiveHelper.expensesBox;

      var totalIncome = 0.0;
      for (final value in box.values) {
        Expense expense;
        if (value is ExpenseModel) {
          expense = value.toEntity();
        } else if (value is Map) {
          final expenseModel = ExpenseModel.fromJson(Map<String, dynamic>.from(value));
          expense = expenseModel.toEntity();
        } else {
          continue; // Skip invalid data
        }

        if (expense.category.toLowerCase().contains('income')) {
          totalIncome += expense.convertedAmount ?? expense.amount;
        }
      }
      return totalIncome;
    } catch (e) {
      throw Exception('Failed to calculate total income: $e');
    }
  }

  @override
  Future<double> getTotalExpenses() async {
    try {
      final box = HiveHelper.expensesBox;

      var totalExpenses = 0.0;
      for (final value in box.values) {
        Expense expense;
        if (value is ExpenseModel) {
          expense = value.toEntity();
        } else if (value is Map) {
          final expenseModel = ExpenseModel.fromJson(Map<String, dynamic>.from(value));
          expense = expenseModel.toEntity();
        } else {
          continue; // Skip invalid data
        }

        if (!expense.category.toLowerCase().contains('income')) {
          totalExpenses += expense.convertedAmount ?? expense.amount;
        }
      }
      return totalExpenses;
    } catch (e) {
      throw Exception('Failed to calculate total expenses: $e');
    }
  }

  List<Expense> _applyFilter(List<Expense> expenses, String filter) {
    final now = DateTime.now();

    switch (filter.toLowerCase()) {
      case 'this month':
        final startOfMonth = DateTime(now.year, now.month);
        return expenses
            .where(
              (expense) => expense.date.isAfter(startOfMonth) || expense.date.isAtSameMomentAs(startOfMonth),
            )
            .toList();

      case 'last 7 days':
        final sevenDaysAgo = now.subtract(const Duration(days: 7));
        return expenses
            .where(
              (expense) => expense.date.isAfter(sevenDaysAgo) || expense.date.isAtSameMomentAs(sevenDaysAgo),
            )
            .toList();

      case 'last 30 days':
        final thirtyDaysAgo = now.subtract(const Duration(days: 30));
        return expenses
            .where(
              (expense) => expense.date.isAfter(thirtyDaysAgo) || expense.date.isAtSameMomentAs(thirtyDaysAgo),
            )
            .toList();

      case 'this year':
        final startOfYear = DateTime(now.year);
        return expenses
            .where(
              (expense) => expense.date.isAfter(startOfYear) || expense.date.isAtSameMomentAs(startOfYear),
            )
            .toList();

      case 'last year':
        final startOfLastYear = DateTime(now.year - 1);
        final endOfLastYear = DateTime(now.year);
        return expenses
            .where(
              (expense) => expense.date.isAfter(startOfLastYear) && expense.date.isBefore(endOfLastYear),
            )
            .toList();

      case 'all time':
      default:
        return expenses;
    }
  }
}
