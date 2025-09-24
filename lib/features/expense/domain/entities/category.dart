import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String iconPath;
  final String color;

  const Category({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.color,
  });

  @override
  List<Object> get props => [id, name, iconPath, color];

  static const List<Category> defaultCategories = [
    Category(
      id: 'groceries',
      name: 'Groceries',
      iconPath: 'assets/icons/groceries.png',
      color: '#FF6B6B',
    ),
    Category(
      id: 'entertainment',
      name: 'Entertainment',
      iconPath: 'assets/icons/entertainment.png',
      color: '#4ECDC4',
    ),
    Category(
      id: 'transport',
      name: 'Transport',
      iconPath: 'assets/icons/transport.png',
      color: '#45B7D1',
    ),
    Category(
      id: 'rent',
      name: 'Rent',
      iconPath: 'assets/icons/rent.png',
      color: '#96CEB4',
    ),
    Category(
      id: 'shopping',
      name: 'Shopping',
      iconPath: 'assets/icons/shopping.png',
      color: '#FFEAA7',
    ),
    Category(
      id: 'gas',
      name: 'Gas',
      iconPath: 'assets/icons/gas.png',
      color: '#DDA0DD',
    ),
    Category(
      id: 'news',
      name: 'News Paper',
      iconPath: 'assets/icons/news.png',
      color: '#98D8C8',
    ),
  ];
}
