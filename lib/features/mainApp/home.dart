import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/main_bottom_nav.dart';
import '../../../core/widgets/app_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBackground,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(greetingName: 'Bailasan'),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Image Card
                    _imageCard(),
                    const SizedBox(height: 24),

                    _bookingCard(),

                    // Marketing Card with Car Background
                    const SizedBox(height: 16),
                    _marketingCard(),
                    const SizedBox(height: 16),

                    _sectionTitle('Browse Categories'),
                    const SizedBox(height: 12),
                    _categoriesRow(),

                    const SizedBox(height: 24),

                    _sectionTitle('Featured Cars'),
                    const SizedBox(height: 12),
                    _featuredCars(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  // ===================== SECTIONS =====================

  Widget _imageCard() {
    return Container(
      width: double.infinity,
      height: 200, // Added height constraint
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          'assets/images/marketing.gif',
          fit: BoxFit.cover,
          alignment:
              Alignment.topCenter, // Keeps the top (text) visible, crops bottom
        ),
      ),
    );
  }

  Widget _bookingCard() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // ---------- Text Content (spans full width) ----------
          Positioned(
            left: 20,
            top: 20,
            right: 20, // Text can go across full width
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Your next ride is waiting',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryText,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Premium cars • Easy booking\nDrive with comfort today',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // ---------- Button ----------
          Positioned(
            left: 20,
            bottom: 20,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Book Now',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // ---------- Car Image (moved to bottom-right) ----------
          Positioned(
            right: -5,
            bottom: -5,
            child: Image.asset(
              'assets/images/car.png',
              width: 170,
              height: 110,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _marketingCard() {
    return Container(
      height: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                  ),
                ),
              ),
            ),
            // Car image on the stripe
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 150,
              child: Center(
                child: Image.asset(
                  'assets/images/car_2.png',
                  width: 600,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Text Content (Left side)
            Positioned(
              left: 24,
              top: 30,
              right: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Drive Your Dreams',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Premium cars at your fingertips.\nBook now and hit the road!',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Explore Button
            Positioned(
              left: 24,
              bottom: 24,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Explore Now',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoriesRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _categoryItem(Icons.directions_car, 'Sedan'),
        _categoryItem(Icons.sports_motorsports, 'Sport'),
        _categoryItem(Icons.airport_shuttle, 'SUV'),
        _categoryItem(Icons.electric_car, 'Electric'),
      ],
    );
  }

  Widget _categoryItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: AppColors.primary, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.primaryText),
        ),
      ],
    );
  }

  Widget _featuredCars() {
    return Column(
      children: [
        _carCard('Tesla Model 3', 'Automatic • Electric'),
        const SizedBox(height: 12),
        _carCard('BMW X5', 'Automatic • SUV'),
      ],
    );
  }

  Widget _carCard(String name, String details) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 90,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.softBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.directions_car,
              size: 36,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryText,
      ),
    );
  }
}
