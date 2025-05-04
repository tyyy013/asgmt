import 'add_on.dart';

class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<AddOn> addOns;
  final String type; // 'Food' or 'Beverage'
  final String restaurantId; // Add this field

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.addOns = const [],
    this.type = 'Food',
    required this.restaurantId, // Restaurant this item belongs to
  });
}