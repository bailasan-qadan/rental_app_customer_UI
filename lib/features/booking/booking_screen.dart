// lib/features/booking/presentation/booking_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/main_bottom_nav.dart';

// Card Number Formatter
class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

// Expiry Date Formatter
class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll('/', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i == 2) buffer.write('/');
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic>? preSelectedCar;

  const BookingScreen({super.key, this.preSelectedCar});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _currentStep = 0;
  final TextEditingController _searchController = TextEditingController();

  // Payment form controllers
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Expiry date
  DateTime? cardExpiryDate;

  // Booking data
  String? selectedCar;
  String? selectedCarPrice;
  String? selectedCarImage;
  String? selectedCarType;
  DateTime? pickupDate;
  DateTime? returnDate;
  TimeOfDay? pickupTime;
  TimeOfDay? returnTime;
  String? pickupLocation;
  String? returnLocation;

  @override
  void initState() {
    super.initState();
    if (widget.preSelectedCar != null) {
      selectedCar = widget.preSelectedCar!['name'];
      selectedCarPrice = widget.preSelectedCar!['price'].toString();
      selectedCarImage = widget.preSelectedCar!['image'];
      selectedCarType = widget.preSelectedCar!['type'] ?? 'Luxury';
      _currentStep = 1;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  // Sample car data
  final List<Map<String, dynamic>> allCars = [
    {
      'name': 'Tesla Model 3',
      'type': 'Electric',
      'price': '89',
      'image': 'assets/images/car_ex.jpg',
      'transmission': 'Automatic',
      'fuel': 'Electric',
      'rating': 4.9,
    },
    {
      'name': 'BMW X5',
      'type': 'SUV',
      'price': '120',
      'image': 'assets/images/car_ex.jpg',
      'transmission': 'Automatic',
      'fuel': 'Diesel',
      'rating': 4.8,
    },
    {
      'name': 'Mercedes C-Class',
      'type': 'Sedan',
      'price': '95',
      'image': 'assets/images/car_ex.jpg',
      'transmission': 'Automatic',
      'fuel': 'Petrol',
      'rating': 4.7,
    },
    {
      'name': 'Audi A4',
      'type': 'Sedan',
      'price': '85',
      'image': 'assets/images/car_ex.jpg',
      'transmission': 'Automatic',
      'fuel': 'Diesel',
      'rating': 4.6,
    },
    {
      'name': 'Porsche 911',
      'type': 'Sport',
      'price': '150',
      'image': 'assets/images/car_ex.jpg',
      'transmission': 'Manual',
      'fuel': 'Petrol',
      'rating': 5.0,
    },
    {
      'name': 'Range Rover Sport',
      'type': 'SUV',
      'price': '130',
      'image': 'assets/images/car_ex.jpg',
      'transmission': 'Automatic',
      'fuel': 'Diesel',
      'rating': 4.8,
    },
  ];

  List<Map<String, dynamic>> get filteredCars {
    return allCars.where((car) {
      final matchesSearch = car['name'].toLowerCase().contains(
        _searchController.text.toLowerCase(),
      );
      return matchesSearch;
    }).toList();
  }

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
          'Book Your Ride',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(child: _buildCurrentStep()),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildBottomButtons(), MainBottomNav(currentIndex: 1)],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildStep(0, 'Car', Icons.directions_car),
          _buildStepLine(0),
          _buildStep(1, 'Date', Icons.calendar_today),
          _buildStepLine(1),
          _buildStep(2, 'Location', Icons.location_on),
          _buildStepLine(2),
          _buildStep(3, 'Payment', Icons.payment),
          _buildStepLine(3),
          _buildStep(4, 'Review', Icons.check_circle),
        ],
      ),
    );
  }

  Widget _buildStep(int step, String label, IconData icon) {
    final isActive = _currentStep >= step;
    final isCurrent = _currentStep == step;

    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.grey.shade300,
            shape: BoxShape.circle,
            border: isCurrent
                ? Border.all(color: AppColors.primary, width: 3)
                : null,
          ),
          child: Icon(
            icon,
            color: isActive ? Colors.white : Colors.grey.shade600,
            size: 18,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w500,
            color: isActive ? AppColors.primary : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(int step) {
    final isActive = _currentStep > step;
    return Expanded(
      flex: 1,
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 30, left: 4, right: 4),
        color: isActive ? AppColors.primary : Colors.grey.shade300,
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildCarSelectionStep();
      case 1:
        return _buildDateTimeStep();
      case 2:
        return _buildLocationStep();
      case 3:
        return _buildPaymentStep();
      case 4:
        return _buildConfirmationStep();
      default:
        return Container();
    }
  }

  // ==================== STEP 1: CAR SELECTION ====================
  Widget _buildCarSelectionStep() {
    if (widget.preSelectedCar != null && selectedCar != null) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selected Car',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your pre-selected vehicle',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            _buildCarGridCard(widget.preSelectedCar!),
            const SizedBox(height: 20),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    selectedCar = null;
                    selectedCarPrice = null;
                    selectedCarImage = null;
                    selectedCarType = null;
                  });
                },
                icon: const Icon(Icons.change_circle),
                label: const Text('Change Car'),
                style: TextButton.styleFrom(foregroundColor: AppColors.primary),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Your Car',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.softBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() {}),
                  decoration: const InputDecoration(
                    hintText: 'Search for cars...',
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: AppColors.textSecondary),
                    hintStyle: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: filteredCars.isEmpty
              ? _emptyState()
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: filteredCars.length,
                  itemBuilder: (context, index) {
                    return _buildCarGridCard(filteredCars[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildCarGridCard(Map<String, dynamic> car) {
    final isSelected = selectedCar == car['name'];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCar = car['name'];
          selectedCarPrice = car['price'];
          selectedCarImage = car['image'];
          selectedCarType = car['type'];
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
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
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    car['image'],
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                if (isSelected)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              car['name'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.settings, size: 12, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    car['transmission'] ?? 'Automatic',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.local_gas_station,
                  size: 12,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    car['fuel'] ?? car['type'],
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${car['price']}/day',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      '${car['rating'] ?? 4.8}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: AppColors.textSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'No cars found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try adjusting your search query',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ==================== STEP 2: DATE & TIME ====================
  Widget _buildDateTimeStep() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Pick-up & Return',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Select your rental dates and times',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),

        _buildSectionLabel('Pick-up Date & Time'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildDateButton(
                label: pickupDate != null
                    ? '${pickupDate!.day}/${pickupDate!.month}/${pickupDate!.year}'
                    : 'Select Date',
                icon: Icons.calendar_today,
                onTap: () => _selectPickupDate(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDateButton(
                label: pickupTime != null
                    ? pickupTime!.format(context)
                    : 'Select Time',
                icon: Icons.access_time,
                onTap: () => _selectPickupTime(),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        _buildSectionLabel('Return Date & Time'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildDateButton(
                label: returnDate != null
                    ? '${returnDate!.day}/${returnDate!.month}/${returnDate!.year}'
                    : 'Select Date',
                icon: Icons.calendar_today,
                onTap: () => _selectReturnDate(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDateButton(
                label: returnTime != null
                    ? returnTime!.format(context)
                    : 'Select Time',
                icon: Icons.access_time,
                onTap: () => _selectReturnTime(),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        if (pickupDate != null && returnDate != null)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.primary.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: AppColors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Total rental: ${returnDate!.difference(pickupDate!).inDays} days',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryText,
      ),
    );
  }

  Widget _buildDateButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: label.contains('Select')
                      ? AppColors.textSecondary
                      : AppColors.primaryText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== STEP 3: LOCATION ====================
  Widget _buildLocationStep() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Pick-up & Drop-off',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Choose your locations',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),

        _buildSectionLabel('Pick-up Location'),
        const SizedBox(height: 12),
        _buildLocationCard(
          title: 'Downtown Branch',
          address: '123 Main Street, City Center',
          onTap: () => setState(() => pickupLocation = 'Downtown Branch'),
          isSelected: pickupLocation == 'Downtown Branch',
        ),
        const SizedBox(height: 12),
        _buildLocationCard(
          title: 'Airport Branch',
          address: 'Terminal 1, International Airport',
          onTap: () => setState(() => pickupLocation = 'Airport Branch'),
          isSelected: pickupLocation == 'Airport Branch',
        ),

        const SizedBox(height: 24),

        _buildSectionLabel('Drop-off Location'),
        const SizedBox(height: 12),
        _buildLocationCard(
          title: 'Downtown Branch',
          address: '123 Main Street, City Center',
          onTap: () => setState(() => returnLocation = 'Downtown Branch'),
          isSelected: returnLocation == 'Downtown Branch',
        ),
        const SizedBox(height: 12),
        _buildLocationCard(
          title: 'Airport Branch',
          address: 'Terminal 1, International Airport',
          onTap: () => setState(() => returnLocation = 'Airport Branch'),
          isSelected: returnLocation == 'Airport Branch',
        ),
      ],
    );
  }

  Widget _buildLocationCard({
    required String title,
    required String address,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.location_on,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  // ==================== STEP 4: PAYMENT ====================
  Widget _buildPaymentStep() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Payment Information',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Enter your card details securely',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),

          // Secure payment badge
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.lock, color: Colors.green, size: 20),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Your payment is secured with 256-bit SSL encryption',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Card Number
          _buildSectionLabel('Card Number'),
          const SizedBox(height: 12),
          TextFormField(
            controller: _cardNumberController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
              _CardNumberInputFormatter(),
            ],
            decoration: InputDecoration(
              hintText: '1234 5678 9012 3456',
              prefixIcon: const Icon(
                Icons.credit_card,
                color: AppColors.primary,
              ),
              filled: true,
              fillColor: AppColors.cardWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter card number';
              }
              if (value.replaceAll(' ', '').length < 16) {
                return 'Card number must be 16 digits';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          // Card Holder Name
          _buildSectionLabel('Card Holder Name'),
          const SizedBox(height: 12),
          TextFormField(
            controller: _cardHolderController,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: 'John Doe',
              prefixIcon: const Icon(Icons.person, color: AppColors.primary),
              filled: true,
              fillColor: AppColors.cardWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter card holder name';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          // Expiry and CVV
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionLabel('Expiry Date'),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: _selectCardExpiryDate,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.cardWhite,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: cardExpiryDate == null
                                ? Colors.grey.shade200
                                : AppColors.primary,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                cardExpiryDate != null
                                    ? '${cardExpiryDate!.month.toString().padLeft(2, '0')}/${cardExpiryDate!.year.toString().substring(2)}'
                                    : 'MM/YY',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: cardExpiryDate == null
                                      ? AppColors.textSecondary
                                      : AppColors.primaryText,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionLabel('CVV'),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _cvvController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      decoration: InputDecoration(
                        hintText: '123',
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: AppColors.primary,
                        ),
                        filled: true,
                        fillColor: AppColors.cardWhite,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (value.length < 3) {
                          return 'Invalid';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Payment summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.primary.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payment Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 12),
                _buildPaymentRow('Rental Cost', _calculateRentalCost()),
                const SizedBox(height: 8),
                _buildPaymentRow('Insurance', '\$25'),
                const SizedBox(height: 8),
                _buildPaymentRow('Service Fee', '\$10'),
                const Divider(height: 20),
                _buildPaymentRow('Total', _calculateTotal(), isBold: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: AppColors.primaryText,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isBold ? AppColors.primary : AppColors.primaryText,
          ),
        ),
      ],
    );
  }

  String _calculateRentalCost() {
    if (pickupDate == null || returnDate == null || selectedCarPrice == null) {
      return '\$0';
    }
    final days = returnDate!.difference(pickupDate!).inDays;
    final pricePerDay = int.tryParse(selectedCarPrice!) ?? 0;
    return '\${days * pricePerDay}';
  }

  String _calculateTotal() {
    if (pickupDate == null || returnDate == null || selectedCarPrice == null) {
      return '\$35';
    }
    final days = returnDate!.difference(pickupDate!).inDays;
    final pricePerDay = int.tryParse(selectedCarPrice!) ?? 0;
    final total = (days * pricePerDay) + 25 + 10;
    return '\$total';
  }

  // ==================== STEP 5: CONFIRMATION ====================
  Widget _buildConfirmationStep() {
    final days = returnDate != null && pickupDate != null
        ? returnDate!.difference(pickupDate!).inDays
        : 0;
    final pricePerDay = int.tryParse(selectedCarPrice ?? '89') ?? 89;
    final totalPrice = (days * pricePerDay) + 35;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Booking Summary',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Review your booking details',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),

        // Car Info with Image
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  selectedCarImage ?? 'assets/images/car_ex.jpg',
                  width: 80,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedCar ?? 'No car selected',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Automatic • ${selectedCarType ?? 'Electric'}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        _buildSummaryCard(
          icon: Icons.calendar_today,
          title: 'Pick-up',
          subtitle: pickupDate != null
              ? '${pickupDate!.day}/${pickupDate!.month}/${pickupDate!.year} at ${pickupTime?.format(context) ?? "N/A"}'
              : 'Not selected',
          location: pickupLocation ?? 'Not selected',
        ),

        const SizedBox(height: 12),

        _buildSummaryCard(
          icon: Icons.event_available,
          title: 'Return',
          subtitle: returnDate != null
              ? '${returnDate!.day}/${returnDate!.month}/${returnDate!.year} at ${returnTime?.format(context) ?? "N/A"}'
              : 'Not selected',
          location: returnLocation ?? 'Not selected',
        ),

        const SizedBox(height: 16),

        // Payment method
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.payment,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment Method',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '**** **** **** ${_cardNumberController.text.replaceAll(' ', '').substring(_cardNumberController.text.length - 4)}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withOpacity(0.15),
                AppColors.primary.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _buildPriceRow('Daily Rate', '\$pricePerDay'),
              const SizedBox(height: 8),
              _buildPriceRow('Duration', '$days days'),
              const SizedBox(height: 8),
              _buildPriceRow('Insurance', '\$25'),
              const SizedBox(height: 8),
              _buildPriceRow('Service Fee', '\$10'),
              const Divider(height: 24),
              _buildPriceRow('Total', '\$totalPrice', isTotal: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String location,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
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
            fontSize: isTotal ? 18 : 14,
            fontWeight: FontWeight.w700,
            color: isTotal ? AppColors.primary : AppColors.primaryText,
          ),
        ),
      ],
    );
  }

  // ==================== BOTTOM BUTTONS ====================
  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _currentStep--;
                  });
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _canProceed()
                  ? () {
                      if (_currentStep < 4) {
                        if (_currentStep == 3) {
                          // Validate payment form
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _currentStep++;
                            });
                          }
                        } else {
                          setState(() {
                            _currentStep++;
                          });
                        }
                      } else {
                        _confirmBooking();
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                disabledBackgroundColor: Colors.grey.shade300,
              ),
              child: Text(
                _currentStep == 4 ? 'Confirm Booking' : 'Continue',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== HELPER METHODS ====================
  bool _canProceed() {
    switch (_currentStep) {
      case 0:
        return selectedCar != null;
      case 1:
        return pickupDate != null &&
            returnDate != null &&
            pickupTime != null &&
            returnTime != null;
      case 2:
        return pickupLocation != null && returnLocation != null;
      case 3:
        return _cardNumberController.text.isNotEmpty &&
            _cardHolderController.text.isNotEmpty &&
            cardExpiryDate != null &&
            _cvvController.text.isNotEmpty;
      case 4:
        return true;
      default:
        return false;
    }
  }

  Future<void> _selectPickupDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        pickupDate = date;
      });
    }
  }

  Future<void> _selectReturnDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: pickupDate ?? DateTime.now(),
      firstDate: pickupDate ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        returnDate = date;
      });
    }
  }

  Future<void> _selectPickupTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        pickupTime = time;
      });
    }
  }

  Future<void> _selectReturnTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        returnTime = time;
      });
    }
  }

  Future<void> _selectCardExpiryDate() async {
    final now = DateTime.now();
    final date = await showMonthPicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 20),
    );
    if (date != null) {
      setState(() {
        cardExpiryDate = date;
      });
    }
  }

  // Custom Month Picker
  Future<DateTime?> showMonthPicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    return await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        int selectedMonth = initialDate.month;
        int selectedYear = initialDate.year;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                'Select Expiry Date',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              content: SizedBox(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Year Selector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left),
                          onPressed: () {
                            if (selectedYear > firstDate.year) {
                              setState(() {
                                selectedYear--;
                              });
                            }
                          },
                        ),
                        Text(
                          selectedYear.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: () {
                            if (selectedYear < lastDate.year) {
                              setState(() {
                                selectedYear++;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Month Grid
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 2,
                          ),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        final month = index + 1;
                        final isSelected = month == selectedMonth;
                        final monthNames = [
                          'Jan',
                          'Feb',
                          'Mar',
                          'Apr',
                          'May',
                          'Jun',
                          'Jul',
                          'Aug',
                          'Sep',
                          'Oct',
                          'Nov',
                          'Dec',
                        ];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedMonth = month;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                monthNames[index],
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.primaryText,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      DateTime(selectedYear, selectedMonth),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _confirmBooking() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 64,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Booking Confirmed!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Your booking has been successfully confirmed. A confirmation email has been sent to your email address with all the details.',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    ); // Go to home and remove all previous routes
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Done',
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
      ),
    );
  }
}
