import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../di/service_locator.dart';
import '../features/notifications/data/habit_reminder_scheduler.dart';
import '../features/habits/domain/repositories/habits_repository.dart';
import 'app_router.dart';
import 'theme_mode_controller.dart';
import '../ui/theme/app_theme.dart';

class StreaklyApp extends StatefulWidget {
  const StreaklyApp({super.key});

  @override
  State<StreaklyApp> createState() => _StreaklyAppState();
}

class _StreaklyAppState extends State<StreaklyApp> with WidgetsBindingObserver {
  late final GoRouter _router = buildRouter();
  late final ThemeModeController _theme = sl<ThemeModeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncHabitReminders());
    WidgetsBinding.instance.addPostFrameCallback((_) => _theme.load());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _syncHabitReminders();
    }
  }

  Future<void> _syncHabitReminders() async {
    if (!sl.isRegistered<HabitReminderScheduler>()) return;
    try {
      final habits = await sl<HabitsRepository>().getActiveHabits();
      final scheduler = sl<HabitReminderScheduler>();
      await scheduler.syncAllActiveHabits(habits);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _theme,
      child: Consumer<ThemeModeController>(
        builder: (context, t, _) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Streakly',
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: t.mode,
            routerConfig: _router,
          );
        },
      ),
    );
  }
}

