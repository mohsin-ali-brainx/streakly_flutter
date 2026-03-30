import 'package:flutter/material.dart';

import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/onboarding_progress.dart';
import '../../../core/l10n/app_strings.dart';
import 'streakly_wordmark.dart';

/// “Streakly” + progress label + circular progress for onboarding steps.
class OnboardingProgressHeader extends StatelessWidget {
  const OnboardingProgressHeader({
    super.key,
    required this.step,
  });

  /// 1–[OnboardingProgress.totalSteps].
  final int step;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: AppDimens.onboardingHeaderPadding,
      child: Row(
        children: [
          const StreaklyWordmark.compact(),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                AppStrings.progress,
                style: textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                OnboardingProgress.label(step),
                style: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(width: AppDimens.spaceLg),
          SizedBox(
            width: AppDimens.onboardingProgressRing,
            height: AppDimens.onboardingProgressRing,
            child: CircularProgressIndicator(
              value: OnboardingProgress.value(step),
              strokeWidth: AppDimens.progressStroke,
              backgroundColor: cs.surfaceContainerHighest,
            ),
          ),
        ],
      ),
    );
  }
}
