import 'package:equatable/equatable.dart';
import '../../domain/entities/expense.dart';

abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object?> get props => [];
}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;
  final int currentPage;
  final bool hasMore;
  final double totalBalance;
  final double totalIncome;
  final double totalExpenses;

  const ExpenseLoaded({
    required this.expenses,
    required this.currentPage,
    required this.hasMore,
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpenses,
  });

  @override
  List<Object> get props => [expenses, currentPage, hasMore, totalBalance, totalIncome, totalExpenses];

  ExpenseLoaded copyWith({
    List<Expense>? expenses,
    int? currentPage,
    bool? hasMore,
    double? totalBalance,
    double? totalIncome,
    double? totalExpenses,
  }) {
    return ExpenseLoaded(
      expenses: expenses ?? this.expenses,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      totalBalance: totalBalance ?? this.totalBalance,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpenses: totalExpenses ?? this.totalExpenses,
    );
  }
}

class ExpenseError extends ExpenseState {
  final String message;

  const ExpenseError({required this.message});

  @override
  List<Object> get props => [message];
}

class ExpenseAdded extends ExpenseState {
  final Expense expense;

  const ExpenseAdded({required this.expense});

  @override
  List<Object> get props => [expense];
}

class ExpenseDeleted extends ExpenseState {
  final String expenseId;

  const ExpenseDeleted({required this.expenseId});

  @override
  List<Object> get props => [expenseId];
}

class ExpenseUpdated extends ExpenseState {
  final Expense expense;

  const ExpenseUpdated({required this.expense});

  @override
  List<Object> get props => [expense];
}
