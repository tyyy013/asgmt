import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        backgroundColor: const Color(0xFF1F7A7A),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.items.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add items to get started',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Cart items
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    final item = cartProvider.items[index];
                    return _buildCartItem(
                      context,
                      item: item,
                      index: index,
                    );
                  },
                ),
              ),

              // Checkout button
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Implement checkout functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Order placed successfully!'),
                              backgroundColor: Color(0xFF1F7A7A),
                            ),
                          );
                          // Clear the cart after checkout
                          cartProvider.clear();
                          // Navigate back to home
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/',
                                  (route) => false
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1F7A7A),
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                        ),
                        child: const Text(
                          'Check out',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F7A7A),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'RM ${cartProvider.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCartItem(
      BuildContext context, {
        required CartItem item,
        required int index,
      }) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          // Food image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              item.foodItem.imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: const Icon(Icons.restaurant, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          // Food info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.foodItem.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'RM ${item.foodItem.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14.0,
                  ),
                ),
                // Show add-ons if any
                if (item.selectedAddOns.isNotEmpty) ...[
                  const SizedBox(height: 4.0),
                  Text(
                    'Add-ons: ${item.selectedAddOns.map((addOn) => addOn.name).join(", ")}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
                // Show remarks if any
                if (item.remarks != null && item.remarks!.isNotEmpty) ...[
                  const SizedBox(height: 4.0),
                  Text(
                    'Remarks: ${item.remarks}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Quantity controls
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (item.quantity > 1) {
                    cartProvider.updateQuantity(index, item.quantity - 1);
                  }
                },
                icon: const Icon(Icons.remove_circle_outline),
                color: const Color(0xFF1F7A7A),
                iconSize: 24,
              ),
              Text(
                item.quantity.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              IconButton(
                onPressed: () {
                  cartProvider.updateQuantity(index, item.quantity + 1);
                },
                icon: const Icon(Icons.add_circle_outline),
                color: const Color(0xFF1F7A7A),
                iconSize: 24,
              ),
              IconButton(
                onPressed: () {
                  cartProvider.removeItem(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item.foodItem.name} removed from cart'),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                icon: const Icon(Icons.delete_outline),
                color: Colors.red,
                iconSize: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}