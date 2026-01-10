import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.softBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 Top Illustration
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/images/login.png', // Use your register image
                fit: BoxFit.cover,
                height: size.height * 0.4,
                alignment: Alignment.center,
              ),
            ),

            // 🔹 Card with all content
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🔹 App Logo/Name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
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
                  const SizedBox(height: 24),

                  // Full Name Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Full Name',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'Enter your full name',
                      hintStyle: TextStyle(
                        color: AppColors.textSecondary.withOpacity(0.5),
                        fontSize: 14,
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
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Email Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'your.email@gmail.com',
                      hintStyle: TextStyle(
                        color: AppColors.textSecondary.withOpacity(0.5),
                        fontSize: 14,
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
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Phone Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Phone',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: '+1 234 567 890',
                      hintStyle: TextStyle(
                        color: AppColors.textSecondary.withOpacity(0.5),
                        fontSize: 14,
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
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Password Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: '••••••••••••',
                      hintStyle: TextStyle(
                        color: AppColors.textSecondary.withOpacity(0.5),
                        fontSize: 14,
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
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Already have account Link
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
