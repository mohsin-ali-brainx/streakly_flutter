import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_dimens.dart';
import '../../../../core/l10n/app_strings.dart';
import '../controller/today_controller.dart';
import '../widgets/habit_editor_sheet.dart';
import '../widgets/habit_emoji_badge.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final c = TodayController();
        c.start();
        return c;
      },
      child: const _TodayView(),
    );
  }
}

class _TodayView extends StatelessWidget {
  const _TodayView();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Consumer<TodayController>(
        builder: (context, c, _) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppDimens.space2xl,
                  AppDimens.space2xl,
                  AppDimens.space2xl,
                  AppDimens.spaceSm,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TodayStrings.title,
                        style: textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: AppDimens.spaceSm),
                      Text(
                        TodayStrings.subtitle,
                        style: textTheme.bodyMedium?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (c.showInsuranceBanner)
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimens.space2xl,
                    AppDimens.space2xl,
                    AppDimens.space2xl,
                    AppDimens.spaceSm,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(AppDimens.space2xl),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.shield_outlined, color: cs.primary),
                            const SizedBox(width: AppDimens.spaceLg),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    TodayStrings.insuranceCard,
                                    style: textTheme.bodyMedium,
                                  ),
                                  if (c.insuranceState != null) ...[
                                    const SizedBox(height: AppDimens.spaceXs),
                                    Text(
                                      '${c.insuranceState!.tokensRemainingThisMonth} ${TodayStrings.tokensThisMonth}',
                                      style: textTheme.labelSmall?.copyWith(
                                        color: cs.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(width: AppDimens.spaceSm),
                            FilledButton(
                              onPressed: c.insuranceBusy
                                  ? null
                                  : () => c.applyInsurance(),
                              child: c.insuranceBusy
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(TodayStrings.useInsurance),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (c.habits.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimens.space2xl),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.event_available_outlined,
                            size: 48,
                            color: cs.onSurfaceVariant,
                          ),
                          const SizedBox(height: AppDimens.space2xl),
                          Text(
                            TodayStrings.emptyTitle,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppDimens.spaceSm),
                          Text(
                            TodayStrings.emptyBody,
                            style: textTheme.bodyMedium?.copyWith(
                              color: cs.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.space2xl,
                    vertical: AppDimens.spaceSm,
                  ),
                  sliver: SliverList.separated(
                    itemCount: c.habits.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppDimens.spaceLg),
                    itemBuilder: (context, index) {
                      final habit = c.habits[index];
                      final done = c.isDoneToday(habit.id);
                      final streak = c.streakFor(habit.id);
                      final streakText = streak != null
                          ? TodayStrings.streakLine(streak.current)
                          : TodayStrings.streakLine(0);

                      return Material(
                        key: ValueKey(habit.id),
                        color: cs.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                        clipBehavior: Clip.antiAlias,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () => HabitEditorSheet.open(
                                  context,
                                  existing: habit,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppDimens.space2xl,
                                    vertical: AppDimens.spaceXl,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: cs.surface,
                                          borderRadius: BorderRadius.circular(
                                            AppDimens.radiusSm,
                                          ),
                                          border: Border.all(
                                            color: cs.outlineVariant,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: HabitEmojiBadge(
                                          iconKey: habit.iconKey,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: AppDimens.space3xl,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              habit.name,
                                              style: textTheme.titleSmall
                                                  ?.copyWith(
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: AppDimens.spaceXs,
                                            ),
                                            Text(
                                              streakText,
                                              style: textTheme.bodySmall
                                                  ?.copyWith(
                                                color: cs.onSurfaceVariant,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: AppDimens.spaceSm,
                              ),
                              child: IconButton(
                                tooltip: TodayStrings.toggleDoneTooltip,
                                onPressed: () => c.toggleDone(habit.id),
                                icon: Icon(
                                  done
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                  color: done ? cs.primary : cs.outline,
                                  size: 28,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              const SliverToBoxAdapter(
                child: SizedBox(height: AppDimens.space4xl),
              ),
            ],
          );
        },
      ),
    );
  }
}
