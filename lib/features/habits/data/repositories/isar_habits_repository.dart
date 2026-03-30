import 'package:isar/isar.dart';

import '../../../../core/storage/isar_db.dart';
import '../../domain/entities/habit.dart';
import '../../domain/repositories/habits_repository.dart';
import '../isar/isar_habit.dart';
import '../mappers/habit_mapper.dart';

class IsarHabitsRepository implements HabitsRepository {
  IsarHabitsRepository(this._db);

  final IsarDb _db;

  Isar get _isar => _db.isar;

  @override
  Stream<List<Habit>> watchActiveHabits() {
    return _isar.isarHabits
        .filter()
        .archivedEqualTo(false)
        .sortByCreatedAt()
        .watch(fireImmediately: true)
        .map((items) => items.map((e) => e.toDomain()).toList(growable: false));
  }

  @override
  Future<List<Habit>> getActiveHabits() async {
    final items = await _isar.isarHabits
        .filter()
        .archivedEqualTo(false)
        .sortByCreatedAt()
        .findAll();
    return items.map((e) => e.toDomain()).toList(growable: false);
  }

  @override
  Future<int> createHabit({
    required String name,
    required String iconKey,
    bool reminderEnabled = false,
    int? reminderTimeMinutes,
  }) async {
    final habit = IsarHabit()
      ..name = name
      ..iconKey = iconKey
      ..createdAt = DateTime.now()
      ..reminderEnabled = reminderEnabled
      ..reminderTimeMinutes = reminderTimeMinutes
      ..archived = false;

    return _isar.writeTxn(() async {
      return await _isar.isarHabits.put(habit);
    });
  }

  @override
  Future<void> updateHabit(Habit habit) async {
    await _isar.writeTxn(() async {
      await _isar.isarHabits.put(habit.toIsar());
    });
  }

  @override
  Future<void> archiveHabit(int habitId) async {
    await _isar.writeTxn(() async {
      final h = await _isar.isarHabits.get(habitId);
      if (h == null) return;
      h.archived = true;
      await _isar.isarHabits.put(h);
    });
  }
}

