import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4A90E2);
  static const Color secondary = Color(0xFF50C878);
  static const Color background = Color(0xFFF8F9FA);
  static const Color error = Color(0xFFE74C3C);
  static const Color success = Color(0xFF27AE60);
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
}

class AppStyles {
  static const double borderRadius = 12.0;
  static const double cardElevation = 2.0;
  static const double iconSize = 24.0;
}

// Sample menu data
List<Map<String, dynamic>> sampleMenuData = [
  {
    'id': '1',
    'name': 'Dal Rice',
    'price': 25.0,
    'image': 'assets/images/dal_rice.jpg',
    'description': 'Healthy dal with steamed rice',
  },
  {
    'id': '2',
    'name': 'Roti Sabzi',
    'price': 30.0,
    'image': 'assets/images/roti_sabzi.jpg',
    'description': 'Fresh roti with mixed vegetables',
  },
  {
    'id': '3',
    'name': 'Paneer Curry',
    'price': 50.0,
    'image': 'assets/images/paneer.jpg',
    'description': 'Creamy paneer curry with rice',
  },
  {
    'id': '4',
    'name': 'Chole Bhature',
    'price': 45.0,
    'image': 'assets/images/chole.jpg',
    'description': 'Spicy chole with fluffy bhature',
  },
  {
    'id': '5',
    'name': 'Vegetable Biryani',
    'price': 55.0,
    'image': 'assets/images/biryani.jpg',
    'description': 'Fragrant vegetable biryani',
  },
  {
    'id': '6',
    'name': 'Idli Sambar',
    'price': 35.0,
    'image': 'assets/images/idli.jpg',
    'description': 'Soft idli with sambar and chutney',
  },
];

