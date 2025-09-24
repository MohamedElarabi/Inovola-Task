import 'package:equatable/equatable.dart';

class Expense extends Equatable {
  // Always USD

  const Expense({
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
  final dynamic id;
  final dynamic category;
  final dynamic amount;
  final dynamic currency;
  final DateTime date;
  final dynamic receiptPath;
  final dynamic description;
  final dynamic convertedAmount; // Amount converted to USD
  final dynamic convertedCurrency;

  @override
  List<Object?> get props => [
        id,
        category,
        amount,
        currency,
        date,
        receiptPath,
        description,
        convertedAmount,
        convertedCurrency,
      ];

  Expense copyWith({
    id,
    category,
    amount,
    currency,
    DateTime? date,
    receiptPath,
    description,
    convertedAmount,
    convertedCurrency,
  }) =>
      Expense(
        id: id ?? this.id,
        category: category ?? this.category,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        date: date ?? this.date,
        receiptPath: receiptPath ?? this.receiptPath,
        description: description ?? this.description,
        convertedAmount: convertedAmount ?? this.convertedAmount,
        convertedCurrency: convertedCurrency ?? this.convertedCurrency,
      );
}
