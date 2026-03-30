import 'package:isar/isar.dart';

import '../../storage/isar_db.dart';
import '../domain/app_prefs_repository.dart';
import 'isar/isar_app_prefs.dart';

class IsarAppPrefsRepository implements AppPrefsRepository {
  IsarAppPrefsRepository(this._db);

  final IsarDb _db;

  Isar get _isar => _db.isar;

  Future<IsarAppPrefs> _getOrCreate() async {
    final existing = await _isar.isarAppPrefs.get(0);
    if (existing != null) return existing;

    final prefs = IsarAppPrefs()
      ..id = 0
      ..starterHabitsCreated = false
      ..onboardingWelcomeStepCompleted = false
      ..onboardingCompleted = false
      ..notificationsPermissionAsked = false
      ..notificationsEnabled = false
      ..onboardingNotificationsStepCompleted = false
      ..updatedAt = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.isarAppPrefs.put(prefs);
    });

    return prefs;
  }

  @override
  Future<bool> starterHabitsCreated() async {
    final prefs = await _getOrCreate();
    return prefs.starterHabitsCreated;
  }

  @override
  Future<void> setStarterHabitsCreated(bool value) async {
    final prefs = await _getOrCreate();
    prefs.starterHabitsCreated = value;
    prefs.updatedAt = DateTime.now();
    await _isar.writeTxn(() async {
      await _isar.isarAppPrefs.put(prefs);
    });
  }

  @override
  Future<bool> onboardingWelcomeStepCompleted() async {
    final prefs = await _getOrCreate();
    return prefs.onboardingWelcomeStepCompleted;
  }

  @override
  Future<void> setOnboardingWelcomeStepCompleted(bool value) async {
    final prefs = await _getOrCreate();
    prefs.onboardingWelcomeStepCompleted = value;
    prefs.updatedAt = DateTime.now();
    await _isar.writeTxn(() async {
      await _isar.isarAppPrefs.put(prefs);
    });
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    final prefs = await _getOrCreate();
    return prefs.onboardingCompleted;
  }

  @override
  Future<void> setOnboardingCompleted(bool value) async {
    final prefs = await _getOrCreate();
    prefs.onboardingCompleted = value;
    prefs.updatedAt = DateTime.now();
    await _isar.writeTxn(() async {
      await _isar.isarAppPrefs.put(prefs);
    });
  }

  @override
  Future<bool> notificationsPermissionAsked() async {
    final prefs = await _getOrCreate();
    return prefs.notificationsPermissionAsked;
  }

  @override
  Future<void> setNotificationsPermissionAsked(bool value) async {
    final prefs = await _getOrCreate();
    prefs.notificationsPermissionAsked = value;
    prefs.updatedAt = DateTime.now();
    await _isar.writeTxn(() async {
      await _isar.isarAppPrefs.put(prefs);
    });
  }

  @override
  Future<bool> notificationsEnabled() async {
    final prefs = await _getOrCreate();
    return prefs.notificationsEnabled;
  }

  @override
  Future<void> setNotificationsEnabled(bool value) async {
    final prefs = await _getOrCreate();
    prefs.notificationsEnabled = value;
    prefs.updatedAt = DateTime.now();
    await _isar.writeTxn(() async {
      await _isar.isarAppPrefs.put(prefs);
    });
  }

  @override
  Future<bool> onboardingNotificationsStepCompleted() async {
    final prefs = await _getOrCreate();
    return prefs.onboardingNotificationsStepCompleted;
  }

  @override
  Future<void> setOnboardingNotificationsStepCompleted(bool value) async {
    final prefs = await _getOrCreate();
    prefs.onboardingNotificationsStepCompleted = value;
    prefs.updatedAt = DateTime.now();
    await _isar.writeTxn(() async {
      await _isar.isarAppPrefs.put(prefs);
    });
  }
}

