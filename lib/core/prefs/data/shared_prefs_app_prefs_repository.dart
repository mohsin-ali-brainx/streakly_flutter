import 'package:shared_preferences/shared_preferences.dart';

import '../domain/app_prefs_repository.dart';
import 'app_prefs_storage_keys.dart';

class SharedPrefsAppPrefsRepository implements AppPrefsRepository {
  SharedPrefsAppPrefsRepository(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<bool> starterHabitsCreated() async =>
      _prefs.getBool(AppPrefsStorageKeys.starterHabitsCreated) ?? false;

  @override
  Future<void> setStarterHabitsCreated(bool value) async {
    await _prefs.setBool(AppPrefsStorageKeys.starterHabitsCreated, value);
  }

  @override
  Future<bool> onboardingWelcomeStepCompleted() async =>
      _prefs.getBool(AppPrefsStorageKeys.onboardingWelcomeStepCompleted) ??
      false;

  @override
  Future<void> setOnboardingWelcomeStepCompleted(bool value) async {
    await _prefs.setBool(
      AppPrefsStorageKeys.onboardingWelcomeStepCompleted,
      value,
    );
  }

  @override
  Future<bool> isOnboardingCompleted() async =>
      _prefs.getBool(AppPrefsStorageKeys.onboardingCompleted) ?? false;

  @override
  Future<void> setOnboardingCompleted(bool value) async {
    await _prefs.setBool(AppPrefsStorageKeys.onboardingCompleted, value);
  }

  @override
  Future<bool> notificationsPermissionAsked() async =>
      _prefs.getBool(AppPrefsStorageKeys.notificationsPermissionAsked) ?? false;

  @override
  Future<void> setNotificationsPermissionAsked(bool value) async {
    await _prefs.setBool(AppPrefsStorageKeys.notificationsPermissionAsked, value);
  }

  @override
  Future<bool> notificationsEnabled() async =>
      _prefs.getBool(AppPrefsStorageKeys.notificationsEnabled) ?? false;

  @override
  Future<void> setNotificationsEnabled(bool value) async {
    await _prefs.setBool(AppPrefsStorageKeys.notificationsEnabled, value);
  }

  @override
  Future<bool> onboardingNotificationsStepCompleted() async =>
      _prefs.getBool(
        AppPrefsStorageKeys.onboardingNotificationsStepCompleted,
      ) ??
      false;

  @override
  Future<void> setOnboardingNotificationsStepCompleted(bool value) async {
    await _prefs.setBool(
      AppPrefsStorageKeys.onboardingNotificationsStepCompleted,
      value,
    );
  }
}
