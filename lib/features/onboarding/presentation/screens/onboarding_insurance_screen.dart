import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/onboarding_progress.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../shared/presentation/widgets/icon_bullet_card.dart';
import '../../../../shared/presentation/widgets/onboarding_eyebrow_text.dart';
import '../../../../shared/presentation/widgets/onboarding_progress_header.dart';
import '../../../../shared/presentation/widgets/streakly_primary_async_button.dart';
import '../controller/onboarding_insurance_controller.dart';

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

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressHeader(step: OnboardingProgress.insuranceStep),
            const SizedBox(height: AppDimens.sectionGap),
            Expanded(
              child: ListView(
                padding: AppDimens.onboardingBodyPadding,
                children: [
                  const OnboardingEyebrowText(label: InsuranceStrings.eyebrow),
                  const SizedBox(height: AppDimens.spaceSm),
                  Text(
                    InsuranceStrings.title,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: AppDimens.spaceMd),
                  Text(
                    InsuranceStrings.subtitle,
                    style: textTheme.bodyMedium?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppDimens.space4xl),
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: cs.primaryContainer,
                        border: Border.all(color: cs.outlineVariant, width: 2),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            size: 72,
                            color: cs.primary,
                          ),
                          Positioned(
                            bottom: 18,
                            child: Text(
                              '🔥',
                              style: textTheme.headlineSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimens.space4xl),
                  const IconBulletCard(
                    icon: Icons.shield_moon_outlined,
                    title: InsuranceStrings.bullet1Title,
                    subtitle: InsuranceStrings.bullet1Subtitle,
                  ),
                  const SizedBox(height: AppDimens.spaceXl),
                  const IconBulletCard(
                    icon: Icons.event_repeat_outlined,
                    title: InsuranceStrings.bullet2Title,
                    subtitle: InsuranceStrings.bullet2Subtitle,
                  ),
                  const SizedBox(height: AppDimens.spaceXl),
                  const IconBulletCard(
                    icon: Icons.favorite_outline,
                    title: InsuranceStrings.bullet3Title,
                    subtitle: InsuranceStrings.bullet3Subtitle,
                  ),
                ],
              ),
            ),
            Consumer<OnboardingInsuranceController>(
              builder: (context, c, _) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimens.pagePaddingH,
                    AppDimens.spaceXl,
                    AppDimens.pagePaddingH,
                    AppDimens.space2xl,
                  ),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    border: Border(
                      top: BorderSide(color: cs.outlineVariant),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StreaklyPrimaryAsyncButton(
                        label: AppStrings.nextArrow,
                        isLoading: c.submitting,
                        onPressed: () async {
                          await c.finish();
                          if (!context.mounted) return;
                          context.go(AppRoutes.today);
                        },
                      ),
                      const SizedBox(height: AppDimens.spaceSm),
                      Text(
                        InsuranceStrings.footerHint,
                        style: textTheme.labelSmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
