import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../di/service_locator.dart';
import '../../../habits/domain/repositories/insurance_repository.dart';
import '../../../habits/domain/services/month_key.dart';

class InsuranceSettingsScreen extends StatelessWidget {
  const InsuranceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = sl<InsuranceRepository>();
    final monthKey = MonthKey.of(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.habitsScreenBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.space2xl),
          child: FutureBuilder<int>(
            future: repo.getRemainingTokens(monthKey: monthKey),
            builder: (context, snap) {
              final remaining = snap.data ?? 2;
              final used = 2 - remaining;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: Icon(
                          Icons.chevron_left_rounded,
                          color: AppColors.habitsMuted,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          SettingsStrings.insuranceTitle,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.habitsTitleInk,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    SettingsStrings.insuranceSubtitle,
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                      color: AppColors.habitsBodyBrown,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                    decoration: BoxDecoration(
                      color: AppColors.statsDiversityCardBg,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.shield_rounded,
                            color: AppColors.todayTealDone,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TOKENS THIS MONTH',
                                style: GoogleFonts.manrope(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.9,
                                  color: AppColors.habitsMuted,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '$remaining/2 remaining',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.habitsTitleInk,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: List.generate(2, (i) {
                            final filled = i < used;
                            return Padding(
                              padding: EdgeInsets.only(left: i == 0 ? 0 : 8),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: filled
                                      ? AppColors.habitsPrimaryCta
                                      : Colors.white,
                                  border: filled
                                      ? null
                                      : Border.all(
                                          color: AppColors.habitsMuted
                                              .withValues(alpha: 0.35),
                                        ),
                                ),
                                child: Icon(
                                  Icons.shield_outlined,
                                  size: 18,
                                  color: filled
                                      ? Colors.white
                                      : AppColors.habitsMuted,
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x1485736D),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Text(
                      HabitsStrings.insuranceBody,
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        height: 1.45,
                        fontWeight: FontWeight.w500,
                        color: AppColors.habitsBodyBrown,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

