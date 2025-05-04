import 'package:flutter/foundation.dart';
import '../models/restaurant.dart';
import '../models/food_item.dart';
import '../models/add_on.dart';

class RestaurantProvider extends ChangeNotifier {
  // Sample data - in a real app, this would come from an API or database
  final List<Restaurant> _restaurants = [
    Restaurant(
      id: 'restaurant1',
      name: 'Malaysian Civil Madam',
      description: 'Serving traditional food',
      imageUrl: 'assets/restaurant1.jpg',
      address: '123 Jalan Bukit Bintang, Kuala Lumpur',
      menu: [
        FoodItem(
          id: 'seafood_asam_pedas',
          name: 'Seafood Asam Pedas',
          description: 'Spicy & sour seafood soup',
          price: 10.00,
          imageUrl: 'assets/food1.jpg',
          type: 'Food',
          restaurantId: 'restaurant1',
          addOns: [
            AddOn(id: 'rice', name: 'Rice', price: 1.00),
            AddOn(id: 'lai', name: 'Lai', price: 1.50),
          ],
        ),
        FoodItem(
          id: 'teh_tarik',
          name: 'Teh Tarik',
          description: 'Malaysian pulled milk tea',
          price: 3.50,
          imageUrl: 'assets/beverage1.jpg',
          type: 'Beverage',
          restaurantId: 'restaurant1',
        ),
      ],
    ),
    Restaurant(
      id: 'restaurant2',
      name: 'Pak Tam',
      description: 'Asian Fusion',
      imageUrl: 'assets/restaurant2.jpg',
      address: '45 Jalan Alor, Kuala Lumpur',
      menu: [
        FoodItem(
          id: 'mee_goreng',
          name: 'Mee Goreng',
          description: 'Malaysian stir-fried noodle dish',
          price: 9.00,
          imageUrl: 'assets/food2.jpg',
          type: 'Food',
          restaurantId: 'restaurant2',
        ),
        FoodItem(
          id: 'sirap_bandung',
          name: 'Sirap Bandung',
          description: 'Rose syrup with milk',
          price: 3.00,
          imageUrl: 'assets/beverage2.jpg',
          type: 'Beverage',
          restaurantId: 'restaurant2',
        ),
      ],
    ),
    Restaurant(
      id: 'restaurant3',
      name: 'Nasi Lemak Wang',
      description: 'You can find elite delicious Nasi Lemak here',
      imageUrl: 'assets/restaurant3.jpg',
      address: '78 Jalan Ampang, Kuala Lumpur',
      menu: [
        FoodItem(
          id: 'nasi_ayam_pedas',
          name: 'Nasi Ayam Pedas',
          description: 'Spiced stew chicken served with laksa leaves',
          price: 10.00,
          imageUrl: 'assets/food3.jpg',
          type: 'Food',
          restaurantId: 'restaurant3',
        ),
        FoodItem(
          id: 'iced_lemon_tea',
          name: 'Iced Lemon Tea',
          description: 'Refreshing tea with fresh lemon',
          price: 4.00,
          imageUrl: 'assets/beverage3.jpg',
          type: 'Beverage',
          restaurantId: 'restaurant3',
        ),
      ],
    ),
    Restaurant(
      id: 'restaurant4',
      name: 'Xin Bei Ma',
      description: 'You can find low-cost Chinese food here',
      imageUrl: 'assets/restaurant4.jpg',
      address: '15 Jalan Petaling, Kuala Lumpur',
      menu: [
        FoodItem(
          id: 'nasi_ayam_goreng',
          name: 'Nasi Ayam Goreng',
          description: 'Rice served with crispy fried chicken with sweet chili sauce',
          price: 8.00,
          imageUrl: 'assets/food4.jpg',
          type: 'Food',
          restaurantId: 'restaurant4',
        ),
        FoodItem(
          id: 'chinese_tea',
          name: 'Chinese Tea',
          description: 'Traditional Chinese tea',
          price: 2.50,
          imageUrl: 'assets/beverage4.jpg',
          type: 'Beverage',
          restaurantId: 'restaurant4',
        ),
      ],
    ),
  ];

  // Get all restaurants
  List<Restaurant> get restaurants => List.unmodifiable(_restaurants);

  // Get a restaurant by ID
  Restaurant? getRestaurantById(String id) {
    try {
      return _restaurants.firstWhere((restaurant) => restaurant.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get menu items for a specific restaurant
  List<FoodItem> getMenuForRestaurant(String restaurantId) {
    final restaurant = getRestaurantById(restaurantId);
    return restaurant?.menu ?? [];
  }

  // Get menu items filtered by type for a specific restaurant
  List<FoodItem> getFilteredMenuForRestaurant(String restaurantId, String type) {
    if (type == 'All') {
      return getMenuForRestaurant(restaurantId);
    }
    return getMenuForRestaurant(restaurantId)
        .where((item) => item.type == type)
        .toList();
  }
}