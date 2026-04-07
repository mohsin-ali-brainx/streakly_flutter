import '../../../../core/time/local_day.dart';
import '../repositories/habit_status_repository.dart';
import '../services/streak_calculator.dart';

class GetHabitStreaks {
  GetHabitStreaks(this._statusRepo);

  final HabitStatusRepository _statusRepo;

  Future<StreakSummary> call({required int habitId, DateTime? asOf}) async {
    final asOfKey = LocalDay.dayKey(
      LocalDay.startOfDay(asOf ?? DateTime.now()),
    );
    final statuses = await _statusRepo.getStatusesForHabit(habitId);
    return StreakCalculator.compute(asOfDayKey: asOfKey, statuses: statuses);
  }
}
