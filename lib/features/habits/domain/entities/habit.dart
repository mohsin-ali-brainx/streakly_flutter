class Habit {
  const Habit({
    required this.id,
    required this.name,
    required this.iconKey,
    required this.createdAt,
    required this.reminderEnabled,
    this.reminderTimeMinutes,
    required this.archived,
  });

  final int id;
  final String name;

  /// A simple key for icon/emoji mapping in UI (e.g. "water", "read").
  final String iconKey;

  final DateTime createdAt;

  final bool reminderEnabled;

  /// Minutes since midnight local time (0..1439). Null when disabled.
  final int? reminderTimeMinutes;

  final bool archived;
}

