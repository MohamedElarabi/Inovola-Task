import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/currency_repository.dart';
import '../../domain/entities/currency.dart';
import 'currency_event.dart';
import 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyRepository _currencyRepository;

  CurrencyBloc({required CurrencyRepository currencyRepository})
      : _currencyRepository = currencyRepository,
        super(CurrencyInitial()) {
    on<LoadExchangeRates>(_onLoadExchangeRates);
    on<ConvertCurrency>(_onConvertCurrency);
    on<RefreshExchangeRates>(_onRefreshExchangeRates);
  }

  Future<void> _onLoadExchangeRates(LoadExchangeRates event, Emitter<CurrencyState> emit) async {
    try {
      emit(CurrencyLoading());

      final exchangeRates = await _currencyRepository.getExchangeRates();
      final currencies = Currency.supportedCurrencies.map((currency) {
        final rate = exchangeRates[currency.code];
        return currency.copyWith(exchangeRate: rate);
      }).toList();

      emit(CurrencyLoaded(exchangeRates: exchangeRates, currencies: currencies));
    } catch (e) {
      emit(CurrencyError(message: e.toString()));
    }
  }

  Future<void> _onConvertCurrency(ConvertCurrency event, Emitter<CurrencyState> emit) async {
    try {
      final convertedAmount = await _currencyRepository.convertCurrency(
        event.fromCurrency,
        event.toCurrency,
        event.amount,
      );

      emit(CurrencyConverted(
        convertedAmount: convertedAmount,
        fromCurrency: event.fromCurrency,
        toCurrency: event.toCurrency,
        originalAmount: event.amount,
      ));
    } catch (e) {
      emit(CurrencyError(message: e.toString()));
    }
  }

  Future<void> _onRefreshExchangeRates(
      RefreshExchangeRates event, Emitter<CurrencyState> emit) async {
    add(const LoadExchangeRates());
  }
}
