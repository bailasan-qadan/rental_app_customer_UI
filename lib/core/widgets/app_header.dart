import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppHeader extends StatelessWidget {
  final String greetingName;

  const AppHeader({super.key, required this.greetingName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // -------- Row 1: Logo + Name | Notification --------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Your logo image
                    width: 45,
                    height: 45,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Autora',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // -------- Search Bar --------
          TextField(
            decoration: InputDecoration(
              hintText: 'Search for cars...',
              hintStyle: TextStyle(
                color: AppColors.textSecondary.withOpacity(0.5),
                fontSize: 14,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.textSecondary.withOpacity(0.7),
                size: 22,
              ),
              filled: true,
              fillColor: const Color(0xFFF5F6FA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppColors.primary, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
