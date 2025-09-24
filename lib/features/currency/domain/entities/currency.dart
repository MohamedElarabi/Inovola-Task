import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  // Rate to USD

  const Currency({
    required this.code,
    required this.name,
    required this.symbol,
    this.exchangeRate,
  });
  final String code;
  final String name;
  final String symbol;
  final dynamic exchangeRate;

  @override
  List<Object?> get props => [code, name, symbol, exchangeRate];

  Currency copyWith({
    String? code,
    String? name,
    String? symbol,
    exchangeRate,
  }) =>
      Currency(
        code: code ?? this.code,
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        exchangeRate: exchangeRate ?? this.exchangeRate,
      );

  static const List<Currency> supportedCurrencies = [
    Currency(code: 'USD', name: 'US Dollar', symbol: r'$'),
    Currency(code: 'EUR', name: 'Euro', symbol: '€'),
    Currency(code: 'GBP', name: 'British Pound', symbol: '£'),
    Currency(code: 'JPY', name: 'Japanese Yen', symbol: '¥'),
    Currency(code: 'CAD', name: 'Canadian Dollar', symbol: r'C$'),
    Currency(code: 'AUD', name: 'Australian Dollar', symbol: r'A$'),
    Currency(code: 'CHF', name: 'Swiss Franc', symbol: 'CHF'),
    Currency(code: 'CNY', name: 'Chinese Yuan', symbol: '¥'),
    Currency(code: 'EGP', name: 'Egyptian Pound', symbol: 'E£'),
    Currency(code: 'SAR', name: 'Saudi Riyal', symbol: '﷼'),
  ];
}
