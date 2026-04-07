import 'dart:async';

import '../../../../core/storage/app_database.dart';
import '../../domain/entities/habit_day_status.dart';
import '../../domain/repositories/habit_status_repository.dart';
import '../mappers/habit_day_status_mapper.dart';

class SqliteHabitStatusRepository implements HabitStatusRepository {
  SqliteHabitStatusRepository(this._db);

  final AppDatabase _db;

  final _dayChanges = StreamController<String>.broadcast();

  void _notifyDay(String dayKey) {
    if (!_dayChanges.isClosed) _dayChanges.add(dayKey);
  }

  @override
  Stream<List<HabitDayStatus>> watchStatusesForDay(String dayKey) async* {
    yield await getStatusesForDay(dayKey);
    await for (final key in _dayChanges.stream) {
      if (key == dayKey) yield await getStatusesForDay(dayKey);
    }
  }

  @override
  Future<List<HabitDayStatus>> getStatusesForDay(String dayKey) async {
    final rows = await _db.database.query(
      'habit_day_status',
      where: 'day_key = ?',
      whereArgs: [dayKey],
    );
    return rows.map(habitDayStatusFromRow).toList(growable: false);
  }

  @override
  Future<List<HabitDayStatus>> getStatusesForHabit(int habitId) async {
    final rows = await _db.database.query(
      'habit_day_status',
      where: 'habit_id = ?',
      whereArgs: [habitId],
      orderBy: 'day_key DESC',
    );
    return rows.map(habitDayStatusFromRow).toList(growable: false);
  }

  @override
  Future<void> setStatus({
    required int habitId,
    required String dayKey,
    required HabitDayCompletionStatus status,
  }) async {
    final habitIdDayKey = '$habitId|$dayKey';
    final now = DateTime.now().toIso8601String();
    final statusInt = habitCompletionStatusToInt(status);

    final existing = await _db.database.query(
      'habit_day_status',
      where: 'habit_id_day_key = ?',
      whereArgs: [habitIdDayKey],
      limit: 1,
    );

    if (existing.isEmpty) {
      await _db.database.insert('habit_day_status', {
        'habit_id': habitId,
        'day_key': dayKey,
        'status': statusInt,
        'updated_at': now,
        'habit_id_day_key': habitIdDayKey,
      });
    } else {
      await _db.database.update(
        'habit_day_status',
        {
          'status': statusInt,
          'updated_at': now,
        },
        where: 'habit_id_day_key = ?',
        whereArgs: [habitIdDayKey],
      );
    }
    _notifyDay(dayKey);
  }

  @override
  Future<void> deleteStatusForDay({
    required int habitId,
    required String dayKey,
  }) async {
    final habitIdDayKey = '$habitId|$dayKey';
    await _db.database.delete(
      'habit_day_status',
      where: 'habit_id_day_key = ?',
      whereArgs: [habitIdDayKey],
    );
    _notifyDay(dayKey);
  }
}
