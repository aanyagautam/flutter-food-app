import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/order_model.dart' as app_models;
// Conditional Firebase import - use stub on web
import 'package:cloud_firestore/cloud_firestore.dart' if (dart.library.html) 'package:flutter_food_app/services/firestore_stub.dart' as cloud_firestore;

class OrderService {
  cloud_firestore.FirebaseFirestore get _firestore => cloud_firestore.FirebaseFirestore.instance;

  // Create new order
  Future<app_models.Order> createOrder({
    required String userId,
    required String childName,
    required String childClass,
    required List<app_models.OrderItem> items,
    String paymentStatus = 'Pending',
  }) async {
    if (kIsWeb) {
      throw 'Firebase is not available on web. Please use Android/iOS for full functionality.';
    }
    
    try {
      double totalAmount = items.fold(
        0.0,
        (sum, item) => sum + item.totalPrice,
      );

      String orderId = _firestore.collection('orders').doc().id;

      app_models.Order order = app_models.Order(
        id: orderId,
        userId: userId,
        childName: childName,
        childClass: childClass,
        items: items,
        totalAmount: totalAmount,
        paymentStatus: paymentStatus,
        orderDate: DateTime.now(),
        status: 'Pending',
      );

      await _firestore.collection('orders').doc(orderId).set(order.toMap());

      return order;
    } catch (e) {
      throw 'Failed to create order: ${e.toString()}';
    }
  }

  // Get user orders
  Stream<List<app_models.Order>> getUserOrders(String userId) {
    if (kIsWeb) {
      return Stream.value([]);
    }
    
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('orderDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => app_models.Order.fromMap(doc.data()))
            .toList());
  }

  // Get order by ID
  Future<app_models.Order?> getOrderById(String orderId) async {
    if (kIsWeb) {
      return null;
    }
    
    try {
      cloud_firestore.DocumentSnapshot doc = await _firestore
          .collection('orders')
          .doc(orderId)
          .get();

      if (doc.exists) {
        return app_models.Order.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
