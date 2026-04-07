import 'dart:async';

import '../../../../core/storage/app_database.dart';
import '../../domain/entities/habit.dart';
import '../../domain/repositories/habits_repository.dart';
import '../mappers/habit_mapper.dart';

class SqliteHabitsRepository implements HabitsRepository {
  SqliteHabitsRepository(this._db);

  final AppDatabase _db;

  final _habitChanges = StreamController<void>.broadcast();

  void _notifyHabits() {
    if (!_habitChanges.isClosed) _habitChanges.add(null);
  }

  List<Habit> _sortedActive(List<Habit> items) {
    final copy = List<Habit>.from(items);
    copy.sort((a, b) {
      final o = a.sortOrder.compareTo(b.sortOrder);
      if (o != 0) return o;
      return a.createdAt.compareTo(b.createdAt);
    });
    return copy;
  }

  @override
  Stream<List<Habit>> watchActiveHabits() async* {
    yield await getActiveHabits();
    await for (final _ in _habitChanges.stream) {
      yield await getActiveHabits();
    }
  }

  @override
  Future<List<Habit>> getActiveHabits() async {
    final rows = await _db.database.query(
      'habits',
      where: 'archived = ?',
      whereArgs: [0],
    );
    final list = rows.map(habitFromRow).toList(growable: false);
    return _sortedActive(list);
  }

  @override
  Future<Habit> createHabit({
    required String name,
    required String iconKey,
    bool reminderEnabled = false,
    int? reminderTimeMinutes,
  }) async {
    final active = await getActiveHabits();
    var maxOrder = 0;
    for (final h in active) {
      if (h.sortOrder > maxOrder) maxOrder = h.sortOrder;
    }

    final id = await _db.database.insert(
      'habits',
      habitToInsertMap(
        name: name,
        iconKey: iconKey,
        createdAt: DateTime.now(),
        sortOrder: maxOrder + 1,
        reminderEnabled: reminderEnabled,
        reminderTimeMinutes: reminderTimeMinutes,
        archived: false,
      ),
    );

    final rows = await _db.database.query(
      'habits',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    _notifyHabits();
    return habitFromRow(rows.single);
  }

  @override
  Future<void> updateHabit(Habit habit) async {
    await _db.database.update(
      'habits',
      habitToUpdateMap(habit),
      where: 'id = ?',
      whereArgs: [habit.id],
    );
    _notifyHabits();
  }

  @override
  Future<void> archiveHabit(int habitId) async {
    await _db.database.update(
      'habits',
      {'archived': 1},
      where: 'id = ?',
      whereArgs: [habitId],
    );
    _notifyHabits();
  }

  @override
  Future<void> setActiveHabitsOrder(List<int> orderedHabitIds) async {
    await _db.database.transaction((txn) async {
      for (var i = 0; i < orderedHabitIds.length; i++) {
        final id = orderedHabitIds[i];
        final rows = await txn.query(
          'habits',
          columns: ['archived'],
          where: 'id = ?',
          whereArgs: [id],
          limit: 1,
        );
        if (rows.isEmpty) continue;
        if ((rows.single['archived'] as int) != 0) continue;
        await txn.update(
          'habits',
          {'sort_order': i},
          where: 'id = ?',
          whereArgs: [id],
        );
      }
    });
    _notifyHabits();
  }
}
