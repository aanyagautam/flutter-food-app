import 'food_item.dart';

class OrderItem {
  final FoodItem foodItem;
  final int quantity;

  OrderItem({
    required this.foodItem,
    required this.quantity,
  });

  double get totalPrice => foodItem.price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'foodItem': foodItem.toMap(),
      'quantity': quantity,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      foodItem: FoodItem.fromMap(map['foodItem']),
      quantity: map['quantity'] ?? 1,
    );
  }
}

class Order {
  final String id;
  final String userId;
  final String childName;
  final String childClass;
  final List<OrderItem> items;
  final double totalAmount;
  final String paymentStatus; // 'Cash' or 'Pending'
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final String status; // 'Pending', 'Confirmed', 'Prepared', 'Delivered'

  Order({
    required this.id,
    required this.userId,
    required this.childName,
    required this.childClass,
    required this.items,
    required this.totalAmount,
    this.paymentStatus = 'Pending',
    required this.orderDate,
    this.deliveryDate,
    this.status = 'Pending',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'childName': childName,
      'childClass': childClass,
      'items': items.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
      'paymentStatus': paymentStatus,
      'orderDate': orderDate.toIso8601String(),
      'deliveryDate': deliveryDate?.toIso8601String(),
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      childName: map['childName'] ?? '',
      childClass: map['childClass'] ?? '',
      items: (map['items'] as List<dynamic>?)
              ?.map((item) => OrderItem.fromMap(item))
              .toList() ??
          [],
      totalAmount: (map['totalAmount'] ?? 0.0).toDouble(),
      paymentStatus: map['paymentStatus'] ?? 'Pending',
      orderDate: map['orderDate'] != null
          ? DateTime.parse(map['orderDate'])
          : DateTime.now(),
      deliveryDate: map['deliveryDate'] != null
          ? DateTime.parse(map['deliveryDate'])
          : null,
      status: map['status'] ?? 'Pending',
    );
  }
}
