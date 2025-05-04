// models/add_on.dart

class AddOn {
  final String id;
  final String name;
  final double price;

  AddOn({
    required this.id,
    required this.name,
    required this.price,
  });

  // Create an AddOn from JSON data
  factory AddOn.fromJson(Map<String, dynamic> json) {
    return AddOn(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }

  // Convert AddOn to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  // Check if two AddOns are equal
  bool equals(AddOn other) {
    return id == other.id && name == other.name && price == other.price;
  }

  // Create a copy of this AddOn
  AddOn copyWith({
    String? id,
    String? name,
    double? price,
  }) {
    return AddOn(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  @override
  String toString() {
    return '$name (RM${price.toStringAsFixed(2)})';
  }
}