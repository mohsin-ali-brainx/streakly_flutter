import '../../domain/entities/habit_day_status.dart';
import '../isar/isar_habit_day_status.dart';

HabitDayCompletionStatus _toDomainStatus(IsarHabitDayCompletionStatus s) {
  return switch (s) {
    IsarHabitDayCompletionStatus.done => HabitDayCompletionStatus.done,
    IsarHabitDayCompletionStatus.missed => HabitDayCompletionStatus.missed,
    IsarHabitDayCompletionStatus.insured => HabitDayCompletionStatus.insured,
  };
}

IsarHabitDayCompletionStatus _toIsarStatus(HabitDayCompletionStatus s) {
  return switch (s) {
    HabitDayCompletionStatus.done => IsarHabitDayCompletionStatus.done,
    HabitDayCompletionStatus.missed => IsarHabitDayCompletionStatus.missed,
    HabitDayCompletionStatus.insured => IsarHabitDayCompletionStatus.insured,
  };
}

extension HabitDayStatusToDomain on IsarHabitDayStatus {
  HabitDayStatus toDomain() {
    return HabitDayStatus(
      id: id,
      habitId: habitId,
      dayKey: dayKey,
      status: _toDomainStatus(status),
      updatedAt: updatedAt,
    );
  }
}

extension HabitDayStatusToIsar on HabitDayStatus {
  IsarHabitDayStatus toIsar() {
    final s = IsarHabitDayStatus()
      ..id = id
      ..habitId = habitId
      ..dayKey = dayKey
      ..status = _toIsarStatus(status)
      ..updatedAt = updatedAt
      ..habitIdDayKey = '$habitId|$dayKey';
    return s;
  }
}

