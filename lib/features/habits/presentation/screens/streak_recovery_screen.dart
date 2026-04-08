import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_strings.dart';

class StreakRecoveryArgs {
  const StreakRecoveryArgs({
    required this.habitName,
    required this.streakAtRisk,
    required this.tokensRemaining,
  });

  final String habitName;
  final int streakAtRisk;
  final int tokensRemaining;
}

class StreakRecoveryScreen extends StatelessWidget {
  const StreakRecoveryScreen({super.key, required this.args});

  final StreakRecoveryArgs args;

  @override
  Widget build(BuildContext context) {
    final used = 2 - args.tokensRemaining;
    final safeStreak = args.streakAtRisk <= 0 ? 1 : args.streakAtRisk;
    return Scaffold(
      backgroundColor: AppColors.habitsScreenBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    visualDensity: VisualDensity.compact,
                    iconSize: 22,
                    icon: Icon(Icons.close_rounded, color: AppColors.habitsMuted),
                  ),
                  const Spacer(),
                  Text(
                    AppStrings.appName,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.habitsPrimaryCta,
                    ),
                  ),
                  const Spacer(),
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.habitsCardTint,
                    child: Icon(
                      Icons.person_rounded,
                      size: 20,
                      color: AppColors.habitsMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                TodayStrings.recoveryPerspective.toUpperCase(),
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.9,
                  color: AppColors.habitsMuted,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                TodayStrings.recoveryHeadline,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 34 / 1.2,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                  color: AppColors.habitsTitleInk,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                TodayStrings.recoveryMissedYesterday(args.habitName),
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.35,
                  color: AppColors.habitsBodyBrown,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Text(
                      '$safeStreak',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 60 / 1.25,
                        fontWeight: FontWeight.w800,
                        color: AppColors.habitsPrimaryCta,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('🔥', style: TextStyle(fontSize: 18, height: 1)),
                    const SizedBox(height: 4),
                    Text(
                      TodayStrings.recoveryAtRisk,
                      style: GoogleFonts.manrope(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                        color: AppColors.habitsBodyBrown,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.habitsCardTint,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TodayStrings.recoveryTokens,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.habitsBodyBrown,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${args.tokensRemaining}/2 ${TodayStrings.recoveryTokensAvailable}',
                            style: GoogleFonts.manrope(
                              fontSize: 12.5,
                              color: AppColors.habitsMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    for (var i = 0; i < 2; i++) ...[
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: i < used ? AppColors.habitsPrimaryCta : Colors.white,
                          border: i < used
                              ? null
                              : Border.all(
                                  color: AppColors.habitsMuted.withValues(alpha: 0.4),
                                ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.shield_outlined,
                          color: i < used ? Colors.white : AppColors.habitsMuted,
                          size: 20,
                        ),
                      ),
                      if (i == 0) const SizedBox(width: 8),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 54,
                child: FilledButton.icon(
                  onPressed: args.tokensRemaining > 0
                      ? () => Navigator.of(context).pop(true)
                      : null,
                  icon: Icon(Icons.alt_route_rounded, size: 19),
                  label: Text(TodayStrings.recoveryUseOne),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.habitsPrimaryCta,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    textStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 52,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.habitsCardTint,
                    foregroundColor: AppColors.habitsTitleInk,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    textStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: Text(TodayStrings.recoveryReset),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'ⓘ ${TodayStrings.recoveryYesterdayOnly}',
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  color: AppColors.habitsMuted,
                ),
              ),
              const Spacer(),
              Container(
                height: 132,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xB3D7D7D7), Color(0x66EDEDED), Color(0x22FFFFFF)],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
