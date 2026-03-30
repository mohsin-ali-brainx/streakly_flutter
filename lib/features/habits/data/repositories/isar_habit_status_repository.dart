import 'package:isar/isar.dart';

import '../../../../core/storage/isar_db.dart';
import '../../domain/entities/habit_day_status.dart';
import '../../domain/repositories/habit_status_repository.dart';
import '../isar/isar_habit_day_status.dart';
import '../mappers/habit_day_status_mapper.dart';

class IsarHabitStatusRepository implements HabitStatusRepository {
  IsarHabitStatusRepository(this._db);

  final IsarDb _db;

  Isar get _isar => _db.isar;

  @override
  Stream<List<HabitDayStatus>> watchStatusesForDay(String dayKey) {
    return _isar.isarHabitDayStatus
        .filter()
        .dayKeyEqualTo(dayKey)
        .watch(fireImmediately: true)
        .map((items) => items.map((e) => e.toDomain()).toList(growable: false));
  }

  @override
  Future<List<HabitDayStatus>> getStatusesForDay(String dayKey) async {
    final items =
        await _isar.isarHabitDayStatus.filter().dayKeyEqualTo(dayKey).findAll();
    return items.map((e) => e.toDomain()).toList(growable: false);
  }

  @override
  Future<List<HabitDayStatus>> getStatusesForHabit(int habitId) async {
    final items = await _isar.isarHabitDayStatus
        .filter()
        .habitIdEqualTo(habitId)
        .sortByDayKeyDesc()
        .findAll();
    return items.map((e) => e.toDomain()).toList(growable: false);
  }

  @override
  Future<void> setStatus({
    required int habitId,
    required String dayKey,
    required HabitDayCompletionStatus status,
  }) async {
    final key = '$habitId|$dayKey';
    await _isar.writeTxn(() async {
      final existing = await _isar.isarHabitDayStatus
          .filter()
          .habitIdDayKeyEqualTo(key)
          .findFirst();

      final now = DateTime.now();
      if (existing == null) {
        final s = IsarHabitDayStatus()
          ..habitId = habitId
          ..dayKey = dayKey
          ..status = switch (status) {
            HabitDayCompletionStatus.done => IsarHabitDayCompletionStatus.done,
            HabitDayCompletionStatus.missed =>
              IsarHabitDayCompletionStatus.missed,
            HabitDayCompletionStatus.insured =>
              IsarHabitDayCompletionStatus.insured,
          }
          ..updatedAt = now
          ..habitIdDayKey = key;

        await _isar.isarHabitDayStatus.put(s);
        return;
      }

      existing.status = switch (status) {
        HabitDayCompletionStatus.done => IsarHabitDayCompletionStatus.done,
        HabitDayCompletionStatus.missed => IsarHabitDayCompletionStatus.missed,
        HabitDayCompletionStatus.insured =>
          IsarHabitDayCompletionStatus.insured,
      };
      existing.updatedAt = now;
      await _isar.isarHabitDayStatus.put(existing);
    });
  }
}

