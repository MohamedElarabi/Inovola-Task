import 'package:hive/hive.dart';
import '../../domain/entities/expense.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {
  ExpenseModel({
    required this.id,
    required this.category,
    required this.amount,
    required this.currency,
    required this.date,
    this.receiptPath,
    this.description,
    this.convertedAmount,
    this.convertedCurrency = 'USD',
  });

  factory ExpenseModel.fromEntity(Expense expense) => ExpenseModel(
        id: expense.id,
        category: expense.category,
        amount: expense.amount,
        currency: expense.currency,
        date: expense.date,
        receiptPath: expense.receiptPath,
        description: expense.description,
        convertedAmount: expense.convertedAmount,
        convertedCurrency: expense.convertedCurrency,
      );

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        id: json['id']?.toString() ?? '',
        category: json['category']?.toString() ?? '',
        amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
        currency: json['currency']?.toString() ?? 'USD',
        date: DateTime.parse(json['date']?.toString() ?? DateTime.now().toIso8601String()),
        receiptPath: json['receiptPath']?.toString(),
        description: json['description']?.toString(),
        convertedAmount: (json['convertedAmount'] as num?)?.toDouble(),
        convertedCurrency: json['convertedCurrency']?.toString() ?? 'USD',
      );
  @HiveField(0)
  String id;

  @HiveField(1)
  dynamic category;

  @HiveField(2)
  dynamic amount;

  @HiveField(3)
  dynamic currency;

  @HiveField(4)
  DateTime date;

  @HiveField(5)
  dynamic receiptPath;

  @HiveField(6)
  dynamic description;

  @HiveField(7)
  dynamic convertedAmount;

  @HiveField(8)
  dynamic convertedCurrency;

  Expense toEntity() => Expense(
        id: id,
        category: category,
        amount: amount,
        currency: currency,
        date: date,
        receiptPath: receiptPath,
        description: description,
        convertedAmount: convertedAmount,
        convertedCurrency: convertedCurrency,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'category': category,
        'amount': amount,
        'currency': currency,
        'date': date.toIso8601String(),
        'receiptPath': receiptPath,
        'description': description,
        'convertedAmount': convertedAmount,
        'convertedCurrency': convertedCurrency,
      };
}
