import '../entities/habit.dart';

abstract class HabitsRepository {
  Stream<List<Habit>> watchActiveHabits();
  Future<List<Habit>> getActiveHabits();

  Future<int> createHabit({
    required String name,
    required String iconKey,
    bool reminderEnabled = false,
    int? reminderTimeMinutes,
  });

  Future<void> updateHabit(Habit habit);
  Future<void> archiveHabit(int habitId);
}

