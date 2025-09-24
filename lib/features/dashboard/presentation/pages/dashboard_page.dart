import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../add_expense/presentation/pages/add_expense_page.dart';
import '../../../expense/presentation/bloc/expense_bloc.dart';
import '../../../expense/presentation/bloc/expense_event.dart';
import '../../../expense/presentation/bloc/expense_state.dart';
import '../widgets/balance_card.dart';
import '../widgets/filter_dropdown.dart';
import '../widgets/recent_expenses_list.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String selectedFilter = 'This month';
  String? selectedCategory;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            // Header
            _buildHeader(),

            // Recent Expenses Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recent Expenses',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to all expenses page
                          },
                          child: const Text(
                            'see all',
                            style: TextStyle(
                              color: Color(0xFF2196F3),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: BlocBuilder<ExpenseBloc, ExpenseState>(
                        builder: (context, state) {
                          if (state is ExpenseLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is ExpenseLoaded) {
                            return RecentExpensesList(
                              expenses: state.expenses,
                              hasMore: state.hasMore,
                              onLoadMore: () {
                                context.read<ExpenseBloc>().add(
                                      LoadExpenses(
                                        page: state.currentPage + 1,
                                        filter: selectedFilter,
                                        category: selectedCategory,
                                      ),
                                    );
                              },
                            );
                          } else if (state is ExpenseError) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    size: 64,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Error: ${state.message}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<ExpenseBloc>().add(
                                            const LoadExpenses(),
                                          );
                                    },
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            );
                          }
                          return const Center(
                            child: Text('No expenses found'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddExpensePage(),
              ),
            );
          },
          backgroundColor: const Color(0xFF2196F3),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      );

  Widget _buildHeader() => Stack(
        children: [
          Container(
            height: 300,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF2136F0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Color(0xFF2196F3),
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Shihab Rahman',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  FilterDropdown(
                    selectedFilter: selectedFilter,
                    onFilterChanged: (filter) {
                      setState(() {
                        selectedFilter = filter;
                      });
                      context.read<ExpenseBloc>().add(
                            LoadExpenses(filter: filter, category: selectedCategory),
                          );
                    },
                  )
                ],
              ),
            ),
          ),
          // Balance Card
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: (context, state) {
                if (state is ExpenseLoaded) {
                  return BalanceCard(
                    totalBalance: state.totalBalance,
                    totalIncome: state.totalIncome,
                    totalExpenses: state.totalExpenses,
                    selectedFilter: selectedFilter,
                    onFilterChanged: (filter) {
                      setState(() {
                        selectedFilter = filter;
                      });
                      context.read<ExpenseBloc>().add(
                            LoadExpenses(filter: filter, category: selectedCategory),
                          );
                    },
                  );
                }
                return const SizedBox(height: 200);
              },
            ),
          ),
        ],
      );
}
