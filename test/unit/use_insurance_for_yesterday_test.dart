import 'package:flutter_test/flutter_test.dart';

import 'package:streakly_app_flutter/core/time/local_day.dart';
import 'package:streakly_app_flutter/features/habits/domain/entities/habit_day_status.dart';
import 'package:streakly_app_flutter/features/habits/domain/repositories/habit_status_repository.dart';
import 'package:streakly_app_flutter/features/habits/domain/repositories/insurance_repository.dart';
import 'package:streakly_app_flutter/features/habits/domain/services/month_key.dart';
import 'package:streakly_app_flutter/features/habits/domain/services/streak_calculator.dart';
import 'package:streakly_app_flutter/features/habits/domain/usecases/use_insurance_for_yesterday.dart';

class _FakeStatusRepo implements HabitStatusRepository {
  final Map<int, List<HabitDayStatus>> _byHabit = {};

  @override
  Stream<List<HabitDayStatus>> watchStatusesForDay(String dayKey) async* {
    yield await getStatusesForDay(dayKey);
  }

  @override
  Future<List<HabitDayStatus>> getStatusesForDay(String dayKey) async {
    final out = <HabitDayStatus>[];
    for (final list in _byHabit.values) {
      out.addAll(list.where((s) => s.dayKey == dayKey));
    }
    return out;
  }

  @override
  Future<List<HabitDayStatus>> getStatusesForHabit(int habitId) async {
    return List<HabitDayStatus>.from(_byHabit[habitId] ?? const []);
  }

  @override
  Future<void> setStatus({
    required int habitId,
    required String dayKey,
    required HabitDayCompletionStatus status,
  }) async {
    final list = _byHabit.putIfAbsent(habitId, () => []);
    list.removeWhere((s) => s.dayKey == dayKey);
    list.add(
      HabitDayStatus(
        id: list.length + 1,
        habitId: habitId,
        dayKey: dayKey,
        status: status,
        updatedAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> deleteStatusForDay({required int habitId, required String dayKey}) async {
    _byHabit[habitId]?.removeWhere((s) => s.dayKey == dayKey);
  }
}

class _FakeInsuranceRepo implements InsuranceRepository {
  final Map<String, int> _used = {};

  @override
  Future<int> getRemainingTokens({required String monthKey}) async {
    const limit = 2;
    final u = _used[monthKey] ?? 0;
    final r = limit - u;
    return r < 0 ? 0 : r;
  }

  @override
  Future<void> consumeToken({required String monthKey}) async {
    _used[monthKey] = (_used[monthKey] ?? 0) + 1;
  }

  @override
  Future<int> getTotalTokensConsumed() async {
    var n = 0;
    for (final v in _used.values) n += v;
    return n;
  }
}

void main() {
  test('UseInsuranceForYesterday consumes token and marks yesterday insured', () async {
    final statusRepo = _FakeStatusRepo();
    final insuranceRepo = _FakeInsuranceRepo();
    final usecase = UseInsuranceForYesterday(statusRepo, insuranceRepo);

    final now = DateTime.now();
    final today = LocalDay.startOfDay(now);
    final todayKey = LocalDay.dayKey(today);
    final yesterdayKey = LocalDay.dayKey(today.subtract(const Duration(days: 1)));
    final beforeKey = LocalDay.dayKey(today.subtract(const Duration(days: 2)));

    await statusRepo.setStatus(
      habitId: 1,
      dayKey: beforeKey,
      status: HabitDayCompletionStatus.done,
    );
    await statusRepo.setStatus(
      habitId: 1,
      dayKey: yesterdayKey,
      status: HabitDayCompletionStatus.missed,
    );

    final ok = await usecase.call(habitId: 1, now: now);
    expect(ok, true);

    final monthKey = MonthKey.of(now);
    final remaining = await insuranceRepo.getRemainingTokens(monthKey: monthKey);
    expect(remaining, 1);

    final statuses = await statusRepo.getStatusesForHabit(1);
    final y = statuses.where((s) => s.dayKey == yesterdayKey).single;
    expect(y.status, HabitDayCompletionStatus.insured);

    final eligible = ok && StreakCalculator.canUseInsuranceForYesterday(
      todayKey: todayKey,
      statuses: statuses,
    );
    expect(eligible, false);
  });
}

