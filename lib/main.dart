import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils/create_repo.dart';
import 'core/utils/hive_helper.dart';
import 'features/currency/presentation/bloc/currency_bloc.dart';
import 'features/currency/presentation/bloc/currency_event.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';
import 'features/expense/presentation/bloc/expense_bloc.dart';
import 'features/expense/presentation/bloc/expense_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive
  await HiveHelper.init();

  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // Transparent status bar
          statusBarIconBrightness: Brightness.dark, // Icons in status bar
          statusBarBrightness: Brightness.light, // For iOS
        ),
        child: MultiBlocProvider(
          providers: [
            // Expense BLoC
            BlocProvider<ExpenseBloc>(
              create: (context) => ExpenseBloc(
                expenseRepository: CreateRepo().createExpenseRepository(),
              )..add(const LoadExpenses()),
            ),
            // Currency BLoC
            BlocProvider<CurrencyBloc>(
              create: (context) => CurrencyBloc(
                currencyRepository: CreateRepo().createCurrencyRepository(),
              )..add(const LoadExchangeRates()),
            ),
          ],
          child: MaterialApp(
            title: 'Expense.',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF2196F3), // Blue color from design
              ),
              useMaterial3: true,
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF2196F3),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              cardTheme: CardTheme(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF2196F3)),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            home: const DashboardPage(),
            debugShowCheckedModeBanner: false,
          ),
        ),
      );


}
