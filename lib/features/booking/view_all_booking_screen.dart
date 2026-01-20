import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'my_booking_card_screen.dart';
import '../../core/widgets/main_bottom_nav.dart';

class ViewAllBookingsScreen extends StatelessWidget {
  const ViewAllBookingsScreen({super.key});

  // Sample bookings data - Replace with actual data
  List<Map<String, dynamic>> get allBookings => [
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
    {
      'id': '3',
      'carName': 'Mercedes C-Class',
      'carImage': 'assets/images/car_ex.jpg',
      'carType': 'Sedan',
      'pickupDate': '15/01/2026',
      'returnDate': '17/01/2026',
      'pickupTime': '02:00 PM',
      'returnTime': '02:00 PM',
      'pickupLocation': 'Downtown Branch',
      'returnLocation': 'Downtown Branch',
      'pricePerDay': '95',
      'totalDays': 2,
      'status': 'Completed',
    },
    {
      'id': '4',
      'carName': 'Audi A4',
      'carImage': 'assets/images/car_ex.jpg',
      'carType': 'Sedan',
      'pickupDate': '10/01/2026',
      'returnDate': '12/01/2026',
      'pickupTime': '11:00 AM',
      'returnTime': '11:00 AM',
      'pickupLocation': 'Airport Branch',
      'returnLocation': 'Airport Branch',
      'pricePerDay': '85',
      'totalDays': 2,
      'status': 'Completed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        title: const Text(
          'My Bookings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: allBookings.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: allBookings.length,
              itemBuilder: (context, index) {
                return _buildBookingCard(context, allBookings[index]);
              },
            ),
      bottomNavigationBar: MainBottomNav(currentIndex: -1),
    );
  }

  Widget _buildBookingCard(BuildContext context, Map<String, dynamic> booking) {
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
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
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
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Car Name
            Text(
              booking['carName'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 8),

            // Booking Details Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date Range
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${booking['pickupDate']} - ${booking['returnDate']}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),

                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(booking['status']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    booking['status'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(booking['status']),
                    ),
                  ),
                ),
              ],
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy,
            size: 80,
            color: AppColors.textSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'No bookings yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start booking your dream car today',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
