import '../core/constants/app_routes.dart';
import '../core/prefs/domain/app_prefs_repository.dart';

/// Target route after [SplashScreen]. Uses local prefs only.
///
/// **First launch:** Splash → Welcome (no step counter) → Setup **1/3** →
/// Notifications **2/3** → Insurance **3/3** → Today.
///
/// Must run after [AppPrefsRepository] is registered (e.g. from splash).
Future<String> resolveInitialOnboardingLocation(AppPrefsRepository prefs) async {
  final done = await prefs.isOnboardingCompleted();
  final starterCreated = await prefs.starterHabitsCreated();
  final notificationsDone = await prefs.onboardingNotificationsStepCompleted();
  final welcomeVisited = await prefs.onboardingWelcomeStepCompleted();

  if (done) return AppRoutes.today;
  if (starterCreated && notificationsDone) return AppRoutes.onboardingInsurance;
  if (starterCreated) return AppRoutes.onboardingNotifications;
  if (welcomeVisited) return AppRoutes.onboardingSetup;
  return AppRoutes.onboardingWelcome;
}
