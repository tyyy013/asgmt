import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/food_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  // Get all items in the cart
  List<CartItem> get items => List.unmodifiable(_items);

  // Get the total number of items in the cart
  int get itemCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  // Get the total price of all items in the cart
  double get totalPrice {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  // Add a food item to the cart
  void addItem(CartItem newItem) {
    // Check if the item already exists in the cart
    int existingIndex = _items.indexWhere(
            (item) => item.foodItem.id == newItem.foodItem.id &&
            _areAddOnsEqual(item.selectedAddOns, newItem.selectedAddOns) &&
            item.remarks == newItem.remarks
    );

    if (existingIndex != -1) {
      // If it exists, increment the quantity
      _items[existingIndex].quantity += newItem.quantity;
    } else {
      // Otherwise, add as a new item
      _items.add(newItem);
    }

    // Notify listeners that the cart has changed
    notifyListeners();
  }

  // Remove an item from the cart
  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  // Update the quantity of an item
  void updateQuantity(int index, int newQuantity) {
    if (index >= 0 && index < _items.length && newQuantity > 0) {
      _items[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  // Clear the cart
  void clear() {
    _items.clear();
    notifyListeners();
  }

  // Helper method to check if two lists of add-ons are equal
  bool _areAddOnsEqual(List<AddOn> list1, List<AddOn> list2) {
    if (list1.length != list2.length) return false;

    for (int i = 0; i < list1.length; i++) {
      if (list1[i].id != list2[i].id) return false;
    }

    return true;
  }
}