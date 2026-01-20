import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/main_bottom_nav.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_search_bar.dart';
import '../../features/mainApp/search_screen.dart';
import '../../features/booking/booking_screen.dart';
import '../../features/booking/view_all_booking_screen.dart';
import '../../features/booking/my_booking_card_screen.dart';
import '../../features/mainApp/map_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Sample bookings data - Replace this with actual data from your state management
  List<Map<String, dynamic>> get myBookings => [
    {
      'id': '1',
      'carName': 'Tesla Model 3',
      'carImage': 'assets/images/car_ex.jpg',
      'carType': 'Electric',
      'pickupDate': '25/01/2026',
      'returnDate': '28/01/2026',
      'pickupTime': '10:00 AM',
      'returnTime': '10:00 AM',
      'pickupLocation': 'Downtown Branch',
      'returnLocation': 'Airport Branch',
      'pricePerDay': '89',
      'totalDays': 3,
      'status': 'Upcoming',
    },
    {
      'id': '2',
      'carName': 'BMW X5',
      'carImage': 'assets/images/car_ex.jpg',
      'carType': 'SUV',
      'pickupDate': '20/01/2026',
      'returnDate': '22/01/2026',
      'pickupTime': '09:00 AM',
      'returnTime': '09:00 AM',
      'pickupLocation': 'Airport Branch',
      'returnLocation': 'Downtown Branch',
      'pricePerDay': '120',
      'totalDays': 2,
      'status': 'Active',
    },
  ];

  // ===================== SECTIONS =====================
  Widget _searchCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchScreen()),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: IgnorePointer(
        ignoring: true,
        child: Container(
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
          child: const AppSearchBar(hint: 'Search for cars...'),
        ),
      ),
    );
  }

  Widget _myBookingsSection(BuildContext context) {
    if (myBookings.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _sectionTitle('My Bookings'),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewAllBookingsScreen(),
                  ),
                );
              },
              child: const Text(
                'View All',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: myBookings.length,
            itemBuilder: (context, index) {
              return _bookingCard(context, myBookings[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _bookingCard(BuildContext context, Map<String, dynamic> booking) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingDetailsScreen(booking: booking),
          ),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                booking['carImage'],
                width: double.infinity,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),

            // Car Name
            Text(
              booking['carName'],
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),

            // Status Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(booking['status']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: _getStatusColor(booking['status']),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    booking['status'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(booking['status']),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Upcoming':
        return AppColors.primary;
      case 'Completed':
        return Colors.grey;
      case 'Cancelled':
        return Colors.red;
      default:
        return AppColors.textSecondary;
    }
  }

  Widget _imageCard() {
    return Container(
      width: double.infinity,
      height: 200,
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
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }

  Widget _bookingActionCard(BuildContext context) {
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
          Positioned(
            left: 20,
            top: 20,
            right: 20,
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
          Positioned(
            left: 20,
            bottom: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookingScreen(),
                  ),
                );
              },
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

  Widget _marketingCard(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
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
            Positioned(
              left: 24,
              bottom: 24,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
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

  Widget _categoriesRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _categoryItem(context, Icons.directions_car, 'Sedan'),
        _categoryItem(context, Icons.sports_motorsports, 'Sport'),
        _categoryItem(context, Icons.airport_shuttle, 'SUV'),
        _categoryItem(context, Icons.electric_car, 'Electric'),
      ],
    );
  }

  Widget _categoryItem(BuildContext context, IconData icon, String label) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(initialCategory: label),
              ),
            );
          },
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.cardWhite,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Icon(icon, color: AppColors.primary, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.primaryText),
        ),
      ],
    );
  }

  Widget _mapCard(BuildContext context) {
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
          Positioned(
            left: 20,
            top: 20,
            right: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Find Nearest Branch',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryText,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Discover our locations\nand visit us today',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            bottom: 20,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapScreen()),
                );
              },
              label: const Text(
                'View Map',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Positioned(
            right: -4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/map.png',
                width: 220,
                fit: BoxFit.contain,
              ),
            ),
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

                    // Image / Hero
                    _imageCard(),
                    const SizedBox(height: 16),

                    // Search
                    _searchCard(context),
                    const SizedBox(height: 24),

                    // My Bookings Section
                    _myBookingsSection(context),
                    const SizedBox(height: 24),

                    // Primary Action
                    _bookingActionCard(context),

                    // Marketing Card
                    const SizedBox(height: 16),
                    _marketingCard(context),
                    const SizedBox(height: 16),

                    // Categories
                    _sectionTitle('Browse Categories'),
                    const SizedBox(height: 12),
                    _categoriesRow(context),

                    const SizedBox(height: 24),

                    // Map
                    _mapCard(context),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MainBottomNav(currentIndex: 0),
    );
  }
}
