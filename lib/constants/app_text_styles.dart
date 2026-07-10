import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const appBarTitle = TextStyle(color: Colors.white);

  static const heading = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const sectionTitle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const cardTitle = TextStyle(
    color: Colors.white,
    fontSize: 13,
    fontWeight: FontWeight.bold,
  );

  static const body = TextStyle(
    color: AppColors.textBody,
    fontSize: 14,
    height: 1.5,
  );

  static const label = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 14,
  );

  static const caption = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 11,
  );
}