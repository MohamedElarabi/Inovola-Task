import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({
    required this.selectedCategory,
    required this.onCategoryChanged,
    super.key,
  });
  final String? selectedCategory;
  final Function(String?) onCategoryChanged;

  static const List<String> categories = [
    'All Categories',
    'Food & Dining',
    'Transportation',
    'Shopping',
    'Entertainment',
    'Bills & Utilities',
    'Healthcare',
    'Travel',
    'Education',
    'Income',
    'Other',
  ];

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String?>(
            value: selectedCategory,
            icon: const Icon(
              Icons.filter_list,
              color: Color(0xFF2196F3),
              size: 20,
            ),
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            dropdownColor: Colors.white,
            hint: const Text('Filter by Category'),
            items: categories
                .map(
                  (category) => DropdownMenuItem<String?>(
                    value: category == 'All Categories' ? null : category,
                    child: Text(category),
                  ),
                )
                .toList(),
            onChanged: onCategoryChanged,
          ),
        ),
      );
}

