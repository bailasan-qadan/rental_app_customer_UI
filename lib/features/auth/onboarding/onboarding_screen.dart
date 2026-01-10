import 'package:flutter/material.dart';
import '../login/login_screen.dart';

class AppColors {
  static const Color background = Color(0xFFF8F9FE);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF170142);
  static const Color accent = Color(0xFFB794FF);
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B6B80);
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // 🔹 Full Screen Image Background - Shows entire image
          Positioned.fill(
            child: Image.asset(
              'assets/images/onboarding.jpg', // or 'assets/images/onboarding.jpg'
              fit: BoxFit.contain, // ✅ Shows full image without cropping
              alignment: Alignment.topCenter,
            ),
          ),

          // 🔹 Gradient Overlay (lighter for this artistic image)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.15)],
                ),
              ),
            ),
          ),

          // 🔹 Compact Card at Bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(maxHeight: size.height * 0.4),
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Car Rental ',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              height: 1.2,
                            ),
                          ),
                          TextSpan(
                            text: 'Made Easy',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Description
                    const Text(
                      'Browse premium vehicles, book instantly, and enjoy a seamless rental experience tailored just for you.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 20),

                    // Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
