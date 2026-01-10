import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MainBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const MainBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: const BoxDecoration(color: AppColors.primary),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(icon: Icons.home_outlined, index: 0),
          _buildNavItem(icon: Icons.directions_car_outlined, index: 1),
          _buildNavItem(icon: Icons.bookmark_border, index: 2),
          _buildNavItem(icon: Icons.person_outline, index: 3),
        ],
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required int index}) {
    final bool isActive = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: isActive
            ? const BoxDecoration(color: Colors.white, shape: BoxShape.circle)
            : const BoxDecoration(),
        child: Icon(
          icon,
          size: 24,
          color: isActive ? AppColors.primary : AppColors.textOnDark,
        ),
      ),
    );
  }
}
