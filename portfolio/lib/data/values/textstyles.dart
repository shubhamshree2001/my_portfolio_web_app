import 'package:flutter/material.dart';
import 'package:my_portfolio_web_app/data/theme/app_colors.dart';

class AppTextStyles {
  static const regular12GreyPrimary = TextStyle(
    color: Colors.grey,
    fontSize: 12,
  );

  static const bodySemiBoldWhite = TextStyle(
    color: AppColors.white,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const body2RegularWhite = TextStyle(
    color: AppColors.white,
    fontSize: 16,
  );

  static const body2SemiBoldWhite = TextStyle(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const text12White70 = TextStyle(
    color: Colors.white70,
    fontSize: 12,
  );

  static const body18White600 = TextStyle(
    color: AppColors.white,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const heading1White = TextStyle(
    color: AppColors.white,
    fontSize: 32,
    fontWeight: FontWeight.w600,
  );

  static const heading1800White = TextStyle(
    color: AppColors.white,
    fontSize: 32,
    fontWeight: FontWeight.w800,
  );

  static const heading2White = TextStyle(
    color: AppColors.white,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const heading3White = TextStyle(
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const italic24Bold = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    letterSpacing: 1.2,
  );
}
