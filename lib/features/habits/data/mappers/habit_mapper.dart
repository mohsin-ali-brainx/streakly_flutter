import '../../domain/entities/habit.dart';

Habit habitFromRow(Map<String, Object?> row) {
  return Habit(
    id: row['id'] as int,
    name: row['name'] as String,
    iconKey: row['icon_key'] as String,
    createdAt: DateTime.parse(row['created_at'] as String),
    sortOrder: row['sort_order'] as int,
    reminderEnabled: (row['reminder_enabled'] as int) != 0,
    reminderTimeMinutes: row['reminder_time_minutes'] as int?,
    archived: (row['archived'] as int) != 0,
  );
}

/// Row map for `INSERT` (no `id`).
Map<String, Object?> habitToInsertMap({
  required String name,
  required String iconKey,
  required DateTime createdAt,
  required int sortOrder,
  required bool reminderEnabled,
  int? reminderTimeMinutes,
  required bool archived,
}) {
  return {
    'name': name,
    'icon_key': iconKey,
    'created_at': createdAt.toIso8601String(),
    'sort_order': sortOrder,
    'reminder_enabled': reminderEnabled ? 1 : 0,
    'reminder_time_minutes': reminderTimeMinutes,
    'archived': archived ? 1 : 0,
  };
}

/// Row map for `UPDATE` by primary key (includes all columns).
Map<String, Object?> habitToUpdateMap(Habit habit) {
  return {
    'name': habit.name,
    'icon_key': habit.iconKey,
    'created_at': habit.createdAt.toIso8601String(),
    'sort_order': habit.sortOrder,
    'reminder_enabled': habit.reminderEnabled ? 1 : 0,
    'reminder_time_minutes': habit.reminderTimeMinutes,
    'archived': habit.archived ? 1 : 0,
  };
}
