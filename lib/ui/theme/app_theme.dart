import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// Theme aligned to brand colors in [AppColors] (Ember & Earth).
class AppTheme {
  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.ctaBrown,
      brightness: Brightness.light,
    ).copyWith(
      secondary: AppColors.mutedGreen,
      tertiary: AppColors.tealLabel,
      surface: AppColors.welcomeCream,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.ctaBrown,
      brightness: Brightness.dark,
    ).copyWith(
      secondary: AppColors.mutedGreen,
      tertiary: AppColors.tealLabel,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

