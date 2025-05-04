import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_icon_badge.dart';
import '../providers/filter_provider.dart';
import '../providers/restaurant_provider.dart';
import '../models/food_item.dart';
import '../models/restaurant.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get restaurant ID from route arguments
    final restaurantId = ModalRoute.of(context)!.settings.arguments as String? ?? 'restaurant1';

    // Get providers
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final filterProvider = Provider.of<FilterProvider>(context);

    // Get restaurant data
    final restaurant = restaurantProvider.getRestaurantById(restaurantId);

    if (restaurant == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Restaurant Not Found'),
          centerTitle: true,
          backgroundColor: const Color(0xFF1F7A7A),
        ),
        body: const Center(
          child: Text('Restaurant not found'),
        ),
      );
    }

    // Get filtered menu items for this restaurant
    final filteredMenu = restaurantProvider.getFilteredMenuForRestaurant(
      restaurantId,
      filterProvider.selectedType,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
        centerTitle: true,
        backgroundColor: const Color(0xFF1F7A7A),
        actions: const [
          CartIconWithBadge(),
        ],
      ),
      body: Column(
        children: [
          // Restaurant address
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            color: Colors.grey[200],
            child: Text(
              restaurant.address,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 14.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.filter_list),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
              ),
            ),
          ),

          // Filter buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                _buildFilterButton(
                  context: context,
                  label: 'All',
                  isSelected: filterProvider.selectedType == 'All',
                  onTap: () => filterProvider.setType('All'),
                ),
                const SizedBox(width: 8),
                _buildFilterButton(
                  context: context,
                  label: 'Food',
                  isSelected: filterProvider.selectedType == 'Food',
                  onTap: () => filterProvider.setType('Food'),
                ),
                const SizedBox(width: 8),
                _buildFilterButton(
                  context: context,
                  label: 'Beverage',
                  isSelected: filterProvider.selectedType == 'Beverage',
                  onTap: () => filterProvider.setType('Beverage'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Menu list with filtering
          Expanded(
            child: filteredMenu.isEmpty
                ? const Center(
              child: Text('No items found'),
            )
                : ListView.builder(
              itemCount: filteredMenu.length,
              itemBuilder: (context, index) {
                final item = filteredMenu[index];
                return _buildFoodItem(
                  context,
                  foodItem: item,
                  restaurantName: restaurant.name,
                  restaurantAddress: restaurant.address,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF1F7A7A),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Order List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1F7A7A) : Colors.grey[200],
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildFoodItem(
      BuildContext context, {
        required FoodItem foodItem,
        required String restaurantName,
        required String restaurantAddress,
      }) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/food-detail',
          arguments: {
            'foodItem': foodItem,
            'restaurantName': restaurantName,
            'restaurantAddress': restaurantAddress,
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            // Food info - moved to the left
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        foodItem.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: foodItem.type == 'Food' ? Colors.green[100] : Colors.blue[100],
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          foodItem.type,
                          style: TextStyle(
                            fontSize: 10.0,
                            color: foodItem.type == 'Food' ? Colors.green[800] : Colors.blue[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    foodItem.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'RM${foodItem.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F7A7A),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            // Food image - moved to the right
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                foodItem.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[300],
                  child: const Icon(Icons.restaurant, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}