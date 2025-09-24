import '../../../../core/utils/hive_helper.dart';

abstract class CurrencyLocalDataSource {
  Future<Map<String, dynamic>> getCachedExchangeRates();
  Future<void> cacheExchangeRates(Map<String, dynamic> rates);
}

class CurrencyLocalDataSourceImpl implements CurrencyLocalDataSource {
  @override
  Future<Map<String, dynamic>> getCachedExchangeRates() async {
    try {
      final box = HiveHelper.settingsBox;
      final cachedRates = box.get('exchange_rates');
      final cacheTime = box.get('exchange_rates_cache_time');
      
      if (cachedRates != null && cacheTime != null) {
        final now = DateTime.now();
        final cacheDateTime = DateTime.parse(cacheTime as String);
        
        // Cache is valid for 1 hour
        if (now.difference(cacheDateTime).inHours < 1) {
          return Map<String, dynamic>.from(cachedRates as Map);
        }
      }
      
      return {};
    } catch (e) {
      return {};
    }
  }

  @override
  Future<void> cacheExchangeRates(Map<String, dynamic> rates) async {
    try {
      final box = HiveHelper.settingsBox;
      await box.put('exchange_rates', rates);
      await box.put('exchange_rates_cache_time', DateTime.now().toIso8601String());
    } catch (e) {
      // Ignore cache errors
    }
  }
}
