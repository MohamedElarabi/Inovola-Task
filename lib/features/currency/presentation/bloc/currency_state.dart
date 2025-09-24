import 'package:equatable/equatable.dart';
import '../../domain/entities/currency.dart';

abstract class CurrencyState extends Equatable {
  const CurrencyState();

  @override
  List<Object?> get props => [];
}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final Map<String, dynamic> exchangeRates;
  final List<Currency> currencies;

  const CurrencyLoaded({
    required this.exchangeRates,
    required this.currencies,
  });

  @override
  List<Object> get props => [exchangeRates, currencies];
}

class CurrencyError extends CurrencyState {
  final String message;

  const CurrencyError({required this.message});

  @override
  List<Object> get props => [message];
}

class CurrencyConverted extends CurrencyState {
  final double convertedAmount;
  final String fromCurrency;
  final String toCurrency;
  final double originalAmount;

  const CurrencyConverted({
    required this.convertedAmount,
    required this.fromCurrency,
    required this.toCurrency,
    required this.originalAmount,
  });

  @override
  List<Object> get props => [convertedAmount, fromCurrency, toCurrency, originalAmount];
}
