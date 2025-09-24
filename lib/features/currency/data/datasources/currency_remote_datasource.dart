import '../../../../core/network/api_client.dart';
import '../../../../core/errors/exceptions.dart';

abstract class CurrencyRemoteDataSource {
  Future<Map<String, dynamic>> getExchangeRates();
  Future<double> convertCurrency(String fromCurrency, String toCurrency, double amount);
}

class CurrencyRemoteDataSourceImpl implements CurrencyRemoteDataSource {
  CurrencyRemoteDataSourceImpl({required ApiClient apiClient}) : _apiClient = apiClient;
  final ApiClient _apiClient;

  @override
  Future<Map<String, dynamic>> getExchangeRates() async {
    try {
      final response = await _apiClient.get('/latest/USD');

      if (response.statusCode == 200) {
        final data = response.data;
        print('=========================');
        print(data);
        print('=========================');

        if (data['result'] == 'success') {
          return Map<String, dynamic>.from(data['rates']);
        } else {
          throw const ServerException(
            message: 'Failed to fetch exchange rates',
          );
        }
      } else {
        throw ServerException(
          message: 'Failed to fetch exchange rates: ${response.statusCode}',
          code: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ServerException || e is ValidationException) {
        rethrow;
      }
      throw NetworkException(
        message: 'Error fetching exchange rates: $e',
      );
    }
  }

  @override
  Future<double> convertCurrency(String fromCurrency, String toCurrency, double amount) async {
    try {
      print('Currency conversion: $amount $fromCurrency -> $toCurrency');
      // Get rates for the from currency
      final response = await _apiClient.get('/latest/$fromCurrency');

      if (response.statusCode == 200) {
        final data = response.data;
        print('API Response: $data');
        if (data['result'] == 'success') {
          final rates = Map<String, dynamic>.from(data['rates']);
          final toRate = rates[toCurrency];
          print('Exchange rate for $toCurrency: $toRate');

          if (toRate != null) {
            final convertedAmount = amount * (toRate as num).toDouble();
            print('Final conversion: $amount $fromCurrency = $convertedAmount $toCurrency');
            return convertedAmount;
          } else {
            throw ValidationException(
              message: 'Currency $toCurrency not found',
            );
          }
        } else {
          throw const ServerException(
            message: 'Failed to convert currency',
          );
        }
      } else {
        throw ServerException(
          message: 'Failed to convert currency: ${response.statusCode}',
          code: response.statusCode,
        );
      }
    } catch (e) {
      print('Currency conversion error: $e');
      if (e is ServerException) {
        rethrow;
      }
      throw NetworkException(
        message: 'Error converting currency: $e',
      );
    }
  }
}
