/// Onboarding progress for **habit setup → notifications → insurance** only.
/// Welcome is outside this flow and does not show [OnboardingProgressHeader].
abstract final class OnboardingProgress {
  OnboardingProgress._();

  static const int totalSteps = 3;

  static const int setupStep = 1;
  static const int notificationsStep = 2;
  static const int insuranceStep = 3;

  static String label(int step) => '$step/$totalSteps';

  static double value(int step) => step / totalSteps;
}
