import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../../core/widgets/app_search_bar.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/main_bottom_nav.dart';
import '../../features/mainApp/car_details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // List to track favorite cars (in real app, this would come from a database/API)
  List<Map<String, dynamic>> favoriteCars = [
    {
      'id': 1,
      'name': 'BMW X5',
      'transmission': 'Automatic',
      'fuel': 'Diesel',
      'price': 85,
      'rating': 4.8,
      'image': 'assets/images/car_ex.jpg',
    },
    {
      'id': 2,
      'name': 'BMW X5',
      'transmission': 'Automatic',
      'fuel': 'Diesel',
      'price': 85,
      'rating': 4.8,
      'image': 'assets/images/car_ex.jpg',
    },
    {
      'id': 3,
      'name': 'BMW X5',
      'transmission': 'Automatic',
      'fuel': 'Diesel',
      'price': 85,
      'rating': 4.8,
      'image': 'assets/images/car_ex.jpg',
    },
    {
      'id': 4,
      'name': 'BMW X5',
      'transmission': 'Automatic',
      'fuel': 'Diesel',
      'price': 85,
      'rating': 4.8,
      'image': 'assets/images/car_ex.jpg',
    },
    {
      'id': 5,
      'name': 'BMW X5',
      'transmission': 'Automatic',
      'fuel': 'Diesel',
      'price': 85,
      'rating': 4.8,
      'image': 'assets/images/car_ex.jpg',
    },
    {
      'id': 6,
      'name': 'BMW X5',
      'transmission': 'Automatic',
      'fuel': 'Diesel',
      'price': 85,
      'rating': 4.8,
      'image': 'assets/images/car_ex.jpg',
    },
  ];

  void _removeFavorite(int index) {
    setState(() {
      favoriteCars.removeAt(index);
    });

    // Show a snackbar to confirm removal
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Removed from favorites'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primaryText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBackground,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(greetingName: 'Bailasan'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    _searchCard(),
                    const SizedBox(height: 16),
                    Expanded(
                      child: favoriteCars.isEmpty
                          ? _emptyFavoritesWidget()
                          : GridView.builder(
                              itemCount: favoriteCars.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 16,
                                    crossAxisSpacing: 16,
                                    childAspectRatio: 0.80,
                                  ),
                              itemBuilder: (context, index) {
                                return _favoriteCarCard(index);
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomNav(currentIndex: 0),
    );
  }

  Widget _searchCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const AppSearchBar(hint: 'Search favorites...'),
    );
  }

  Widget _favoriteCarCard(int index) {
    final car = favoriteCars[index];

    return GestureDetector(
      onTap: () {
        // Navigate to car details page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CarDetailsScreen(car: car)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with favorite icon overlay
            Stack(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: AppColors.softBackground,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.asset(
                      car['image'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                // Favorite icon with tap functionality
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      // Prevent card tap when tapping favorite icon
                      _removeFavorite(index);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Car details (rest of the code stays the same)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.settings,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        car['transmission'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.local_gas_station,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        car['fuel'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${car['price']}/day',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.softBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${car['rating']}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Empty state when no favorites
  Widget _emptyFavoritesWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: AppColors.textSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'No favorites yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add cars to your favorites to see them here',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
