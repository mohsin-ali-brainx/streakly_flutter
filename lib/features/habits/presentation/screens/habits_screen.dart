import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimens.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../di/service_locator.dart';
import '../../domain/entities/habit.dart';
import '../../domain/repositories/habits_repository.dart';
import '../widgets/habit_editor_sheet.dart';
import '../widgets/habit_emoji_badge.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final repo = sl<HabitsRepository>();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimens.space2xl,
              AppDimens.space2xl,
              AppDimens.space2xl,
              AppDimens.spaceSm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  HabitsStrings.title,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppDimens.spaceSm),
                Text(
                  HabitsStrings.subtitle,
                  style: textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppDimens.spaceXs),
                Text(
                  HabitsStrings.reorderHint,
                  style: textTheme.labelSmall?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Habit>>(
              stream: repo.watchActiveHabits(),
              builder: (context, snapshot) {
                final habits = snapshot.data ?? [];
                if (habits.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimens.space2xl),
                      child: Text(
                        HabitsStrings.empty,
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ),
                  );
                }
                return ReorderableListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimens.space2xl,
                    AppDimens.spaceSm,
                    AppDimens.space2xl,
                    AppDimens.space2xl,
                  ),
                  buildDefaultDragHandles: false,
                  itemCount: habits.length,
                  onReorder: (oldIndex, newIndex) async {
                    if (newIndex > oldIndex) newIndex--;
                    final next = List<Habit>.from(habits);
                    final item = next.removeAt(oldIndex);
                    next.insert(newIndex, item);
                    await repo.setActiveHabitsOrder(
                      next.map((e) => e.id).toList(growable: false),
                    );
                  },
                  itemBuilder: (context, i) {
                    final h = habits[i];
                    return Padding(
                      key: ValueKey(h.id),
                      padding: const EdgeInsets.only(
                        bottom: AppDimens.spaceLg,
                      ),
                      child: Material(
                        color: cs.surfaceContainerHighest,
                        borderRadius:
                            BorderRadius.circular(AppDimens.radiusMd),
                        clipBehavior: Clip.antiAlias,
                        child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.space2xl,
                          vertical: AppDimens.spaceSm,
                        ),
                        leading: ReorderableDragStartListener(
                          index: i,
                          child: Icon(
                            Icons.drag_handle_rounded,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                        title: Row(
                          children: [
                            HabitEmojiBadge(iconKey: h.iconKey),
                            const SizedBox(width: AppDimens.spaceLg),
                            Expanded(
                              child: Text(
                                h.name,
                                style: textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: h.reminderEnabled
                            ? Text(HabitsStrings.reminderOn)
                            : Text(
                                HabitsStrings.reminderOff,
                                style: textTheme.bodySmall?.copyWith(
                                  color: cs.onSurfaceVariant,
                                ),
                              ),
                        onTap: () =>
                            HabitEditorSheet.open(context, existing: h),
                      ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimens.space2xl),
            child: FilledButton.icon(
              onPressed: () => HabitEditorSheet.open(context),
              icon: const Icon(Icons.add),
              label: Text(HabitsStrings.addHabit),
            ),
          ),
        ],
      ),
    );
  }
}
