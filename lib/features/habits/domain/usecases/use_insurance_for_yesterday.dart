import '../../../../core/time/local_day.dart';
import '../entities/habit_day_status.dart';
import '../repositories/habit_status_repository.dart';
import '../repositories/insurance_repository.dart';
import '../services/month_key.dart';
import '../services/streak_calculator.dart';

class UseInsuranceForYesterday {
  UseInsuranceForYesterday(this._statusRepo, this._insuranceRepo);

  final HabitStatusRepository _statusRepo;
  final InsuranceRepository _insuranceRepo;

  Future<bool> call({required int habitId, DateTime? now}) async {
    final localNow = (now ?? DateTime.now()).toLocal();
    final today = LocalDay.startOfDay(localNow);
    final todayKey = LocalDay.dayKey(today);
    final monthKey = MonthKey.of(localNow);

    final remaining = await _insuranceRepo.getRemainingTokens(monthKey: monthKey);
    if (remaining <= 0) return false;

    final statuses = await _statusRepo.getStatusesForHabit(habitId);
    final eligible = StreakCalculator.canUseInsuranceForYesterday(
      todayKey: todayKey,
      statuses: statuses,
    );
    if (!eligible) return false;

    final yesterdayKey = LocalDay.dayKey(today.subtract(const Duration(days: 1)));

    await _insuranceRepo.consumeToken(monthKey: monthKey);
    await _statusRepo.setStatus(
      habitId: habitId,
      dayKey: yesterdayKey,
      status: HabitDayCompletionStatus.insured,
    );
    return true;
  }
}

