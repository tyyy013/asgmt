import 'package:flutter/material.dart';
import '../widgets/cart_icon_badge.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pak Tam'),
        centerTitle: true,
        backgroundColor: const Color(0xFF1F7A7A),
        actions: const [
          CartIconWithBadge(),
        ],
      ),
      body: Column(
        children: [
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

          // Food menu list
          Expanded(
            child: ListView(
              children: [
                _buildFoodItem(
                  context,
                  name: 'Seafood Asam Pedas',
                  description: 'Spicy & sour seafood soup',
                  price: 'RM10.00',
                  image: 'assets/food1.jpg',
                ),
                _buildFoodItem(
                  context,
                  name: 'Mee Goreng',
                  description: 'Malaysian stir-fried noodle dish',
                  price: 'RM9.00',
                  image: 'assets/food2.jpg',
                ),
                _buildFoodItem(
                  context,
                  name: 'Nasi Ayam Pedas',
                  description: 'RM9.00, spiced stew chicken served with laksa leaves',
                  price: 'RM10.00',
                  image: 'assets/food3.jpg',
                ),
                _buildFoodItem(
                  context,
                  name: 'Nasi Ayam Goreng',
                  description: 'RM8.00, rice served with crispy fried chicken with sweet chili sauce',
                  price: 'RM8.00',
                  image: 'assets/food4.jpg',
                ),
              ],
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

  Widget _buildFoodItem(
      BuildContext context, {
        required String name,
        required String description,
        required String price,
        required String image,
      }) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/food-detail');
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
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    price,
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
                image,
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