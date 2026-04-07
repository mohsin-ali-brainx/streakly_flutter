import '../../domain/entities/habit_day_status.dart';

const int kStatusDone = 0;
const int kStatusMissed = 1;
const int kStatusInsured = 2;

int habitCompletionStatusToInt(HabitDayCompletionStatus status) {
  return switch (status) {
    HabitDayCompletionStatus.done => kStatusDone,
    HabitDayCompletionStatus.missed => kStatusMissed,
    HabitDayCompletionStatus.insured => kStatusInsured,
  };
}

HabitDayCompletionStatus habitCompletionStatusFromInt(int value) {
  return switch (value) {
    kStatusDone => HabitDayCompletionStatus.done,
    kStatusMissed => HabitDayCompletionStatus.missed,
    kStatusInsured => HabitDayCompletionStatus.insured,
    _ => HabitDayCompletionStatus.done,
  };
}

HabitDayStatus habitDayStatusFromRow(Map<String, Object?> row) {
  return HabitDayStatus(
    id: row['id'] as int,
    habitId: row['habit_id'] as int,
    dayKey: row['day_key'] as String,
    status: habitCompletionStatusFromInt(row['status'] as int),
    updatedAt: DateTime.parse(row['updated_at'] as String),
  );
}
