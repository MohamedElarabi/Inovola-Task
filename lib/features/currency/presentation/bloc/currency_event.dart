import 'package:equatable/equatable.dart';

abstract class CurrencyEvent extends Equatable {
  const CurrencyEvent();

  @override
  List<Object?> get props => [];
}

class LoadExchangeRates extends CurrencyEvent {
  const LoadExchangeRates();
}

class ConvertCurrency extends CurrencyEvent {
  final String fromCurrency;
  final String toCurrency;
  final double amount;

  const ConvertCurrency({
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
  });

  @override
  List<Object> get props => [fromCurrency, toCurrency, amount];
}

class RefreshExchangeRates extends CurrencyEvent {
  const RefreshExchangeRates();
}
