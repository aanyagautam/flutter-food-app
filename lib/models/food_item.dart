class FoodItem {
  final String id;
  final String name;
  final double price;
  final String image;
  final String? description;
  final bool isAvailable;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.description,
    this.isAvailable = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'description': description,
      'isAvailable': isAvailable,
    };
  }

  factory FoodItem.fromMap(Map<String, dynamic> map) {
    return FoodItem(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      image: map['image'] ?? '',
      description: map['description'],
      isAvailable: map['isAvailable'] ?? true,
    );
  }

  FoodItem copyWith({
    String? id,
    String? name,
    double? price,
    String? image,
    String? description,
    bool? isAvailable,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
