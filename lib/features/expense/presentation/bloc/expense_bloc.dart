import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/expense_repository.dart';
import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc({required ExpenseRepository expenseRepository})
      : _expenseRepository = expenseRepository,
        super(ExpenseInitial()) {
    on<LoadExpenses>(_onLoadExpenses);
    on<AddExpense>(_onAddExpense);
    on<DeleteExpense>(_onDeleteExpense);
    on<UpdateExpense>(_onUpdateExpense);
    on<RefreshExpenses>(_onRefreshExpenses);
  }
  final ExpenseRepository _expenseRepository;

  Future<void> _onLoadExpenses(LoadExpenses event, Emitter<ExpenseState> emit) async {
    try {
      if (state is ExpenseInitial) {
        emit(ExpenseLoading());
      }

      final expenses = await _expenseRepository.getExpenses(
        page: event.page,
        limit: event.limit,
        filter: event.filter,
        category: event.category,
      );

      final totalBalance = await _expenseRepository.getTotalBalance();
      final totalIncome = await _expenseRepository.getTotalIncome();
      final totalExpenses = await _expenseRepository.getTotalExpenses();

      if (state is ExpenseLoaded) {
        final currentState = state as ExpenseLoaded;
        final allExpenses = event.page == 1 ? expenses : [...currentState.expenses, ...expenses];

        emit(
          currentState.copyWith(
            expenses: allExpenses,
            currentPage: event.page,
            hasMore: expenses.length == event.limit,
            totalBalance: totalBalance,
            totalIncome: totalIncome,
            totalExpenses: totalExpenses,
          ),
        );
      } else {
        emit(
          ExpenseLoaded(
            expenses: expenses,
            currentPage: event.page,
            hasMore: expenses.length == event.limit,
            totalBalance: totalBalance,
            totalIncome: totalIncome,
            totalExpenses: totalExpenses,
          ),
        );
      }
    } catch (e) {
      emit(ExpenseError(message: e.toString()));
    }
  }

  Future<void> _onAddExpense(AddExpense event, Emitter<ExpenseState> emit) async {
    try {
      final expense = await _expenseRepository.addExpense(
        category: event.category,
        amount: event.amount,
        currency: event.currency,
        date: event.date,
        receiptPath: event.receiptPath,
        description: event.description,
      );

      emit(ExpenseAdded(expense: expense));

      // Reload expenses to update the list
      add(const LoadExpenses());
    } catch (e) {
      emit(ExpenseError(message: e.toString()));
    }
  }

  Future<void> _onDeleteExpense(DeleteExpense event, Emitter<ExpenseState> emit) async {
    try {
      await _expenseRepository.deleteExpense(event.expenseId);
      emit(ExpenseDeleted(expenseId: event.expenseId));

      // Reload expenses to update the list
      add(const LoadExpenses());
    } catch (e) {
      emit(ExpenseError(message: e.toString()));
    }
  }

  Future<void> _onUpdateExpense(UpdateExpense event, Emitter<ExpenseState> emit) async {
    try {
      final expense = await _expenseRepository.updateExpense(
        event.expenseId,
        category: event.category,
        amount: event.amount,
        currency: event.currency,
        date: event.date,
        receiptPath: event.receiptPath,
        description: event.description,
      );

      emit(ExpenseUpdated(expense: expense));

      // Reload expenses to update the list
      add(const LoadExpenses());
    } catch (e) {
      emit(ExpenseError(message: e.toString()));
    }
  }

  Future<void> _onRefreshExpenses(RefreshExpenses event, Emitter<ExpenseState> emit) async {
    add(const LoadExpenses());
  }
}
