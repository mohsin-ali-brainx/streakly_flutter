import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../di/service_locator.dart';
import '../../../habits/domain/repositories/insurance_repository.dart';
import '../../../habits/domain/services/month_key.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.habitsScreenBg,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppDimens.space2xl),
          children: [
            Text(
              SettingsStrings.title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                height: 1.15,
                letterSpacing: -0.6,
                color: AppColors.habitsTitleInk,
              ),
            ),
            const SizedBox(height: AppDimens.spaceLg),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              tileColor: Colors.white,
              leading: Icon(
                Icons.notifications_outlined,
                color: AppColors.habitsPrimaryCta,
              ),
              title: Text(
                SettingsStrings.notificationsTitle,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  color: AppColors.habitsTitleInk,
                ),
              ),
              subtitle: Text(
                SettingsStrings.notificationsSubtitle,
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  color: AppColors.habitsMuted,
                ),
              ),
              trailing: Text(
                ' ',
                style: const TextStyle(fontSize: 0.1),
              ),
              onTap: () => context.push(AppRoutes.settingsNotifications),
            ),
            const SizedBox(height: 10),
            FutureBuilder<int>(
              future: sl<InsuranceRepository>().getRemainingTokens(
                monthKey: MonthKey.of(DateTime.now()),
              ),
              builder: (context, snap) {
                final remaining = snap.data ?? 2;
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  tileColor: Colors.white,
                  leading: Icon(
                    Icons.shield_outlined,
                    color: AppColors.habitsPrimaryCta,
                  ),
                  title: Text(
                    SettingsStrings.insuranceTitle,
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w700,
                      color: AppColors.habitsTitleInk,
                    ),
                  ),
                  subtitle: Text(
                    SettingsStrings.insuranceSubtitle,
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      color: AppColors.habitsMuted,
                    ),
                  ),
                  trailing: Text(
                    '$remaining/2',
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.habitsMuted,
                    ),
                  ),
                  onTap: () => context.push(AppRoutes.settingsInsurance),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
