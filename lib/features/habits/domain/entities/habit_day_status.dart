enum HabitDayCompletionStatus {
  done,
  missed,
  insured,
}

class HabitDayStatus {
  const HabitDayStatus({
    required this.id,
    required this.habitId,
    required this.dayKey,
    required this.status,
    required this.updatedAt,
  });

  final int id;
  final int habitId;

  /// Local day key `yyyy-MM-dd`.
  final String dayKey;

  final HabitDayCompletionStatus status;
  final DateTime updatedAt;
}

