abstract class CurrencyRepository {
  Future<Map<String, dynamic>> getExchangeRates();
  Future<dynamic> convertCurrency(String fromCurrency, String toCurrency, dynamic amount);
}
