import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/prefs/data/migrate_sqlite_prefs_to_shared_prefs.dart';
import '../core/prefs/data/shared_prefs_app_prefs_repository.dart';
import '../core/prefs/domain/app_prefs_repository.dart';
import '../core/storage/app_database.dart';
import '../features/habits/data/repositories/sqlite_habit_status_repository.dart';
import '../features/habits/data/repositories/sqlite_habits_repository.dart';
import '../features/habits/data/repositories/sqlite_insurance_repository.dart';
import '../features/habits/domain/repositories/habit_status_repository.dart';
import '../features/habits/domain/repositories/habits_repository.dart';
import '../features/habits/domain/repositories/insurance_repository.dart';
import '../features/habits/domain/usecases/get_habit_streaks.dart';
import '../features/habits/domain/usecases/get_insurance_state_for_habit.dart';
import '../features/habits/domain/usecases/use_insurance_for_yesterday.dart';
import '../features/notifications/data/flutter_local_notifications_permission_service.dart';
import '../features/notifications/data/habit_reminder_scheduler.dart';
import '../features/notifications/domain/notifications_permission_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final notifPlugin = FlutterLocalNotificationsPlugin();
  sl.registerSingleton<FlutterLocalNotificationsPlugin>(notifPlugin);

  final db = await AppDatabase.open();
  sl.registerSingleton<AppDatabase>(db);

  final sharedPrefs = await SharedPreferences.getInstance();
  await migrateSqlitePrefsToSharedPrefsIfNeeded(db, sharedPrefs);
  sl.registerSingleton<SharedPreferences>(sharedPrefs);

  sl.registerLazySingleton<AppPrefsRepository>(
    () => SharedPrefsAppPrefsRepository(sl()),
  );

  sl.registerLazySingleton<HabitsRepository>(() => SqliteHabitsRepository(sl()));
  sl.registerLazySingleton<HabitStatusRepository>(
    () => SqliteHabitStatusRepository(sl()),
  );
  sl.registerLazySingleton<InsuranceRepository>(
    () => SqliteInsuranceRepository(sl()),
  );

  final habitReminders = HabitReminderScheduler(notifPlugin);
  await habitReminders.ensureInitialized();
  sl.registerSingleton<HabitReminderScheduler>(habitReminders);

  // Don’t schedule notifications from DI: platform channels are safer after the first frame.

  sl.registerLazySingleton<NotificationsPermissionService>(
    () => FlutterLocalNotificationsPermissionService(sl()),
  );

  sl.registerFactory(() => GetHabitStreaks(sl()));
  sl.registerFactory(() => GetInsuranceStateForHabit(sl(), sl()));
  sl.registerFactory(() => UseInsuranceForYesterday(sl(), sl()));
}
