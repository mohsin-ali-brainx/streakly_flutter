import 'package:flutter_test/flutter_test.dart';

import 'package:streakly_app_flutter/core/time/local_day.dart';
import 'package:streakly_app_flutter/features/habits/domain/entities/habit_day_status.dart';
import 'package:streakly_app_flutter/features/habits/domain/services/streak_calculator.dart';

HabitDayStatus _s({
  required int id,
  required int habitId,
  required DateTime day,
  required HabitDayCompletionStatus status,
}) {
  return HabitDayStatus(
    id: id,
    habitId: habitId,
    dayKey: LocalDay.dayKey(LocalDay.startOfDay(day)),
    status: status,
    updatedAt: DateTime.now(),
  );
}

void main() {
  group('StreakCalculator.compute', () {
    test('counts insured as effective done', () {
      final today = LocalDay.todayStart();
      final asOfKey = LocalDay.dayKey(today);
      final statuses = [
        _s(
          id: 1,
          habitId: 1,
          day: today,
          status: HabitDayCompletionStatus.done,
        ),
        _s(
          id: 2,
          habitId: 1,
          day: today.subtract(const Duration(days: 1)),
          status: HabitDayCompletionStatus.insured,
        ),
      ];

      final streak = StreakCalculator.compute(asOfDayKey: asOfKey, statuses: statuses);
      expect(streak.current, 2);
      expect(streak.best, 2);
    });
  });

  group('StreakCalculator.canUseInsuranceForYesterday', () {
    test('eligible when before-yesterday done and yesterday missed', () {
      final today = LocalDay.todayStart();
      final todayKey = LocalDay.dayKey(today);
      final statuses = [
        _s(
          id: 1,
          habitId: 1,
          day: today.subtract(const Duration(days: 2)),
          status: HabitDayCompletionStatus.done,
        ),
        _s(
          id: 2,
          habitId: 1,
          day: today.subtract(const Duration(days: 1)),
          status: HabitDayCompletionStatus.missed,
        ),
      ];

      final ok = StreakCalculator.canUseInsuranceForYesterday(
        todayKey: todayKey,
        statuses: statuses,
      );
      expect(ok, true);
    });

    test('not eligible when yesterday already insured', () {
      final today = LocalDay.todayStart();
      final todayKey = LocalDay.dayKey(today);
      final statuses = [
        _s(
          id: 1,
          habitId: 1,
          day: today.subtract(const Duration(days: 2)),
          status: HabitDayCompletionStatus.done,
        ),
        _s(
          id: 2,
          habitId: 1,
          day: today.subtract(const Duration(days: 1)),
          status: HabitDayCompletionStatus.insured,
        ),
      ];

      final ok = StreakCalculator.canUseInsuranceForYesterday(
        todayKey: todayKey,
        statuses: statuses,
      );
      expect(ok, false);
    });
  });
}

