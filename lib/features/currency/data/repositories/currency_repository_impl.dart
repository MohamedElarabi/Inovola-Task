import '../../domain/repositories/currency_repository.dart';
import '../datasources/currency_local_datasource.dart';
import '../datasources/currency_remote_datasource.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyLocalDataSource _localDataSource;
  final CurrencyRemoteDataSource _remoteDataSource;

  CurrencyRepositoryImpl({
    required CurrencyLocalDataSource localDataSource,
    required CurrencyRemoteDataSource remoteDataSource,
  }) : _localDataSource = localDataSource,
       _remoteDataSource = remoteDataSource;

  @override
  Future<Map<String, dynamic>> getExchangeRates() async {
    try {
      // Try to get cached rates first
      final cachedRates = await _localDataSource.getCachedExchangeRates();
      if (cachedRates.isNotEmpty) {
        return cachedRates;
      }

      // Fetch from remote API
      final rates = await _remoteDataSource.getExchangeRates();
      
      // Cache the rates
      await _localDataSource.cacheExchangeRates(rates);
      
      return rates;
    } catch (e) {
      // Fallback to cached rates if available
      final cachedRates = await _localDataSource.getCachedExchangeRates();
      if (cachedRates.isNotEmpty) {
        return cachedRates;
      }
      throw Exception('Failed to get exchange rates: $e');
    }
  }

  @override
  Future<double> convertCurrency(String fromCurrency, String toCurrency, dynamic amount) async {
    try {
      return await _remoteDataSource.convertCurrency(fromCurrency, toCurrency, amount);
    } catch (e) {
      throw Exception('Failed to convert currency: $e');
    }
  }
}
