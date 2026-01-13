import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/splash/welcome_app_screen.dart';
import 'features/mainApp/Home.dart';
import 'dart:ui' as ui;

void main() {
  runApp(const CarRentalApp());
}

class CarRentalApp extends StatelessWidget {
  const CarRentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: const HomeScreen(),
    );
  }
}
