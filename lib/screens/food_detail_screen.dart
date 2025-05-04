import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/food_item.dart';
import '../models/cart_item.dart';
import '../widgets/cart_icon_badge.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({Key? key}) : super(key: key);

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  bool _riceSelected = false;
  bool _laiSelected = false;
  final TextEditingController _remarksController = TextEditingController();

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This would be passed from the previous screen in a real app
    final FoodItem foodItem = FoodItem(
      id: 'seafood_asam_pedas',
      name: 'Seafood Asam Pedas',
      description: 'Spicy & sour seafood soup',
      price: 10.00,
      imageUrl: 'assets/food1.jpg',
      addOns: [
        AddOn(id: 'rice', name: 'Rice', price: 1.00),
        AddOn(id: 'lai', name: 'Lai', price: 1.50),
      ],
    );

    double totalPrice = foodItem.price;
    List<AddOn> selectedAddOns = [];

    if (_riceSelected) {
      selectedAddOns.add(AddOn(id: 'rice', name: 'Rice', price: 1.00));
      totalPrice += 1.00;
    }

    if (_laiSelected) {
      selectedAddOns.add(AddOn(id: 'lai', name: 'Lai', price: 1.50));
      totalPrice += 1.50;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(foodItem.name),
        centerTitle: true,
        backgroundColor: const Color(0xFF1F7A7A),
        actions: const [
          CartIconWithBadge(),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food price at the top right
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            color: const Color(0xFF1F7A7A),
            child: Text(
              'RM${foodItem.price.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.right,
            ),
          ),

          // Add On section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add On (Optional)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 12.0),
                // Rice option
                Row(
                  children: [
                    Checkbox(
                      value: _riceSelected,
                      onChanged: (value) {
                        setState(() {
                          _riceSelected = value ?? false;
                        });
                      },
                      activeColor: const Color(0xFF1F7A7A),
                    ),
                    const Text('Rice'),
                    const Spacer(),
                    const Text('RM1.00'),
                  ],
                ),
                // Lai option
                Row(
                  children: [
                    Checkbox(
                      value: _laiSelected,
                      onChanged: (value) {
                        setState(() {
                          _laiSelected = value ?? false;
                        });
                      },
                      activeColor: const Color(0xFF1F7A7A),
                    ),
                    const Text('Lai'),
                    const Spacer(),
                    const Text('RM1.50'),
                  ],
                ),

                const SizedBox(height: 20.0),

                // Remarks section
                const Text(
                  'Remarks (Optional)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _remarksController,
                  decoration: InputDecoration(
                    hintText: 'Enter remarks here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  maxLines: 5,
                ),
              ],
            ),
          ),

          const Spacer(),

          // Add to Cart button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Add to cart using the provider
                      final cartProvider = Provider.of<CartProvider>(context, listen: false);
                      cartProvider.addItem(
                        CartItem(
                          foodItem: foodItem,
                          quantity: 1,
                          selectedAddOns: selectedAddOns,
                          remarks: _remarksController.text.isNotEmpty
                              ? _remarksController.text
                              : null,
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Added to cart!'),
                          backgroundColor: Color(0xFF1F7A7A),
                          duration: Duration(seconds: 1),
                        ),
                      );

                      Navigator.pushNamed(context, '/cart');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F7A7A),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    child: const Text(
                      'Add To Cart',
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
                    'RM ${totalPrice.toStringAsFixed(2)}',
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
      ),
    );
  }
}