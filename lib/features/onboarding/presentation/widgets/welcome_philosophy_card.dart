import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:streakly_assets/streakly_assets.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../shared/presentation/widgets/onboarding_eyebrow_text.dart';

/// Featured card on the welcome / philosophy step.
class WelcomePhilosophyCard extends StatelessWidget {
  const WelcomePhilosophyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 18,
            right: 18,
            child: SvgPicture.asset(
              StreaklyIcons.icWelcomeStars,
              package: kStreaklyAssetsPackage,
              height: 14,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 36, 28, 32),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.badgeFill,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.local_fire_department_rounded,
                    size: 80,
                    color: AppColors.logoBrown.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: AppDimens.space5xl),
                const OnboardingEyebrowText(
                  label: WelcomeStrings.philosophyEyebrow,
                  fontSize: 16,
                ),
                const SizedBox(height: AppDimens.space3xl),
                Text.rich(
                  TextSpan(
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink,
                      height: 1.35,
                    ),
                    children: const [
                      TextSpan(text: WelcomeStrings.philosophyLead),
                      TextSpan(
                        text: WelcomeStrings.philosophyEmphasis,
                        style: TextStyle(
                          color: AppColors.logoBrown,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(text: WelcomeStrings.philosophyTrail),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
