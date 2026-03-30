import 'package:isar/isar.dart';

part 'isar_habit_day_status.g.dart';

enum IsarHabitDayCompletionStatus {
  done,
  missed,
  insured,
}

@collection
class IsarHabitDayStatus {
  IsarHabitDayStatus();

  Id id = Isar.autoIncrement;

  @Index()
  late int habitId;

  /// Local day key `yyyy-MM-dd`.
  @Index()
  late String dayKey;

  @enumerated
  late IsarHabitDayCompletionStatus status;

  late DateTime updatedAt;

  /// Ensure only one record per habitId+dayKey.
  @Index(unique: true)
  late String habitIdDayKey;
}

