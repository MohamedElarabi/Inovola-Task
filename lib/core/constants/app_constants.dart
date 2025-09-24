class AppConstants {
  // App Information
  static const String appName = 'Expense.';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://open.er-api.com/v6';
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration cacheTimeout = Duration(hours: 1);
  
  // Pagination
  static const int defaultPageSize = 10;
  static const int maxPageSize = 50;
  
  // Storage Keys
  static const String expensesBox = 'expenses';
  static const String currenciesBox = 'currencies';
  static const String settingsBox = 'settings';
  
  // Currency
  static const String defaultCurrency = 'USD';
  static const String baseCurrency = 'USD';
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double smallBorderRadius = 8.0;
  
  // Colors
  static const int primaryColorValue = 0xFF2196F3;
  static const int backgroundColorValue = 0xFFF5F5F5;
  static const int cardColorValue = 0xFFFFFFFF;
  static const int textColorValue = 0xFF333333;
  static const int secondaryTextColorValue = 0xFF666666;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Validation
  static const double minAmount = 0.01;
  static const double maxAmount = 999999.99;
  static const int maxDescriptionLength = 500;
  static const int maxCategoryNameLength = 50;
  
  // Date Formats
  static const String dateFormat = 'dd/MM/yy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd/MM/yy HH:mm';
  
  // Error Messages
  static const String networkErrorMessage = 'Network error. Please check your internet connection.';
  static const String serverErrorMessage = 'Server error. Please try again later.';
  static const String unknownErrorMessage = 'An unknown error occurred.';
  static const String validationErrorMessage = 'Please check your input and try again.';
  
  // Success Messages
  static const String expenseAddedMessage = 'Expense added successfully!';
  static const String expenseUpdatedMessage = 'Expense updated successfully!';
  static const String expenseDeletedMessage = 'Expense deleted successfully!';
  static const String receiptAttachedMessage = 'Receipt attached successfully!';
}
