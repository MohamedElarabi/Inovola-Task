import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../features/currency/data/models/currency_model.dart';
import '../../features/expense/data/models/expense_model.dart';

class HiveHelper {
  // Box names (constants)
  static const String expensesBoxName = 'expenses';
  static const String currenciesBoxName = 'currencies';
  static const String settingsBoxName = 'settings';

  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(ExpenseModelAdapter());
    Hive.registerAdapter(CurrencyModelAdapter());

    // Open boxes
    await Hive.openBox(expensesBoxName);
    await Hive.openBox<CurrencyModel>(currenciesBoxName);
    await Hive.openBox(settingsBoxName);
  }

  // Getters
  static Box get expensesBox => Hive.box(expensesBoxName);
  static Box<CurrencyModel> get currenciesBox => Hive.box<CurrencyModel>(currenciesBoxName);
  static Box get settingsBox => Hive.box(settingsBoxName);

  static Future<void> close() async {
    await Hive.close();
  }
}
