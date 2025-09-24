
abstract class ExpenseRemoteDataSource {
  Future<double> convertCurrency(String fromCurrency, String toCurrency, double amount);
}

class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  @override
  Future<double> convertCurrency(String fromCurrency, String toCurrency, double amount) async {
    // This will be implemented using the currency conversion API
    // For now, return a mock conversion
    if (fromCurrency == toCurrency) {
      return amount;
    }
    
    // Mock conversion rates (in real implementation, this would call the API)
    final mockRates = {
      'USD': 1.0,
      'EUR': 0.85,
      'GBP': 0.73,
      'JPY': 110.0,
      'EGP': 30.0,
    };
    
    final fromRate = mockRates[fromCurrency] ?? 1.0;
    final toRate = mockRates[toCurrency] ?? 1.0;
    
    return amount * (toRate / fromRate);
  }
}
