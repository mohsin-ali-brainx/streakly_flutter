import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../shared/presentation/widgets/welcome_blob_backdrop.dart';
import '../controller/onboarding_welcome_controller.dart';
import '../widgets/welcome_philosophy_card.dart';

class OnboardingWelcomeScreen extends StatelessWidget {
  const OnboardingWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingWelcomeController(),
      child: const _OnboardingWelcomeView(),
    );
  }
}

class _OnboardingWelcomeView extends StatelessWidget {
  const _OnboardingWelcomeView();

  Future<void> _goToSetup(BuildContext context, OnboardingWelcomeController c) async {
    await c.continueToSetup();
    if (!context.mounted) return;
    context.go(AppRoutes.onboardingSetup);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.welcomeCream,
      body: Stack(
        children: [
          const WelcomeBlobBackdrop(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: AppDimens.onboardingHeaderPaddingLoose,
                  child: Row(
                    children: [
                      Text(
                        AppStrings.appName,
                        style: textTheme.headlineSmall?.copyWith(
                          fontFamily: 'Georgia',
                          fontWeight: FontWeight.w700,
                          color: AppColors.logoBrown,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimens.pagePaddingHLoose,
                      AppDimens.spaceLg,
                      AppDimens.pagePaddingHLoose,
                      AppDimens.spaceSm,
                    ),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const WelcomePhilosophyCard(),
                      const SizedBox(height: AppDimens.space5xl),
                      Text(
                        WelcomeStrings.headline1,
                        textAlign: TextAlign.center,
                        style: textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                          height: 1.2,
                        ),
                      ),
                      Text(
                        WelcomeStrings.headline2,
                        textAlign: TextAlign.center,
                        style: textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: AppDimens.spaceXs),
                      Text(
                        WelcomeStrings.headline3,
                        textAlign: TextAlign.center,
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: AppColors.mutedGreen,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: AppDimens.space3xl),
                      Text(
                        WelcomeStrings.body,
                        textAlign: TextAlign.center,
                        style: textTheme.bodyLarge?.copyWith(
                          color: AppColors.inkMuted,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<OnboardingWelcomeController>(
                  builder: (context, c, _) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                        AppDimens.pagePaddingHLoose,
                        AppDimens.spaceSm,
                        AppDimens.pagePaddingHLoose,
                        AppDimens.spaceLg + MediaQuery.paddingOf(context).bottom,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: AppDimens.primaryButtonHeight,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.ctaBrown,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: const StadiumBorder(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppDimens.pagePaddingHLoose,
                                ),
                              ),
                              onPressed: c.submitting
                                  ? null
                                  : () => _goToSetup(context, c),
                              child: c.submitting
                                  ? const SizedBox(
                                      width: AppDimens.smallProgressSize,
                                      height: AppDimens.smallProgressSize,
                                      child: CircularProgressIndicator(
                                        strokeWidth: AppDimens.smallProgressStroke,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          WelcomeStrings.getStarted,
                                          style: textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.arrow_forward,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          const SizedBox(height: AppDimens.spaceXl),
                          Text(
                            WelcomeStrings.socialProof,
                            textAlign: TextAlign.center,
                            style: textTheme.labelSmall?.copyWith(
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600,
                              color: AppColors.skipGrey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
