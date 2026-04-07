import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimens.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../core/time/local_day.dart';
import '../../../../di/service_locator.dart';
import '../../../habits/domain/entities/habit.dart';
import '../../../habits/domain/entities/habit_day_status.dart';
import '../../../habits/domain/repositories/habit_status_repository.dart';
import '../../../habits/domain/repositories/habits_repository.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final habitsRepo = sl<HabitsRepository>();
    final statusRepo = sl<HabitStatusRepository>();
    final todayKey = LocalDay.dayKey(LocalDay.todayStart());

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.space2xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StatsStrings.title,
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppDimens.spaceSm),
            Text(
              StatsStrings.subtitle,
              style: textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: AppDimens.space3xl),
            StreamBuilder<List<Habit>>(
              stream: habitsRepo.watchActiveHabits(),
              builder: (context, habitsSnap) {
                final habits = habitsSnap.data ?? [];
                return StreamBuilder<List<HabitDayStatus>>(
                  stream: statusRepo.watchStatusesForDay(todayKey),
                  builder: (context, statusSnap) {
                    final statuses = statusSnap.data ?? [];
                    final doneCount = statuses
                        .where((s) => s.status == HabitDayCompletionStatus.done)
                        .length;

                    return Row(
                      children: [
                        Expanded(
                          child: _StatTile(
                            label: StatsStrings.activeHabits,
                            value: '${habits.length}',
                          ),
                        ),
                        const SizedBox(width: AppDimens.spaceLg),
                        Expanded(
                          child: _StatTile(
                            label: StatsStrings.doneToday,
                            value: '$doneCount',
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: AppDimens.space3xl),
            Text(
              StatsStrings.placeholder,
              style: textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.space2xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppDimens.spaceXs),
            Text(
              label,
              style: textTheme.labelMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
