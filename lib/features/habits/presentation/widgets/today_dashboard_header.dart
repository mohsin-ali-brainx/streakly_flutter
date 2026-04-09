import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';

class TodayDashboardHeader extends StatelessWidget {
  const TodayDashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 8, 12),
      child: Row(
        children: [
          const SizedBox(width: 48),
          const Expanded(
            child: Center(child: _StreaklyLogoWordmark()),
          ),
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.habitsCardTint,
            child: Icon(
              Icons.person_rounded,
              color: AppColors.habitsMuted,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}

class _StreaklyLogoWordmark extends StatelessWidget {
  const _StreaklyLogoWordmark();

  @override
  Widget build(BuildContext context) {
    final baseStyle = GoogleFonts.plusJakartaSans(
      fontSize: 22,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.5,
      color: AppColors.ctaBrown,
      height: 1,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Streakl', style: baseStyle),
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Text('🔥', style: TextStyle(fontSize: 12, height: 1)),
        ),
        Text('y', style: baseStyle),
      ],
    );
  }
}
