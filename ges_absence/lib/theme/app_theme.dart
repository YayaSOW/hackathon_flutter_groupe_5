import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static final appBarStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  );

  static final subtitleStyle = TextStyle(
    fontSize: 14,
    color: Colors.grey[700],
  );
}