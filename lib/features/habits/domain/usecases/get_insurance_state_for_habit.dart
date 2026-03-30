import '../../../../core/time/local_day.dart';
import '../repositories/habit_status_repository.dart';
import '../repositories/insurance_repository.dart';
import '../services/month_key.dart';
import '../services/streak_calculator.dart';

class InsuranceState {
  const InsuranceState({
    required this.eligibleForYesterday,
    required this.tokensRemainingThisMonth,
  });

  final bool eligibleForYesterday;
  final int tokensRemainingThisMonth;
}

class GetInsuranceStateForHabit {
  GetInsuranceStateForHabit(this._statusRepo, this._insuranceRepo);

  final HabitStatusRepository _statusRepo;
  final InsuranceRepository _insuranceRepo;

  Future<InsuranceState> call({required int habitId, DateTime? now}) async {
    final localNow = (now ?? DateTime.now()).toLocal();
    final todayKey = LocalDay.dayKey(LocalDay.startOfDay(localNow));
    final monthKey = MonthKey.of(localNow);

    final statuses = await _statusRepo.getStatusesForHabit(habitId);
    final eligible =
        StreakCalculator.canUseInsuranceForYesterday(todayKey: todayKey, statuses: statuses);
    final remaining = await _insuranceRepo.getRemainingTokens(monthKey: monthKey);

    return InsuranceState(
      eligibleForYesterday: eligible && remaining > 0,
      tokensRemainingThisMonth: remaining,
    );
  }
}

