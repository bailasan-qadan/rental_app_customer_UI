import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/main_bottom_nav.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBackground,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(greetingName: 'Bailasan'),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return _notificationCard();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomNav(currentIndex: -1),
    );
  }

  Widget _notificationCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: const [
          Icon(Icons.notifications, color: AppColors.primary),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your booking has been confirmed.',
              style: TextStyle(color: AppColors.primaryText),
            ),
          ),
        ],
      ),
    );
  }
}
