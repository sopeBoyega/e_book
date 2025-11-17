import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/home_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',

  errorBuilder:
      (context, state) => const Scaffold(
        body: Center(
          child: Text(
            'Page not found! Check your path.',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),

  routes: [
    GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),

    GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),

    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),

    GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),

    GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
  ],
);
