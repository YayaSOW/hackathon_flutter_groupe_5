import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static const TextStyle appBarStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor, // Ensure AppColors.primaryColor is const
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 14,
    color: Color(0xFF616161), // Replace Colors.grey[700] with a const value
  );
}