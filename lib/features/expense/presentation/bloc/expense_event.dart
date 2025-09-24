import 'package:equatable/equatable.dart';

abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object?> get props => [];
}

class LoadExpenses extends ExpenseEvent {
  const LoadExpenses({
    this.page = 1,
    this.limit = 10,
    this.filter,
    this.category,
  });
  final int page;
  final int limit;
  final String? filter;
  final String? category;

  @override
  List<Object?> get props => [page, limit, filter, category];
}

class AddExpense extends ExpenseEvent {
  const AddExpense({
    required this.category,
    required this.amount,
    required this.currency,
    required this.date,
    this.receiptPath,
    this.description,
  });
  final String category;
  final double amount;
  final String currency;
  final DateTime date;
  final String? receiptPath;
  final String? description;

  @override
  List<Object?> get props => [category, amount, currency, date, receiptPath, description];
}

class DeleteExpense extends ExpenseEvent {
  const DeleteExpense({required this.expenseId});
  final String expenseId;

  @override
  List<Object> get props => [expenseId];
}

class UpdateExpense extends ExpenseEvent {
  const UpdateExpense({
    required this.expenseId,
    this.category,
    this.amount,
    this.currency,
    this.date,
    this.receiptPath,
    this.description,
  });
  final String expenseId;
  final String? category;
  final double? amount;
  final String? currency;
  final DateTime? date;
  final String? receiptPath;
  final String? description;

  @override
  List<Object?> get props => [expenseId, category, amount, currency, date, receiptPath, description];
}

class RefreshExpenses extends ExpenseEvent {
  const RefreshExpenses();
}
