import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../core/widgets/main_bottom_nav.dart';

class BookingDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> booking;

  const BookingDetailsScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final totalPrice =
        (int.tryParse(booking['pricePerDay'] ?? '0') ?? 0) *
        (booking['totalDays'] ?? 1);
    final insurance = 25;
    final grandTotal = totalPrice + insurance;

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
          'Booking Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Booking Status Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getStatusColor(booking['status']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _getStatusColor(booking['status']).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _getStatusIcon(booking['status']),
                    color: _getStatusColor(booking['status']),
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking['status'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: _getStatusColor(booking['status']),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getStatusMessage(booking['status']),
                          style: TextStyle(
                            fontSize: 13,
                            color: _getStatusColor(booking['status']),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Car Information Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
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
                  const Text(
                    'Vehicle',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          booking['carImage'],
                          width: 100,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking['carName'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryText,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              booking['carType'] ?? 'Luxury',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
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

            const SizedBox(height: 16),

            // Pickup Details
            _buildDetailCard(
              context,
              title: 'Pick-up',
              icon: Icons.calendar_today,
              iconColor: AppColors.primary,
              details: [
                _DetailRow(
                  icon: Icons.event,
                  label: 'Date',
                  value: booking['pickupDate'] ?? 'N/A',
                ),
                _DetailRow(
                  icon: Icons.access_time,
                  label: 'Time',
                  value: booking['pickupTime'] ?? 'N/A',
                ),
                _DetailRow(
                  icon: Icons.location_on,
                  label: 'Location',
                  value: booking['pickupLocation'] ?? 'N/A',
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Return Details
            _buildDetailCard(
              context,
              title: 'Return',
              icon: Icons.event_available,
              iconColor: Colors.orange,
              details: [
                _DetailRow(
                  icon: Icons.event,
                  label: 'Date',
                  value: booking['returnDate'] ?? 'N/A',
                ),
                _DetailRow(
                  icon: Icons.access_time,
                  label: 'Time',
                  value: booking['returnTime'] ?? 'N/A',
                ),
                _DetailRow(
                  icon: Icons.location_on,
                  label: 'Location',
                  value: booking['returnLocation'] ?? 'N/A',
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Payment Summary
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
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
                  const Text(
                    'Payment Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildPriceRow('Daily Rate', '\$${booking['pricePerDay']}'),
                  const SizedBox(height: 12),
                  _buildPriceRow('Duration', '${booking['totalDays']} days'),
                  const SizedBox(height: 12),
                  _buildPriceRow('Insurance', '\$$insurance'),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(height: 1),
                  ),
                  _buildPriceRow('Total', '\$$grandTotal', isTotal: true),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Booking ID
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Booking ID',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    '#${booking['id']}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Action Buttons (Side by Side)
            if (booking['status'] == 'Upcoming')
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _showModifyBookingDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.edit, color: Colors.white),
                        label: const Text(
                          'Modify',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _showCancelDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.cancel, color: Colors.white),
                        label: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomNav(currentIndex: -1),
    );
  }

  Widget _buildDetailCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<_DetailRow> details,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...details.map(
            (detail) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Icon(detail.icon, size: 18, color: AppColors.textSecondary),
                  const SizedBox(width: 12),
                  Text(
                    detail.label,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    detail.value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isTotal ? AppColors.primary : AppColors.primaryText,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 14,
            fontWeight: FontWeight.w700,
            color: isTotal ? AppColors.primary : AppColors.primaryText,
          ),
        ),
      ],
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

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Active':
        return Icons.check_circle;
      case 'Upcoming':
        return Icons.schedule;
      case 'Completed':
        return Icons.done_all;
      case 'Cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  String _getStatusMessage(String status) {
    switch (status) {
      case 'Active':
        return 'Your booking is currently active';
      case 'Upcoming':
        return 'Your booking is confirmed';
      case 'Completed':
        return 'This booking has been completed';
      case 'Cancelled':
        return 'This booking was cancelled';
      default:
        return '';
    }
  }

  void _showModifyBookingDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ModifyBookingSheet(booking: booking),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Cancel Booking?',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'Are you sure you want to cancel this booking? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No, Keep it'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking cancelled successfully'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }
}

class _DetailRow {
  final IconData icon;
  final String label;
  final String value;

  _DetailRow({required this.icon, required this.label, required this.value});
}

// Modify Booking Bottom Sheet
class ModifyBookingSheet extends StatefulWidget {
  final Map<String, dynamic> booking;

  const ModifyBookingSheet({super.key, required this.booking});

  @override
  State<ModifyBookingSheet> createState() => _ModifyBookingSheetState();
}

class _ModifyBookingSheetState extends State<ModifyBookingSheet> {
  late TextEditingController pickupDateController;
  late TextEditingController pickupTimeController;
  late TextEditingController returnDateController;
  late TextEditingController returnTimeController;
  late TextEditingController pickupLocationController;
  late TextEditingController returnLocationController;

  @override
  void initState() {
    super.initState();
    pickupDateController = TextEditingController(
      text: widget.booking['pickupDate'],
    );
    pickupTimeController = TextEditingController(
      text: widget.booking['pickupTime'],
    );
    returnDateController = TextEditingController(
      text: widget.booking['returnDate'],
    );
    returnTimeController = TextEditingController(
      text: widget.booking['returnTime'],
    );
    pickupLocationController = TextEditingController(
      text: widget.booking['pickupLocation'],
    );
    returnLocationController = TextEditingController(
      text: widget.booking['returnLocation'],
    );
  }

  @override
  void dispose() {
    pickupDateController.dispose();
    pickupTimeController.dispose();
    returnDateController.dispose();
    returnTimeController.dispose();
    pickupLocationController.dispose();
    returnLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.softBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 28,
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Modify Booking',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Pickup Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(
                          'Pick-up Details',
                          Icons.calendar_today,
                          AppColors.primary,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: pickupDateController,
                          label: 'Pick-up Date',
                          icon: Icons.event,
                          onTap: () =>
                              _selectDate(context, pickupDateController),
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: pickupTimeController,
                          label: 'Pick-up Time',
                          icon: Icons.access_time,
                          onTap: () =>
                              _selectTime(context, pickupTimeController),
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: pickupLocationController,
                          label: 'Pick-up Location',
                          icon: Icons.location_on,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Return Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(
                          'Return Details',
                          Icons.event_available,
                          Colors.orange,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: returnDateController,
                          label: 'Return Date',
                          icon: Icons.event,
                          onTap: () =>
                              _selectDate(context, returnDateController),
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: returnTimeController,
                          label: 'Return Time',
                          icon: Icons.access_time,
                          onTap: () =>
                              _selectTime(context, returnTimeController),
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: returnLocationController,
                          label: 'Return Location',
                          icon: Icons.location_on,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Save Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Booking modified successfully'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return TextField(
      controller: controller,
      readOnly: onTap != null,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        prefixIcon: Icon(icon, color: AppColors.primary),
        filled: true,
        fillColor: AppColors.cardWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.text = '${picked.day}/${picked.month}/${picked.year}';
    }
  }

  Future<void> _selectTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.text = picked.format(context);
    }
  }
}
