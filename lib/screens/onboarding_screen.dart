import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward(); // Start the fade-in animation
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    // Full collage
                    Image.asset(
                      'assets/images/onboarding_books.jpg',
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),

                    Positioned(
                      top: screenHeight * 0.35,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Image.asset(
                            'assets/images/splash.png',
                            width: 90,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              const Text(
                'Read more and stress less with our online book shopping app. '
                'Shop from anywhere you are and discover titles that you love. '
                'Happy reading!',
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              ElevatedButton(
                onPressed: () => context.go('/login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Get Started', style: AppTextStyles.button),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () => context.go('/register'),
                child: const Text('Register', style: AppTextStyles.link),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
