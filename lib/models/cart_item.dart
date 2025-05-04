import 'food_item.dart';
import 'add_on.dart';


class CartItem {
  final FoodItem foodItem;
  int quantity;
  final List<AddOn> selectedAddOns;
  final String? remarks;
  final String restaurantName;
  final String restaurantAddress;

  CartItem({
    required this.foodItem,
    this.quantity = 1,
    this.selectedAddOns = const [],
    this.remarks,
    this.restaurantName = '',
    this.restaurantAddress = '',
  });

  // Get the total price of this cart item (food price + add-ons * quantity)
  double get totalPrice {
    double addOnTotal = selectedAddOns.fold(
        0, (sum, addOn) => sum + addOn.price
    );
    return (foodItem.price + addOnTotal) * quantity;
  }
}