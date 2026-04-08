import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_strings.dart';

class TodayInsightCard extends StatelessWidget {
  const TodayInsightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.todayInsightMint,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.show_chart_rounded,
            size: 22,
            color: AppColors.mutedGreen,
          ),
          const SizedBox(height: 12),
          Text(
            TodayStrings.insightTitle,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.habitsTitleInk,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            TodayStrings.insightBody,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.5,
              color: AppColors.habitsBodyBrown,
            ),
          ),
        ],
      ),
    );
  }
}
