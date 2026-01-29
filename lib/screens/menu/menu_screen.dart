import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import '../../models/food_item.dart';
import '../../services/holiday_service.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/food_item_card.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<FoodItem> _menuItems = [];

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
  }

  void _loadMenuItems() {
    // Load menu from constants (can be replaced with Firestore)
    _menuItems = sampleMenuData
        .map((data) => FoodItem(
              id: data['id'],
              name: data['name'],
              price: data['price'],
              image: data['image'],
              description: data['description'],
            ))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isSchoolOpen = HolidayService.isSchoolOpenToday();
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Food Menu',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined,
                    color: AppColors.textPrimary),
                onPressed: () {
                  // Navigate to cart - handled by bottom nav
                },
              ),
              if (cartProvider.itemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cartProvider.itemCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: isSchoolOpen
          ? _menuItems.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _menuItems.length,
                  itemBuilder: (context, index) {
                    return FoodItemCard(foodItem: _menuItems[index]);
                  },
                )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.block_outlined,
                      size: 80,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Ordering Disabled',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.error,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      HolidayService.getHolidayMessage(),
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
