import 'package:shared_preferences/shared_preferences.dart';

import '../../storage/app_database.dart';
import 'app_prefs_storage_keys.dart';

/// Copies the old SQLite `app_prefs` row into SharedPreferences once, so updates
/// don’t reset onboarding for existing users.
Future<void> migrateSqlitePrefsToSharedPrefsIfNeeded(
  AppDatabase db,
  SharedPreferences prefs,
) async {
  if (prefs.getBool(AppPrefsStorageKeys.migratedFromSqlitePrefs) == true) {
    return;
  }

  try {
    final tables = await db.database.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='app_prefs'",
    );
    if (tables.isNotEmpty) {
      final rows = await db.database.query(
        'app_prefs',
        where: 'id = ?',
        whereArgs: [0],
        limit: 1,
      );
      if (rows.isNotEmpty) {
        final r = rows.single;
        await prefs.setBool(
          AppPrefsStorageKeys.starterHabitsCreated,
          (r['starter_habits_created'] as int) != 0,
        );
        await prefs.setBool(
          AppPrefsStorageKeys.onboardingWelcomeStepCompleted,
          (r['onboarding_welcome_step_completed'] as int) != 0,
        );
        await prefs.setBool(
          AppPrefsStorageKeys.onboardingCompleted,
          (r['onboarding_completed'] as int) != 0,
        );
        await prefs.setBool(
          AppPrefsStorageKeys.notificationsPermissionAsked,
          (r['notifications_permission_asked'] as int) != 0,
        );
        await prefs.setBool(
          AppPrefsStorageKeys.notificationsEnabled,
          (r['notifications_enabled'] as int) != 0,
        );
        await prefs.setBool(
          AppPrefsStorageKeys.onboardingNotificationsStepCompleted,
          (r['onboarding_notifications_step_completed'] as int) != 0,
        );
      }
    }
  } catch (_) {
    // Ignore corrupt/missing schema; prefs will use defaults.
  }

  await prefs.setBool(AppPrefsStorageKeys.migratedFromSqlitePrefs, true);
}
