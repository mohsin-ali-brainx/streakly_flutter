import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/onboarding_progress.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../shared/presentation/widgets/onboarding_eyebrow_text.dart';
import '../../../../shared/presentation/widgets/onboarding_progress_header.dart';
import '../../../../shared/presentation/widgets/streakly_primary_async_button.dart';
import '../controller/onboarding_notifications_controller.dart';

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

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingProgressHeader(
              step: OnboardingProgress.notificationsStep,
            ),
            const SizedBox(height: AppDimens.sectionGap),
            Expanded(
              child: ListView(
                padding: AppDimens.onboardingBodyPadding,
                children: [
                  const OnboardingEyebrowText(label: NotificationsStrings.eyebrow),
                  const SizedBox(height: AppDimens.spaceSm),
                  Text(
                    NotificationsStrings.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: AppDimens.spaceMd),
                  Text(
                    NotificationsStrings.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: AppDimens.space3xl),
                  Container(
                    padding: const EdgeInsets.all(AppDimens.space3xl),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                      color: cs.surfaceContainerHighest,
                      border: Border.all(color: cs.outlineVariant),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: cs.surface,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: cs.outlineVariant),
                              ),
                              alignment: Alignment.center,
                              child: const Text('🔔', style: TextStyle(fontSize: 18)),
                            ),
                            const SizedBox(width: AppDimens.spaceLg),
                            Expanded(
                              child: Text(
                                NotificationsStrings.cardTitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppDimens.spaceMd),
                        Text(
                          NotificationsStrings.cardExample,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: cs.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Consumer<OnboardingNotificationsController>(
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
                        label: NotificationsStrings.enable,
                        isLoading: c.submitting,
                        onPressed: () async {
                          await c.enable();
                          if (!context.mounted) return;
                          context.go(AppRoutes.onboardingInsurance);
                        },
                      ),
                      const SizedBox(height: AppDimens.spaceMd),
                      TextButton(
                        onPressed: c.submitting
                            ? null
                            : () async {
                                await c.skip();
                                if (!context.mounted) return;
                                context.go(AppRoutes.onboardingInsurance);
                              },
                        child: Text(AppStrings.notNow),
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
