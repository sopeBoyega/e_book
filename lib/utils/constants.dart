import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFFFFFFF); // white
  static const Color primary = Color(0xFF1A1A1A); // dark button
  static const Color hint = Color(0xFF757575);
}

class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle body = TextStyle(fontSize: 16, color: Colors.black87);
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static const TextStyle link = TextStyle(
    fontSize: 14,
    color: AppColors.primary,
  );
}
