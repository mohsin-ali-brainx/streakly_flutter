import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../core/time/local_day.dart';
import '../../../../di/service_locator.dart';
import '../../../habits/domain/entities/habit.dart';
import '../../../habits/domain/entities/habit_day_status.dart';
import '../../../habits/domain/repositories/habit_status_repository.dart';
import '../../../habits/domain/repositories/habits_repository.dart';
import '../../../habits/domain/repositories/insurance_repository.dart';
import '../../../habits/domain/usecases/get_habit_streaks.dart';

class StatsDiversityRow {
  const StatsDiversityRow({
    required this.title,
    required this.monthCompletions,
    required this.accentColor,
  });

  final String title;
  final int monthCompletions;
  final Color accentColor;
}

class StatsSummary {
  const StatsSummary({
    required this.totalCheckIns,
    required this.longestStreakDays,
    required this.streaksPreserved,
    required this.weekStartMonday,
    required this.weekEndSunday,
    required this.weekDayTotals,
    required this.diversityRows,
    required this.consistencyPercent,
  });

  final int totalCheckIns;
  final int longestStreakDays;
  final int streaksPreserved;
  final DateTime weekStartMonday;
  final DateTime weekEndSunday;
  final List<int> weekDayTotals;
  final List<StatsDiversityRow> diversityRows;
  final int consistencyPercent;
}

class StatsController extends ChangeNotifier {
  StatsController({
    HabitsRepository? habitsRepository,
    HabitStatusRepository? statusRepository,
    InsuranceRepository? insuranceRepository,
    GetHabitStreaks? getHabitStreaks,
  }) : _habitsRepository = habitsRepository ?? sl<HabitsRepository>(),
       _statusRepository = statusRepository ?? sl<HabitStatusRepository>(),
       _insuranceRepository = insuranceRepository ?? sl<InsuranceRepository>(),
       _getHabitStreaks = getHabitStreaks ?? sl<GetHabitStreaks>();

  final HabitsRepository _habitsRepository;
  final HabitStatusRepository _statusRepository;
  final InsuranceRepository _insuranceRepository;
  final GetHabitStreaks _getHabitStreaks;

  StreamSubscription<List<Habit>>? _habitsSub;
  StreamSubscription<List<HabitDayStatus>>? _todaySub;
  StreamSubscription<List<HabitDayStatus>>? _yesterdaySub;

  StatsSummary? _summary;
  StatsSummary? get summary => _summary;

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  Timer? _debounce;

  Future<void> start() async {
    final today = LocalDay.todayStart();
    final todayKey = LocalDay.dayKey(today);
    final yesterdayKey = LocalDay.dayKey(
      today.subtract(const Duration(days: 1)),
    );

    _habitsSub = _habitsRepository.watchActiveHabits().listen((_) {
      _scheduleRefresh();
    });
    _todaySub = _statusRepository.watchStatusesForDay(todayKey).listen((_) {
      _scheduleRefresh();
    });
    _yesterdaySub = _statusRepository.watchStatusesForDay(yesterdayKey).listen((
      _,
    ) {
      _scheduleRefresh();
    });

    await refresh();
  }

  void _scheduleRefresh() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 120), () {
      unawaited(_refreshCore());
    });
  }

  bool _isEffectiveDone(HabitDayCompletionStatus s) {
    return s == HabitDayCompletionStatus.done ||
        s == HabitDayCompletionStatus.insured;
  }

  DateTime _mondayOfWeek(DateTime d) {
    final x = DateTime(d.year, d.month, d.day);
    return x.subtract(Duration(days: x.weekday - DateTime.monday));
  }

  Future<List<int>> _weekDayTotals(
    List<Habit> habits,
    DateTime monday,
  ) async {
    final totals = List<int>.filled(7, 0);
    final activeIds = habits.map((e) => e.id).toSet();
    for (var i = 0; i < 7; i++) {
      final d = monday.add(Duration(days: i));
      final key = LocalDay.dayKey(d);
      final list = await _statusRepository.getStatusesForDay(key);
      for (final s in list) {
        if (!activeIds.contains(s.habitId)) continue;
        if (_isEffectiveDone(s.status)) totals[i]++;
      }
    }
    return totals;
  }

  Future<int> _totalCheckInsAllTime(List<Habit> habits) async {
    var n = 0;
    for (final h in habits) {
      final st = await _statusRepository.getStatusesForHabit(h.id);
      for (final s in st) {
        if (_isEffectiveDone(s.status)) n++;
      }
    }
    return n;
  }

  String _diversityTitle(Habit h) {
    switch (h.iconKey) {
      case 'meditate':
      case 'journal':
      case 'moon':
      case 'luna':
        return 'Mindfulness';
      case 'walk':
      case 'water':
      case 'runner':
      case 'dumbbell':
      case 'leaf':
      case 'sun':
        return 'Physical Health';
      case 'read':
      case 'book':
        return 'Learning';
      case 'brain':
      case 'palette':
        return 'Growth';
      default:
        return h.name;
    }
  }

  Future<List<StatsDiversityRow>> _diversityRows(
    List<Habit> habits,
    DateTime start30,
    DateTime end,
  ) async {
    final scored = <({Habit h, int n})>[];
    for (final h in habits) {
      final st = await _statusRepository.getStatusesForHabit(h.id);
      var c = 0;
      for (final s in st) {
        if (!_isEffectiveDone(s.status)) continue;
        final d = LocalDay.parseDayKey(s.dayKey);
        if (d.isBefore(start30) || d.isAfter(end)) continue;
        c++;
      }
      scored.add((h: h, n: c));
    }
    scored.sort((a, b) => b.n.compareTo(a.n));
    final top = scored.take(2).toList();
    const colors = <Color>[
      Color(0xFF1A6660),
      Color(0xFF874C36),
    ];
    final rows = <StatsDiversityRow>[];
    for (var i = 0; i < top.length; i++) {
      final e = top[i];
      rows.add(
        StatsDiversityRow(
          title: _diversityTitle(e.h),
          monthCompletions: e.n,
          accentColor: colors[i % colors.length],
        ),
      );
    }
    while (rows.length < 2) {
      rows.add(
        StatsDiversityRow(
          title: '—',
          monthCompletions: 0,
          accentColor: AppColors.habitsMuted.withValues(alpha: 0.35),
        ),
      );
    }
    return rows;
  }

  Future<void> refresh() async {
    _debounce?.cancel();
    await _refreshCore();
  }

  Future<void> _refreshCore() async {
    final firstLoad = _summary == null;
    if (firstLoad) {
      _loading = true;
      _error = null;
      notifyListeners();
    }
    try {
      final habits = await _habitsRepository.getActiveHabits();
      final today = LocalDay.todayStart();
      final monday = _mondayOfWeek(today);
      final sunday = monday.add(const Duration(days: 6));

      final start7 = today.subtract(const Duration(days: 6));
      final start30 = today.subtract(const Duration(days: 29));

      var done7d = 0;
      for (final h in habits) {
        final st = await _statusRepository.getStatusesForHabit(h.id);
        for (final s in st) {
          if (!_isEffectiveDone(s.status)) continue;
          final d = LocalDay.parseDayKey(s.dayKey);
          if (d.isBefore(start7) || d.isAfter(today)) continue;
          done7d++;
        }
      }

      var bestStreak = 0;
      for (final h in habits) {
        final streak = await _getHabitStreaks(habitId: h.id);
        if (streak.best > bestStreak) bestStreak = streak.best;
      }

      final totalCheckIns = await _totalCheckInsAllTime(habits);
      final preserved = await _insuranceRepository.getTotalTokensConsumed();
      final weekTotals = await _weekDayTotals(habits, monday);
      final diversity = await _diversityRows(habits, start30, today);

      final maxSlots = habits.length * 7;
      final consistencyPercent = maxSlots <= 0
          ? 0
          : (done7d * 100 / maxSlots).clamp(0, 100).round();

      _summary = StatsSummary(
        totalCheckIns: totalCheckIns,
        longestStreakDays: bestStreak,
        streaksPreserved: preserved,
        weekStartMonday: monday,
        weekEndSunday: sunday,
        weekDayTotals: weekTotals,
        diversityRows: diversity,
        consistencyPercent: consistencyPercent,
      );
      _error = null;
    } catch (_) {
      if (_summary == null) {
        _error = StatsStrings.loadFailed;
      }
    } finally {
      if (firstLoad) _loading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _habitsSub?.cancel();
    _todaySub?.cancel();
    _yesterdaySub?.cancel();
    super.dispose();
  }
}
