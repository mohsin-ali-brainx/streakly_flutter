import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';

class AppTheme {
  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.ctaBrown,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.habitsPrimaryCta,
      onPrimary: Colors.white,
      secondary: AppColors.mutedGreen,
      tertiary: AppColors.tealLabel,
      surface: AppColors.habitsScreenBg,
      surfaceContainerHighest: Colors.white,
      onSurface: AppColors.habitsTitleInk,
      onSurfaceVariant: AppColors.habitsMuted,
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: scheme.primary,
        ),
      ),
    );

    final textTheme = GoogleFonts.plusJakartaSansTextTheme(base.textTheme);
    return base.copyWith(
      textTheme: textTheme.copyWith(
        bodyMedium: GoogleFonts.manrope(
          fontSize: textTheme.bodyMedium?.fontSize,
          height: textTheme.bodyMedium?.height,
          fontWeight: textTheme.bodyMedium?.fontWeight,
          color: scheme.onSurfaceVariant,
        ),
        bodySmall: GoogleFonts.manrope(
          fontSize: textTheme.bodySmall?.fontSize,
          height: textTheme.bodySmall?.height,
          fontWeight: textTheme.bodySmall?.fontWeight,
          color: scheme.onSurfaceVariant,
        ),
        labelMedium: GoogleFonts.manrope(
          fontSize: textTheme.labelMedium?.fontSize,
          height: textTheme.labelMedium?.height,
          fontWeight: textTheme.labelMedium?.fontWeight,
          color: scheme.onSurfaceVariant,
        ),
      ),
    );
  }

  static ThemeData dark() {
    const surface = Color(0xFF1E1C1A);
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.ctaBrown,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AppColors.habitsPrimaryCta,
      onPrimary: Colors.white,
      secondary: AppColors.mutedGreen,
      tertiary: AppColors.tealLabel,
      surface: surface,
      surfaceContainerHighest: Color(0xFF2A2724),
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      cardTheme: CardThemeData(
        color: scheme.surfaceContainerHighest,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: scheme.primary,
        ),
      ),
    );

    final textTheme = GoogleFonts.plusJakartaSansTextTheme(base.textTheme);
    return base.copyWith(
      textTheme: textTheme.copyWith(
        bodyMedium: GoogleFonts.manrope(
          fontSize: textTheme.bodyMedium?.fontSize,
          height: textTheme.bodyMedium?.height,
          fontWeight: textTheme.bodyMedium?.fontWeight,
        ),
        bodySmall: GoogleFonts.manrope(
          fontSize: textTheme.bodySmall?.fontSize,
          height: textTheme.bodySmall?.height,
          fontWeight: textTheme.bodySmall?.fontWeight,
        ),
        labelMedium: GoogleFonts.manrope(
          fontSize: textTheme.labelMedium?.fontSize,
          height: textTheme.labelMedium?.height,
          fontWeight: textTheme.labelMedium?.fontWeight,
        ),
      ),
    );
  }
}
