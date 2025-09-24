import 'package:flutter/material.dart';
import '../widgets/filter_dropdown.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpenses,
    required this.selectedFilter,
    required this.onFilterChanged,
    super.key,
  });
  final double totalBalance;
  final double totalIncome;
  final double totalExpenses;
  final String selectedFilter;
  final Function(String) onFilterChanged;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF2196F3),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Balance',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${totalBalance.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'USD',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildIncomeExpenseItem(
                    '↓ Income',
                    '\$${totalIncome.toStringAsFixed(2)} USD',
                    Colors.white,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildIncomeExpenseItem(
                    '↑ Expenses',
                    '\$${totalExpenses.toStringAsFixed(2)} USD',
                    Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildIncomeExpenseItem(String label, String amount, Color color) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: color.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
}
