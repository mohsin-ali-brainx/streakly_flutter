import '../entities/habit.dart';

abstract class HabitsRepository {
  Stream<List<Habit>> watchActiveHabits();
  Future<List<Habit>> getActiveHabits();

  Future<Habit> createHabit({
    required String name,
    required String iconKey,
    bool reminderEnabled = false,
    int? reminderTimeMinutes,
  });

  Future<void> updateHabit(Habit habit);
  Future<void> archiveHabit(int habitId);

  /// Persists order of active habits (indices 0..n-1 → sortOrder).
  Future<void> setActiveHabitsOrder(List<int> orderedHabitIds);
}
