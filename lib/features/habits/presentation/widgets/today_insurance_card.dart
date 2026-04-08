import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../domain/usecases/get_insurance_state_for_habit.dart';

class TodayInsuranceCard extends StatelessWidget {
  const TodayInsuranceCard({
    super.key,
    required this.state,
    required this.streakDays,
    required this.busy,
    required this.onUse,
  });

  final InsuranceState state;
  final int streakDays;
  final bool busy;
  final VoidCallback onUse;

  @override
  Widget build(BuildContext context) {
    final msg = TodayStrings.insuranceSaveStreak(streakDays);
    final parts = msg.split('\n');
    final title = parts.isNotEmpty ? parts.first : msg;
    final subtitle = parts.length > 1 ? parts.sublist(1).join('\n') : '';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 12, 14, 12),
      decoration: BoxDecoration(
        color: AppColors.todayInsuranceCardGrey,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Center(
              child: Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.shield_outlined,
                  size: 18,
                  color: AppColors.ctaBrown,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                    color: AppColors.habitsBodyBrown,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle.isNotEmpty
                      ? subtitle
                      : '${state.tokensRemainingThisMonth} ${TodayStrings.tokensThisMonth}',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                    color: AppColors.habitsBodyBrown.withValues(alpha: 0.65),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 40,
            child: FilledButton(
              onPressed: busy ? null : onUse,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.habitsPrimaryCta,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                textStyle: GoogleFonts.manrope(
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5,
                ),
              ),
              child: busy
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(TodayStrings.useInsurance),
            ),
          ),
        ],
      ),
    );
  }
}
