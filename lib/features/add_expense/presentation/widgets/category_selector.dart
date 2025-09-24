import 'package:flutter/material.dart';
import '../../../expense/domain/entities/category.dart';

class CategorySelector extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) => GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: .8,
      ),
      itemCount: Category.defaultCategories.length + 1, // +1 for Add Category
      itemBuilder: (context, index) {
        if (index == Category.defaultCategories.length) {
          return _buildAddCategoryItem();
        }

        final category = Category.defaultCategories[index];
        final isSelected = category.name == selectedCategory;

        return _buildCategoryItem(category, isSelected);
      },
    );

  Widget _buildCategoryItem(Category category, bool isSelected) => GestureDetector(
      onTap: () => onCategorySelected(category.name),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isSelected
                  ? _getCategoryColor(category.name)
                  : Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              _getCategoryIcon(category.name),
              color: isSelected ? Colors.white : Colors.grey[600],
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? _getCategoryColor(category.name)
                  : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );

  Widget _buildAddCategoryItem() => GestureDetector(
      onTap: () {
        // Handle add category
      },
      child: const SizedBox.shrink()

      // Column(
      //   children: [
      //     Container(
      //       width: 60,
      //       height: 60,
      //       decoration: BoxDecoration(
      //         color: Colors.grey[200],
      //         borderRadius: BorderRadius.circular(30),
      //         border: Border.all(
      //           color: Colors.grey[400]!,
      //           style: BorderStyle.solid,
      //           width: 2,
      //         ),
      //       ),
      //       child: Icon(
      //         Icons.add,
      //         color: Colors.grey[600],
      //         size: 24,
      //       ),
      //     ),
      //     const SizedBox(height: 8),
      //     Text(
      //       'Add Category',
      //       style: TextStyle(
      //         fontSize: 12,
      //         color: Colors.grey[600],
      //       ),
      //       textAlign: TextAlign.center,
      //       maxLines: 2,
      //       overflow: TextOverflow.ellipsis,
      //     ),
      //   ],
      // ),
    );

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
}
