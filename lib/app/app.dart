import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../di/service_locator.dart';
import '../features/notifications/data/habit_reminder_scheduler.dart';
import '../features/habits/domain/repositories/habits_repository.dart';
import 'app_router.dart';
import '../ui/theme/app_theme.dart';

class StreaklyApp extends StatefulWidget {
  const StreaklyApp({super.key});

  @override
  State<StreaklyApp> createState() => _StreaklyAppState();
}

class _StreaklyAppState extends State<StreaklyApp> {
  late final GoRouter _router = buildRouter();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncHabitReminders());
  }

  Future<void> _syncHabitReminders() async {
    if (!sl.isRegistered<HabitReminderScheduler>()) return;
    try {
      final habits = await sl<HabitsRepository>().getActiveHabits();
      final scheduler = sl<HabitReminderScheduler>();
      for (final h in habits) {
        await scheduler.syncFromHabit(h);
      }
    } catch (_) {
      // Non-fatal; reminders can be fixed from settings later.
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Streakly',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}

