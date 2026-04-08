abstract class AppPrefsRepository {
  Future<bool> starterHabitsCreated();
  Future<void> setStarterHabitsCreated(bool value);

  /// `true` once welcome intro is done (saved before opening habit setup).
  Future<bool> onboardingWelcomeStepCompleted();
  Future<void> setOnboardingWelcomeStepCompleted(bool value);

  Future<bool> isOnboardingCompleted();
  Future<void> setOnboardingCompleted(bool value);

  Future<bool> notificationsPermissionAsked();
  Future<void> setNotificationsPermissionAsked(bool value);

  Future<bool> notificationsEnabled();
  Future<void> setNotificationsEnabled(bool value);

  Future<bool> onboardingNotificationsStepCompleted();
  Future<void> setOnboardingNotificationsStepCompleted(bool value);
}

