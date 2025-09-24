import 'package:flutter/material.dart';
import '../../../expense/domain/entities/expense.dart';
import '../../../expense/domain/entities/category.dart';

class RecentExpensesList extends StatelessWidget {
  const RecentExpensesList({
    required this.expenses,
    required this.hasMore,
    required this.onLoadMore,
    super.key,
  });
  final List<Expense> expenses;
  final bool hasMore;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No expenses yet',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Add your first expense to get started',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: expenses.length + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == expenses.length) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ElevatedButton(
                onPressed: onLoadMore,
                child: const Text('Load More'),
              ),
            ),
          );
        }

        final expense = expenses[index];
        return ExpenseListItem(expense: expense);
      },
    );
  }
}

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem({required this.expense, super.key});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final category = Category.defaultCategories.firstWhere(
      (cat) => cat.name.toLowerCase() == expense.category.toLowerCase(),
      orElse: () => const Category(
        id: 'other',
        name: 'Other',
        iconPath: 'assets/icons/other.png',
        color: '#9E9E9E',
      ),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Category Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _getCategoryColor(category.name).withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              _getCategoryIcon(category.name),
              color: _getCategoryColor(category.name),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),

          // Expense Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.category,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Manually',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Amount and Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Original amount
              Text(
                '- ${expense.amount.toStringAsFixed(2)} ${expense.currency}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
              // Converted amount (if different from original)
              if (expense.currency != 'USD' && expense.convertedAmount != null)
                Text(
                  '≈ \$${expense.convertedAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              const SizedBox(height: 4),
              Text(
                _formatDate(expense.date),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'groceries':
        return const Color(0xFFFF6B6B);
      case 'entertainment':
        return const Color(0xFF4ECDC4);
      case 'transport':
        return const Color(0xFF45B7D1);
      case 'rent':
        return const Color(0xFF96CEB4);
      case 'shopping':
        return const Color(0xFFFFEAA7);
      case 'gas':
        return const Color(0xFFDDA0DD);
      case 'news paper':
        return const Color(0xFF98D8C8);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'groceries':
        return Icons.shopping_cart;
      case 'entertainment':
        return Icons.movie;
      case 'transport':
        return Icons.directions_car;
      case 'rent':
        return Icons.home;
      case 'shopping':
        return Icons.shopping_bag;
      case 'gas':
        return Icons.local_gas_station;
      case 'news paper':
        return Icons.newspaper;
      default:
        return Icons.category;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today ${_formatTime(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday ${_formatTime(date)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  String _formatTime(DateTime date) {
    final hour = date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }
}
