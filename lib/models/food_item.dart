class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<AddOn> addOns;


  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.addOns = const [],

  });
}

class AddOn {
  final String id;
  final String name;
  final double price;

  AddOn({
    required this.id,
    required this.name,
    required this.price,
  });
}