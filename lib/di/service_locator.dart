import 'package:get_it/get_it.dart';

import '../core/prefs/data/isar_app_prefs_repository.dart';
import '../core/prefs/domain/app_prefs_repository.dart';
import '../core/storage/isar_db.dart';
import '../features/notifications/data/flutter_local_notifications_permission_service.dart';
import '../features/notifications/domain/notifications_permission_service.dart';
import '../features/habits/data/repositories/isar_habit_status_repository.dart';
import '../features/habits/data/repositories/isar_habits_repository.dart';
import '../features/habits/data/repositories/isar_insurance_repository.dart';
import '../features/habits/domain/repositories/habit_status_repository.dart';
import '../features/habits/domain/repositories/habits_repository.dart';
import '../features/habits/domain/repositories/insurance_repository.dart';
import '../features/habits/domain/usecases/get_habit_streaks.dart';
import '../features/habits/domain/usecases/get_insurance_state_for_habit.dart';
import '../features/habits/domain/usecases/use_insurance_for_yesterday.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Storage
  final db = await IsarDb.open();
  sl.registerSingleton<IsarDb>(db);

  // App prefs
  sl.registerLazySingleton<AppPrefsRepository>(
    () => IsarAppPrefsRepository(sl()),
  );

  // Notifications (permission only for now; scheduling comes next)
  sl.registerLazySingleton<FlutterLocalNotificationsPlugin>(
    () => FlutterLocalNotificationsPlugin(),
  );
  sl.registerLazySingleton<NotificationsPermissionService>(
    () => FlutterLocalNotificationsPermissionService(sl()),
  );

  // Repositories
  sl.registerLazySingleton<HabitsRepository>(() => IsarHabitsRepository(sl()));
  sl.registerLazySingleton<HabitStatusRepository>(
    () => IsarHabitStatusRepository(sl()),
  );
  sl.registerLazySingleton<InsuranceRepository>(
    () => IsarInsuranceRepository(sl()),
  );

  // Use-cases (domain)
  sl.registerFactory(() => GetHabitStreaks(sl()));
  sl.registerFactory(() => GetInsuranceStateForHabit(sl(), sl()));
  sl.registerFactory(() => UseInsuranceForYesterday(sl(), sl()));
}

