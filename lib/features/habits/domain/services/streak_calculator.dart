import '../../../../core/time/local_day.dart';
import '../entities/habit_day_status.dart';

class StreakSummary {
  const StreakSummary({
    required this.current,
    required this.best,
  });

  final int current;
  final int best;
}

class StreakCalculator {
  static bool _isEffectiveDone(HabitDayCompletionStatus s) {
    return s == HabitDayCompletionStatus.done ||
        s == HabitDayCompletionStatus.insured;
  }

  /// Computes:
  /// - current streak: consecutive effective-done days ending at `asOfDayKey`
  /// - best streak: maximum consecutive effective-done segment across history
  ///
  /// Note: `statuses` can contain missed records too; missing days are treated
  /// as breaks.
  static StreakSummary compute({
    required String asOfDayKey,
    required List<HabitDayStatus> statuses,
  }) {
    final map = <String, HabitDayCompletionStatus>{};
    for (final s in statuses) {
      map[s.dayKey] = s.status;
    }

    final asOf = LocalDay.parseDayKey(asOfDayKey);

    int current = 0;
    var cursor = asOf;
    while (true) {
      final key = LocalDay.dayKey(cursor);
      final st = map[key];
      if (st == null || !_isEffectiveDone(st)) break;
      current += 1;
      cursor = cursor.subtract(const Duration(days: 1));
    }

    // Best streak: walk over effective-done days sorted ascending by date.
    final effectiveDays = statuses
        .where((s) => _isEffectiveDone(s.status))
        .map((s) => LocalDay.parseDayKey(s.dayKey))
        .toList()
      ..sort((a, b) => a.compareTo(b));

    int best = 0;
    int run = 0;
    DateTime? prev;
    for (final d in effectiveDays) {
      if (prev == null) {
        run = 1;
      } else {
        final diff = d.difference(prev).inDays;
        run = diff == 1 ? run + 1 : 1;
      }
      if (run > best) best = run;
      prev = d;
    }

    return StreakSummary(current: current, best: best);
  }

  /// Whether insurance can be used today for a habit.
  ///
  /// Rule: insurance can only cover yesterday, and only if yesterday is NOT
  /// effective-done, and there was an active streak before yesterday.
  static bool canUseInsuranceForYesterday({
    required String todayKey,
    required List<HabitDayStatus> statuses,
  }) {
    final map = <String, HabitDayCompletionStatus>{};
    for (final s in statuses) {
      map[s.dayKey] = s.status;
    }

    final today = LocalDay.parseDayKey(todayKey);
    final y = today.subtract(const Duration(days: 1));
    final yKey = LocalDay.dayKey(y);
    final yStatus = map[yKey];

    if (yStatus != null && _isEffectiveDone(yStatus)) return false;

    // Check if there was at least a 1-day streak ending the day before yesterday.
    final before = y.subtract(const Duration(days: 1));
    final beforeKey = LocalDay.dayKey(before);
    final beforeStatus = map[beforeKey];
    if (beforeStatus == null || !_isEffectiveDone(beforeStatus)) return false;

    return true;
  }
}

