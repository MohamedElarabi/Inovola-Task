import 'package:flutter/material.dart';
import '../../../currency/domain/entities/currency.dart';

class CurrencyDropdown extends StatelessWidget {
  final String selectedCurrency;
  final Function(String) onCurrencyChanged;

  const CurrencyDropdown({
    super.key,
    required this.selectedCurrency,
    required this.onCurrencyChanged,
  });

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<String>(
      value: selectedCurrency,
      decoration: const InputDecoration(
        hintText: 'Select Currency',
      ),
      items: Currency.supportedCurrencies.map((currency) => DropdownMenuItem(
          value: currency.code,
          child: Row(
            children: [
              Text(
                currency.symbol,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              Text(currency.code),
              const SizedBox(width: 4),
              Text(
                '- ${currency.name}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        )).toList(),
      onChanged: (value) {
        if (value != null) {
          onCurrencyChanged(value);
        }
      },
    );
}
