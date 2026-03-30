import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/onboarding_progress.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../shared/presentation/widgets/onboarding_cream_backdrop.dart';
import '../../../../shared/presentation/widgets/onboarding_glass_circle_hero.dart';
import '../../../../shared/presentation/widgets/onboarding_marketing_feature_row.dart';
import '../../../../shared/presentation/widgets/onboarding_progress_header.dart';
import '../../../../shared/presentation/widgets/streakly_primary_async_button.dart';
import '../controller/onboarding_insurance_controller.dart';

/// Streak Insurance onboarding — matches Figma frame (node 191:144), same system as notifications.
/// Design: [Figma frame](https://www.figma.com/design/i1gV0yG1KlO7vl982pCVq1/Login-Page--Community-?node-id=191-144)
class OnboardingInsuranceScreen extends StatelessWidget {
  const OnboardingInsuranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingInsuranceController(),
      child: const _OnboardingInsuranceView(),
    );
  }
}

class _OnboardingInsuranceView extends StatelessWidget {
  const _OnboardingInsuranceView();

  static const double _horizontalPadding = 32;
  static const double _verticalPaddingLoose = 28;
  static const double _heroSize = 192;
  static const double _cardRadius = 48;
  static const double _heroToHeadlineGap = 47.25;
  static const double _headlineToBodyGap = 15.25;
  static const double _headlineLineHeightPx = 37.5;
  static const double _headlineFontSize = 30;
  static const double _ctaHeight = 60;
  static const double _horizontalPadding20 = 20;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final contentWidth = math.min(size.width - _horizontalPadding * 2, 448.0);

    return Scaffold(
      backgroundColor: AppColors.notificationsScreenBg,
      body: Stack(
        children: [
          const OnboardingCreamBackdrop(),
          SafeArea(
            child: Column(
              children: [
                const OnboardingProgressHeader(
                  step: OnboardingProgress.insuranceStep,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      _horizontalPadding,
                      _verticalPaddingLoose,
                      _horizontalPadding,
                      32,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: contentWidth,
                        child: Column(
                          children: [
                            Text(
                              InsuranceStrings.eyebrow,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.manrope(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.6,
                                color: AppColors.notificationsMindsetLabel,
                                height: 15 / 10,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const OnboardingGlassCircleHero(
                              size: _heroSize,
                              icon: Icons.shield_outlined,
                              centerIconSize: 44,
                            ),
                            const SizedBox(height: _heroToHeadlineGap),
                            Text(
                              InsuranceStrings.titleLine1,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: _headlineFontSize,
                                fontWeight: FontWeight.w700,
                                color: AppColors.notificationsInk,
                                height:
                                    _headlineLineHeightPx / _headlineFontSize,
                                letterSpacing: -0.75,
                              ),
                            ),
                            Text(
                              InsuranceStrings.titleLine2,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: _headlineFontSize,
                                fontWeight: FontWeight.w700,
                                color: AppColors.notificationsHeadlineAccent,
                                height:
                                    _headlineLineHeightPx / _headlineFontSize,
                                letterSpacing: -0.75,
                              ),
                            ),
                            const SizedBox(height: _headlineToBodyGap),
                            Text(
                              InsuranceStrings.subtitle,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.manrope(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: AppColors.notificationsBody,
                                height: 29.25 / 18,
                              ),
                            ),
                            const SizedBox(height: 48),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(25),
                              decoration: BoxDecoration(
                                color: AppColors.notificationsCardBg,
                                borderRadius: BorderRadius.circular(
                                  _cardRadius,
                                ),
                                border: Border.all(
                                  color: AppColors.notificationsCardBorder,
                                ),
                              ),
                              child: Column(
                                children: [
                                  OnboardingMarketingFeatureRow(
                                    circleColor:
                                        AppColors.notificationsMindsetCircle,
                                    labelColor:
                                        AppColors.notificationsMindsetLabel,
                                    label: InsuranceStrings.bullet1Title
                                        .toUpperCase(),
                                    body: InsuranceStrings.bullet1Subtitle,
                                    icon: Icons.auto_awesome_rounded,
                                    iconColor:
                                        AppColors.notificationsMindsetLabel,
                                  ),
                                  const SizedBox(height: 16),
                                  OnboardingMarketingFeatureRow(
                                    circleColor: AppColors
                                        .notificationsReliabilityCircle,
                                    labelColor:
                                        AppColors.notificationsReliabilityLabel,
                                    label: InsuranceStrings.bullet2Title
                                        .toUpperCase(),
                                    body: InsuranceStrings.bullet2Subtitle,
                                    icon: Icons.event_repeat_rounded,
                                    iconColor:
                                        AppColors.notificationsReliabilityLabel,
                                  ),
                                  const SizedBox(height: 16),
                                  OnboardingMarketingFeatureRow(
                                    circleColor: AppColors
                                        .onboardingInsuranceFeatureCircle,
                                    labelColor:
                                        AppColors.notificationsHeadlineAccent,
                                    label: InsuranceStrings.bullet3Title
                                        .toUpperCase(),
                                    body: InsuranceStrings.bullet3Subtitle,
                                    icon: Icons.favorite_outline_rounded,
                                    iconColor:
                                        AppColors.notificationsHeadlineAccent,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: _horizontalPadding20,right: _horizontalPadding20,),
                  child: Consumer<OnboardingInsuranceController>(
                    builder: (context, c, _) {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                999,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors
                                      .notificationsCtaShadow,
                                  offset: Offset(0, 4),
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                            child: StreaklyPrimaryAsyncButton(
                              label: InsuranceStrings.primaryCta,
                              isLoading: c.submitting,
                              backgroundColor:
                              AppColors.notificationsCtaBrown,
                              foregroundColor: Colors.white,
                              shape: const StadiumBorder(),
                              height: _ctaHeight,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              labelStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                height: 28 / 18,
                              ),
                              onPressed: () async {
                                await c.finish();
                                if (!context.mounted) return;
                                context.go(AppRoutes.today);
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            InsuranceStrings.footerHint,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.notificationsLater,
                              height: 22 / 14,
                            ),
                          ),

                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
