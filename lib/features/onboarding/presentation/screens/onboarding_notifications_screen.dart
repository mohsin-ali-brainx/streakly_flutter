import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../shared/presentation/widgets/onboarding_cream_backdrop.dart';
import '../../../../shared/presentation/widgets/onboarding_glass_circle_hero.dart';
import '../../../../shared/presentation/widgets/onboarding_marketing_feature_row.dart';
import '../../../../shared/presentation/widgets/streakly_primary_async_button.dart';
import '../controller/onboarding_notifications_controller.dart';

/// Onboarding notifications — matches Figma *Notifications Permission* (node 191:206).
/// Design: [Figma frame](https://www.figma.com/design/i1gV0yG1KlO7vl982pCVq1/Login-Page--Community-?node-id=191-206)
class OnboardingNotificationsScreen extends StatelessWidget {
  const OnboardingNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingNotificationsController(),
      child: const _OnboardingNotificationsView(),
    );
  }
}

class _OnboardingNotificationsView extends StatelessWidget {
  const _OnboardingNotificationsView();

  static const double _horizontalPadding = 32;
  static const double _horizontalPadding20 = 20;

  static const double _verticalPadding = 48;
  static const double _heroSize = 192;
  static const double _cardRadius = 48;
  static const double _heroToHeadlineGap = 47.25;
  static const double _headlineToBodyGap = 15.25;
  static const double _headlineLineHeightPx = 37.5;
  static const double _headlineFontSize = 30;
  static const double _footerPaddingBottom = 20;
  static const double _ctaHeight = 60;

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
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      left: _horizontalPadding,
                      right: _horizontalPadding,
                      top: _verticalPadding,
                      bottom: _footerPaddingBottom,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: contentWidth,
                        child: Column(
                          children: [
                            const OnboardingGlassCircleHero(
                              size: _heroSize,
                              icon: Icons.notifications_outlined,
                            ),
                            const SizedBox(height: _heroToHeadlineGap),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  NotificationsStrings.headlineLine1,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: _headlineFontSize,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.notificationsInk,
                                    height:
                                        _headlineLineHeightPx /
                                        _headlineFontSize,
                                    letterSpacing: -0.75,
                                  ),
                                ),
                                Text(
                                  NotificationsStrings.headlineLine2,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: _headlineFontSize,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        AppColors.notificationsHeadlineAccent,
                                    height:
                                        _headlineLineHeightPx /
                                        _headlineFontSize,
                                    letterSpacing: -0.75,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: _headlineToBodyGap),
                            Text(
                              NotificationsStrings.subtitleLine1,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.manrope(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: AppColors.notificationsBody,
                                height: 29.25 / 18,
                              ),
                            ),
                            Text(
                              NotificationsStrings.subtitleLine2,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.manrope(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: AppColors.notificationsBody,
                                height: 29.25 / 18,
                              ),
                            ),
                            Text(
                              NotificationsStrings.subtitleLine3,
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
                                    label: NotificationsStrings.mindsetLabel,
                                    body: NotificationsStrings.mindsetBody,
                                    icon: Icons.self_improvement_rounded,
                                    iconColor:
                                        AppColors.notificationsMindsetLabel,
                                  ),
                                  const SizedBox(height: 16),
                                  OnboardingMarketingFeatureRow(
                                    circleColor: AppColors
                                        .notificationsReliabilityCircle,
                                    labelColor:
                                        AppColors.notificationsReliabilityLabel,
                                    label:
                                        NotificationsStrings.reliabilityLabel,
                                    body: NotificationsStrings.reliabilityBody,
                                    icon: Icons.verified_user_outlined,
                                    iconColor:
                                        AppColors.notificationsReliabilityLabel,
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
                  child: Consumer<OnboardingNotificationsController>(
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
                              label: NotificationsStrings.enable,
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
                                final granted = await c.enable();
                                if (!context.mounted) return;
                                if (granted) {
                                  context.go(AppRoutes.onboardingInsurance);
                                  return;
                                }

                                await showDialog<void>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        NotificationsStrings.deniedTitle,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.notificationsInk,
                                        ),
                                      ),
                                      content: Text(
                                        NotificationsStrings.deniedBody,
                                        style: GoogleFonts.manrope(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.notificationsBody,
                                          height: 1.35,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            await c.openSettings();
                                            if (!context.mounted) return;
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            NotificationsStrings.openSettings,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors
                                                  .notificationsHeadlineAccent,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            context.go(
                                              AppRoutes.onboardingInsurance,
                                            );
                                          },
                                          child: Text(
                                            NotificationsStrings.continueAnyway,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color:
                                                  AppColors.notificationsLater,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: c.submitting
                                ? null
                                : () async {
                              await c.skip();
                              if (!context.mounted) return;
                              context.go(
                                AppRoutes.onboardingInsurance,
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor:
                              AppColors.notificationsLater,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            child: Text(
                              NotificationsStrings.later,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.notificationsLater,
                              ),
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
