import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'car_details_screen.dart';
import '../../core/widgets/main_bottom_nav.dart';

class SearchScreen extends StatefulWidget {
  final String initialCategory;

  const SearchScreen({super.key, this.initialCategory = 'All'});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late String _selectedCategory;
  String _selectedTransmission = 'All';
  String _selectedFuelType = 'All';

  @override
  void initState() {
    super.initState();
    // Apply category passed from HomeScreen
    _selectedCategory = widget.initialCategory;
  }

  // Sample car data
  final List<Map<String, dynamic>> allCars = [
    {
      'id': 1,
      'name': 'BMW X5',
      'category': 'SUV',
      'transmission': 'Automatic',
      'fuel': 'Diesel',
      'price': 85,
      'rating': 4.8,
      'image': 'assets/images/car_ex.jpg',
    },
    {
      'id': 2,
      'name': 'Mercedes C-Class',
      'category': 'Sedan',
      'transmission': 'Automatic',
      'fuel': 'Petrol',
      'price': 75,
      'rating': 4.7,
      'image': 'assets/images/car_ex.jpg',
    },
    {
      'id': 3,
      'name': 'Audi A4',
      'category': 'Sedan',
      'transmission': 'Automatic',
      'fuel': 'Diesel',
      'price': 70,
      'rating': 4.6,
      'image': 'assets/images/car_ex.jpg',
    },
    {
      'id': 4,
      'name': 'Tesla Model 3',
      'category': 'Electric',
      'transmission': 'Automatic',
      'fuel': 'Electric',
      'price': 95,
      'rating': 4.9,
      'image': 'assets/images/car_ex.jpg',
    },
    {
      'id': 5,
      'name': 'Porsche 911',
      'category': 'Sport',
      'transmission': 'Manual',
      'fuel': 'Petrol',
      'price': 150,
      'rating': 5.0,
      'image': 'assets/images/car_ex.jpg',
    },
    {
      'id': 6,
      'name': 'Range Rover Sport',
      'category': 'SUV',
      'transmission': 'Automatic',
      'fuel': 'Diesel',
      'price': 120,
      'rating': 4.8,
      'image': 'assets/images/car_ex.jpg',
    },
  ];

  List<Map<String, dynamic>> get filteredCars {
    return allCars.where((car) {
      final matchesSearch = car['name'].toLowerCase().contains(
        _searchController.text.toLowerCase(),
      );
      final matchesCategory =
          _selectedCategory == 'All' || car['category'] == _selectedCategory;
      final matchesTransmission =
          _selectedTransmission == 'All' ||
          car['transmission'] == _selectedTransmission;
      final matchesFuel =
          _selectedFuelType == 'All' || car['fuel'] == _selectedFuelType;

      return matchesSearch &&
          matchesCategory &&
          matchesTransmission &&
          matchesFuel;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button and search
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppColors.softBackground,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            controller: _searchController,
                            autofocus: true,
                            onChanged: (value) => setState(() {}),
                            decoration: const InputDecoration(
                              hintText: 'Search for cars...',
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.search,
                                color: AppColors.textSecondary,
                              ),
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Quick filters
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _filterChip(
                          'All',
                          _selectedCategory == 'All',
                          () => setState(() => _selectedCategory = 'All'),
                        ),
                        _filterChip(
                          'Sedan',
                          _selectedCategory == 'Sedan',
                          () => setState(() => _selectedCategory = 'Sedan'),
                        ),
                        _filterChip(
                          'SUV',
                          _selectedCategory == 'SUV',
                          () => setState(() => _selectedCategory = 'SUV'),
                        ),
                        _filterChip(
                          'Sport',
                          _selectedCategory == 'Sport',
                          () => setState(() => _selectedCategory = 'Sport'),
                        ),
                        _filterChip(
                          'Electric',
                          _selectedCategory == 'Electric',
                          () => setState(() => _selectedCategory = 'Electric'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Filter button and results count
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${filteredCars.length} cars available',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showFilterBottomSheet(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cardWhite,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.softBackground,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.tune,
                            size: 18,
                            color: AppColors.primaryText,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Filters',
                            style: TextStyle(
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
            ),

            // Search results as Grid
            Expanded(
              child: filteredCars.isEmpty
                  ? _emptyState()
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.8,
                          ),
                      itemCount: filteredCars.length,
                      itemBuilder: (context, index) {
                        return _carListItem(filteredCars[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomNav(currentIndex: 2),
    );
  }

  Widget _filterChip(String label, bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryText
                : AppColors.softBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.primaryText,
            ),
          ),
        ),
      ),
    );
  }

  Widget _carListItem(Map<String, dynamic> car) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CarDetailsScreen(car: car)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
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
            // Car image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                car['image'],
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              car['name'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.settings, size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(
                  car['transmission'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
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
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
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
            'Try adjusting your filters or search query',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setModalState(() {
                        _selectedTransmission = 'All';
                        _selectedFuelType = 'All';
                      });
                      setState(() {});
                    },
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Transmission filter
              const Text(
                'Transmission',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                children: [
                  _modalFilterChip('All', _selectedTransmission == 'All', () {
                    setModalState(() => _selectedTransmission = 'All');
                    setState(() {});
                  }),
                  _modalFilterChip(
                    'Automatic',
                    _selectedTransmission == 'Automatic',
                    () {
                      setModalState(() => _selectedTransmission = 'Automatic');
                      setState(() {});
                    },
                  ),
                  _modalFilterChip(
                    'Manual',
                    _selectedTransmission == 'Manual',
                    () {
                      setModalState(() => _selectedTransmission = 'Manual');
                      setState(() {});
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Fuel type filter
              const Text(
                'Fuel Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                children: [
                  _modalFilterChip('All', _selectedFuelType == 'All', () {
                    setModalState(() => _selectedFuelType = 'All');
                    setState(() {});
                  }),
                  _modalFilterChip('Petrol', _selectedFuelType == 'Petrol', () {
                    setModalState(() => _selectedFuelType = 'Petrol');
                    setState(() {});
                  }),
                  _modalFilterChip('Diesel', _selectedFuelType == 'Diesel', () {
                    setModalState(() => _selectedFuelType = 'Diesel');
                    setState(() {});
                  }),
                  _modalFilterChip(
                    'Electric',
                    _selectedFuelType == 'Electric',
                    () {
                      setModalState(() => _selectedFuelType = 'Electric');
                      setState(() {});
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Apply button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryText,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Apply Filters',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ),
    );
  }

  Widget _modalFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryText : AppColors.softBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryText
                : AppColors.softBackground,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.primaryText,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
