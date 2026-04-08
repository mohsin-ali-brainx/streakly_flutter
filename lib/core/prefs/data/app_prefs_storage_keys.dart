/// Keys for [SharedPreferences] (and one-time SQLite `app_prefs` migration).
abstract final class AppPrefsStorageKeys {
  static const starterHabitsCreated = 'streakly_starter_habits_created';
  static const onboardingWelcomeStepCompleted =
      'streakly_onboarding_welcome_step_completed';
  static const onboardingCompleted = 'streakly_onboarding_completed';
  static const notificationsPermissionAsked =
      'streakly_notifications_permission_asked';
  static const notificationsEnabled = 'streakly_notifications_enabled';
  static const onboardingNotificationsStepCompleted =
      'streakly_onboarding_notifications_step_completed';

  /// Set after copying legacy SQLite `app_prefs` row (if any) once.
  static const migratedFromSqlitePrefs = 'streakly_migrated_sqlite_prefs_v1';
}
