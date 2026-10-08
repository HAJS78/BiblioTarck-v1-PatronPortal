// lib/UI/Theme/app_theme.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme 
{
  AppTheme._();

  static ThemeData light = ThemeData(
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
  );
}