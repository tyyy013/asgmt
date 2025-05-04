import 'food_item.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<FoodItem> menu;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.menu,
  });
}