import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/l10n/app_strings.dart';

enum StreaklyWordmarkStyle { compact, splash }

/// Reusable “Streakly” title for app bars, onboarding, and splash.
class StreaklyWordmark extends StatelessWidget {
  const StreaklyWordmark.compact({super.key}) : style = StreaklyWordmarkStyle.compact;

  const StreaklyWordmark.splash({super.key}) : style = StreaklyWordmarkStyle.splash;

  final StreaklyWordmarkStyle style;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return switch (style) {
      StreaklyWordmarkStyle.compact => Text(
          AppStrings.appName,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      StreaklyWordmarkStyle.splash => Text(
          AppStrings.appName,
          style: textTheme.headlineMedium?.copyWith(
            fontFamily: 'Georgia',
            fontWeight: FontWeight.w700,
            color: AppColors.logoBrown,
          ),
        ),
    };
  }
}
