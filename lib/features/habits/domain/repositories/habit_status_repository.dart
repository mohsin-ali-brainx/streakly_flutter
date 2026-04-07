import '../entities/habit_day_status.dart';

abstract class HabitStatusRepository {
  /// Watch statuses for a single day (local dayKey).
  Stream<List<HabitDayStatus>> watchStatusesForDay(String dayKey);

  Future<List<HabitDayStatus>> getStatusesForDay(String dayKey);

  /// Fetch all statuses for a habit (used for streak computations).
  Future<List<HabitDayStatus>> getStatusesForHabit(int habitId);

  /// Mark a habit's status for a day.
  Future<void> setStatus({
    required int habitId,
    required String dayKey,
    required HabitDayCompletionStatus status,
  });

  /// Remove today's row so the habit shows as not yet done (toggle off).
  Future<void> deleteStatusForDay({
    required int habitId,
    required String dayKey,
  });
}
