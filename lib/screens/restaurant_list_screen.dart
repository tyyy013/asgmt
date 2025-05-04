import 'package:flutter/material.dart';
import '../widgets/cart_icon_badge.dart';

class RestaurantListScreen extends StatelessWidget {
  const RestaurantListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Tiger'),
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

          // Restaurant list
          Expanded(
            child: ListView(
              children: [
                _buildRestaurantItem(
                  context,
                  name: 'Malaysian Civil Madam',
                  description: 'Serving traditional food',
                  image: 'assets/restaurant1.jpg',
                ),
                _buildRestaurantItem(
                  context,
                  name: 'Pak Tam',
                  description: 'Asian Fusion',
                  image: 'assets/restaurant2.jpg',
                ),
                _buildRestaurantItem(
                  context,
                  name: 'Nasi Lemak Wang',
                  description: 'You can find elite delicious Nasi Lemak here',
                  image: 'assets/restaurant3.jpg',
                ),
                _buildRestaurantItem(
                  context,
                  name: 'Xin Bei Ma',
                  description: 'You can find low-cost Chinese food here',
                  image: 'assets/restaurant4.jpg',
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(0),
    );
  }

  Widget _buildRestaurantItem(
      BuildContext context, {
        required String name,
        required String description,
        required String image,
      }) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/restaurant');
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
            // Restaurant info - moved to the left
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
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            // Restaurant image - moved to the right
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

  Widget _buildBottomNavigationBar(int currentIndex) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
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
    );
  }
}