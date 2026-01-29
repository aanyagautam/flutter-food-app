import 'package:flutter/foundation.dart';
import '../models/food_item.dart';
import '../models/order_model.dart';

class CartProvider with ChangeNotifier {
  final List<OrderItem> _items = [];

  List<OrderItem> get items => _items;
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  double get totalAmount =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  void addItem(FoodItem foodItem) {
    final existingIndex = _items.indexWhere(
      (item) => item.foodItem.id == foodItem.id,
    );

    if (existingIndex >= 0) {
      _items[existingIndex] = OrderItem(
        foodItem: foodItem,
        quantity: _items[existingIndex].quantity + 1,
      );
    } else {
      _items.add(OrderItem(foodItem: foodItem, quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(FoodItem foodItem) {
    final existingIndex = _items.indexWhere(
      (item) => item.foodItem.id == foodItem.id,
    );

    if (existingIndex >= 0) {
      if (_items[existingIndex].quantity > 1) {
        _items[existingIndex] = OrderItem(
          foodItem: foodItem,
          quantity: _items[existingIndex].quantity - 1,
        );
      } else {
        _items.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  void removeItemCompletely(FoodItem foodItem) {
    _items.removeWhere((item) => item.foodItem.id == foodItem.id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int getItemQuantity(FoodItem foodItem) {
    final item = _items.firstWhere(
      (item) => item.foodItem.id == foodItem.id,
      orElse: () => OrderItem(foodItem: foodItem, quantity: 0),
    );
    return item.quantity;
  }
}
