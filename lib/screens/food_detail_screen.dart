import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/food_item.dart';
import '../models/cart_item.dart';
import '../models/add_on.dart';
import '../widgets/cart_icon_badge.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({Key? key}) : super(key: key);

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  final TextEditingController _remarksController = TextEditingController();
  Map<String, bool> _selectedAddOns = {};

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialize addons selection in initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      if (args != null && args.containsKey('foodItem')) {
        final foodItem = args['foodItem'] as FoodItem;
        for (var addon in foodItem.addOns) {
          _selectedAddOns[addon.id] = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get food data from arguments
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Default data in case nothing is passed
    final FoodItem foodItem = args != null && args.containsKey('foodItem')
        ? args['foodItem'] as FoodItem
        : FoodItem(
      id: 'default',
      name: 'Default Item',
      description: 'Default description',
      price: 10.00,
      imageUrl: 'assets/food1.jpg',
      type: 'Food',
      restaurantId: 'restaurant1',
    );

    final String restaurantName = args != null && args.containsKey('restaurantName')
        ? args['restaurantName'] as String
        : 'Default Restaurant';

    final String restaurantAddress = args != null && args.containsKey('restaurantAddress')
        ? args['restaurantAddress'] as String
        : 'Default Address';

    // Calculate total price
    double totalPrice = foodItem.price;
    List<AddOn> selectedAddOns = [];

    foodItem.addOns.forEach((addOn) {
      if (_selectedAddOns[addOn.id] == true) {
        selectedAddOns.add(addOn);
        totalPrice += addOn.price;
      }
    });

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
          // Food price and type at the top
          Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          color: const Color(0xFF1F7A7A),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Food type badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: foodItem.type == 'Food' ? Colors.green[100] : Colors.blue[100],
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  foodItem.type,
                  style: TextStyle(
                    color: foodItem.type == 'Food' ? Colors.green[800] : Colors.blue[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Price
              Text(
                'RM${foodItem.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),

        // Add On section (only show if there are add-ons)
        if (foodItem.addOns.isNotEmpty)
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
          // Generate add-on options dynamically
          ...foodItem.addOns.map((addOn) => Row(
            children: [
              Checkbox(
                value: _selectedAddOns[addOn.id] ?? false,
                onChanged: (value) {
                  setState(() {
                    _selectedAddOns[addOn.id] = value ?? false;
                  });
                },
                activeColor: const Color(0xFF1F7A7A),
              ),
              Text(addOn.name),
              const Spacer(),
              Text('RM${addOn.price.toStringAsFixed(2)}'),
            ],
          )).toList(),
        ],
      ),
    ),

    // Remarks section
    Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
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
    onPressed: () {// Add to cart using the provider
      final cartProvider = Provider.of<CartProvider>(context, listen: false);

      // Get selected add-ons
      final selectedAddOns = foodItem.addOns
          .where((addOn) => _selectedAddOns[addOn.id] == true)
          .toList();

      cartProvider.addItem(
        CartItem(
          foodItem: foodItem,
          quantity: 1,
          selectedAddOns: selectedAddOns,
          remarks: _remarksController.text.isNotEmpty
              ? _remarksController.text
              : null,
          restaurantName: restaurantName,
          restaurantAddress: restaurantAddress,
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