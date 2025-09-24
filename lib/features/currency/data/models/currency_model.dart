import 'package:hive/hive.dart';
import '../../domain/entities/currency.dart';

part 'currency_model.g.dart';

@HiveType(typeId: 1)
class CurrencyModel extends HiveObject {
  CurrencyModel({
    required this.code,
    required this.name,
    required this.symbol,
    this.exchangeRate,
  });

  factory CurrencyModel.fromEntity(Currency currency) => CurrencyModel(
        code: currency.code,
        name: currency.name,
        symbol: currency.symbol,
        exchangeRate: currency.exchangeRate,
      );

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        code: json['code'],
        name: json['name'],
        symbol: json['symbol'],
        exchangeRate: json['exchangeRate']?.toDouble(),
      );
  @HiveField(0)
  String code;

  @HiveField(1)
  String name;

  @HiveField(2)
  String symbol;

  @HiveField(3)
  dynamic exchangeRate;

  Currency toEntity() => Currency(
        code: code,
        name: name,
        symbol: symbol,
        exchangeRate: exchangeRate,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'symbol': symbol,
        'exchangeRate': exchangeRate,
      };
}
