import 'package:isar/isar.dart';

part 'isar_app_prefs.g.dart';

@collection
class IsarAppPrefs {
  IsarAppPrefs();

  /// Single row table.
  Id id = 0;

  /// True once we've created starter habits from onboarding selection.
  bool starterHabitsCreated = false;

  /// Locally persisted when the user finishes Welcome (Get Started or Skip).
  /// Splash + router use this so setup is never shown before welcome on first launch.
  bool onboardingWelcomeStepCompleted = false;

  bool onboardingCompleted = false;

  /// Whether user has been asked for notification permission.
  bool notificationsPermissionAsked = false;

  /// Last known permission result.
  bool notificationsEnabled = false;

  /// True after user finishes the notifications onboarding step (2 of 3).
  bool onboardingNotificationsStepCompleted = false;

  late DateTime updatedAt;
}

