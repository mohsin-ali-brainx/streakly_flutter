import 'package:isar/isar.dart';

part 'isar_habit.g.dart';

@collection
class IsarHabit {
  IsarHabit();

  Id id = Isar.autoIncrement;

  late String name;
  late String iconKey;

  late DateTime createdAt;

  bool reminderEnabled = false;

  /// Minutes since midnight.
  int? reminderTimeMinutes;

  bool archived = false;
}

