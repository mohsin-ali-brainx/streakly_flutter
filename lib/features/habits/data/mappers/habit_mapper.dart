import '../../domain/entities/habit.dart';
import '../isar/isar_habit.dart';

extension HabitToDomain on IsarHabit {
  Habit toDomain() {
    return Habit(
      id: id,
      name: name,
      iconKey: iconKey,
      createdAt: createdAt,
      reminderEnabled: reminderEnabled,
      reminderTimeMinutes: reminderTimeMinutes,
      archived: archived,
    );
  }
}

extension HabitToIsar on Habit {
  IsarHabit toIsar() {
    final h = IsarHabit()
      ..id = id
      ..name = name
      ..iconKey = iconKey
      ..createdAt = createdAt
      ..reminderEnabled = reminderEnabled
      ..reminderTimeMinutes = reminderTimeMinutes
      ..archived = archived;
    return h;
  }
}

