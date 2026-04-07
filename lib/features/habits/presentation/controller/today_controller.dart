import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../core/time/local_day.dart';
import '../../../../di/service_locator.dart';
import '../../domain/entities/habit.dart';
import '../../domain/entities/habit_day_status.dart';
import '../../domain/repositories/habit_status_repository.dart';
import '../../domain/repositories/habits_repository.dart';
import '../../domain/services/streak_calculator.dart';
import '../../domain/usecases/get_habit_streaks.dart';
import '../../domain/usecases/get_insurance_state_for_habit.dart';
import '../../domain/usecases/use_insurance_for_yesterday.dart';

class TodayController extends ChangeNotifier {
  TodayController({
    HabitsRepository? habitsRepository,
    HabitStatusRepository? habitStatusRepository,
    GetHabitStreaks? getHabitStreaks,
    GetInsuranceStateForHabit? getInsuranceStateForHabit,
    UseInsuranceForYesterday? useInsuranceForYesterday,
  }) : _habitsRepository = habitsRepository ?? sl<HabitsRepository>(),
       _statusRepository = habitStatusRepository ?? sl<HabitStatusRepository>(),
       _getHabitStreaks = getHabitStreaks ?? sl<GetHabitStreaks>(),
       _getInsuranceState =
           getInsuranceStateForHabit ?? sl<GetInsuranceStateForHabit>(),
       _useInsurance =
           useInsuranceForYesterday ?? sl<UseInsuranceForYesterday>();

  final HabitsRepository _habitsRepository;
  final HabitStatusRepository _statusRepository;
  final GetHabitStreaks _getHabitStreaks;
  final GetInsuranceStateForHabit _getInsuranceState;
  final UseInsuranceForYesterday _useInsurance;

  final String _todayKey = LocalDay.dayKey(LocalDay.todayStart());

  StreamSubscription<List<Habit>>? _habitsSub;
  StreamSubscription<List<HabitDayStatus>>? _statusSub;

  List<Habit> _habits = [];
  List<HabitDayStatus> _todayStatuses = [];
  Map<int, StreakSummary> _streaks = {};
  int? _insuranceHabitId;
  InsuranceState? _insuranceState;
  bool _insuranceBusy = false;

  List<Habit> get habits => _habits;
  bool get insuranceBusy => _insuranceBusy;

  InsuranceState? get insuranceState => _insuranceState;
  int? get insuranceHabitId => _insuranceHabitId;

  bool get showInsuranceBanner =>
      _insuranceHabitId != null &&
      (_insuranceState?.eligibleForYesterday ?? false);

  HabitDayStatus? statusForHabit(int habitId) {
    for (final s in _todayStatuses) {
      if (s.habitId == habitId) return s;
    }
    return null;
  }

  bool isDoneToday(int habitId) {
    final s = statusForHabit(habitId)?.status;
    return s == HabitDayCompletionStatus.done;
  }

  StreakSummary? streakFor(int habitId) => _streaks[habitId];

  void start() {
    _habitsSub = _habitsRepository.watchActiveHabits().listen((list) {
      _habits = list;
      notifyListeners();
      unawaited(_refreshStreaksAndInsurance());
    });
    _statusSub = _statusRepository.watchStatusesForDay(_todayKey).listen((
      list,
    ) {
      _todayStatuses = list;
      notifyListeners();
      unawaited(_refreshStreaksAndInsurance());
    });
  }

  Future<void> _refreshStreaksAndInsurance() async {
    final streaks = <int, StreakSummary>{};
    for (final h in _habits) {
      streaks[h.id] = await _getHabitStreaks(habitId: h.id);
    }
    _streaks = streaks;

    int? targetId;
    InsuranceState? state;
    for (final h in _habits) {
      final ins = await _getInsuranceState(habitId: h.id);
      if (ins.eligibleForYesterday) {
        targetId = h.id;
        state = ins;
        break;
      }
    }
    _insuranceHabitId = targetId;
    _insuranceState = state;
    notifyListeners();
  }

  Future<void> toggleDone(int habitId) async {
    if (isDoneToday(habitId)) {
      await _statusRepository.deleteStatusForDay(
        habitId: habitId,
        dayKey: _todayKey,
      );
    } else {
      await _statusRepository.setStatus(
        habitId: habitId,
        dayKey: _todayKey,
        status: HabitDayCompletionStatus.done,
      );
    }
  }

  Future<void> applyInsurance() async {
    final id = _insuranceHabitId;
    if (id == null || _insuranceBusy) return;
    _insuranceBusy = true;
    notifyListeners();
    try {
      await _useInsurance(habitId: id);
    } finally {
      _insuranceBusy = false;
      await _refreshStreaksAndInsurance();
    }
  }

  @override
  void dispose() {
    _habitsSub?.cancel();
    _statusSub?.cancel();
    super.dispose();
  }
}
