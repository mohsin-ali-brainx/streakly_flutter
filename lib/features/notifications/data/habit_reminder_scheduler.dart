import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../../habits/domain/entities/habit.dart';

const String _androidChannelId = 'streakly_habit_reminders';
const String _androidChannelName = 'Habit reminders';
const String _androidChannelDescription =
    'Gentle daily reminders to check in on your habits';

/// Daily local notifications per habit (id = [Habit.id]).
class HabitReminderScheduler {
  HabitReminderScheduler(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;

  bool _initialized = false;

  Future<void> ensureInitialized() async {
    if (_initialized) return;
    if (kIsWeb) {
      _initialized = true;
      return;
    }
    if (defaultTargetPlatform == TargetPlatform.linux) {
      _initialized = true;
      return;
    }

    tzdata.initializeTimeZones();
    try {
      final name = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(name));
    } catch (_) {
      tz.setLocalLocation(tz.UTC);
    }

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    await _plugin.initialize(
      const InitializationSettings(
        android: androidInit,
        iOS: iosInit,
        macOS: iosInit,
      ),
    );

    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android != null) {
      await android.createNotificationChannel(
        const AndroidNotificationChannel(
          _androidChannelId,
          _androidChannelName,
          description: _androidChannelDescription,
          importance: Importance.defaultImportance,
        ),
      );
    }

    _initialized = true;
  }

  Future<void> cancel(int habitId) async {
    if (kIsWeb || defaultTargetPlatform == TargetPlatform.linux) return;
    await _plugin.cancel(habitId);
  }

  /// Cancels any existing schedule for [habit], then schedules if enabled.
  Future<void> syncFromHabit(Habit habit) async {
    await cancel(habit.id);
    if (!habit.reminderEnabled || habit.reminderTimeMinutes == null) return;
    if (kIsWeb || defaultTargetPlatform == TargetPlatform.linux) return;

    final m = habit.reminderTimeMinutes!;
    final hour = m ~/ 60;
    final minute = m % 60;
    final scheduled = _nextInstanceOfLocalTime(hour, minute);

    const android = AndroidNotificationDetails(
      _androidChannelId,
      _androidChannelName,
      channelDescription: _androidChannelDescription,
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const ios = DarwinNotificationDetails();
    final details = NotificationDetails(android: android, iOS: ios, macOS: ios);

    await _plugin.zonedSchedule(
      habit.id,
      'Time for ${habit.name}',
      'Open Streakly to log your habit.',
      scheduled,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfLocalTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
