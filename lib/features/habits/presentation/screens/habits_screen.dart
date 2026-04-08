import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../di/service_locator.dart';
import '../../domain/entities/habit.dart';
import '../../domain/repositories/habits_repository.dart';
import '../widgets/habit_list_card.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = sl<HabitsRepository>();

    return ColoredBox(
      color: AppColors.habitsScreenBg,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimens.pagePaddingHLoose,
                20,
                AppDimens.pagePaddingHLoose,
                8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    HabitsStrings.title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                      letterSpacing: -0.6,
                      color: AppColors.habitsTitleInk,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    HabitsStrings.subtitle,
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 1.45,
                      color: AppColors.habitsBodyBrown,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    HabitsStrings.reorderHint,
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.35,
                      color: AppColors.habitsMuted,
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
                        padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: AppColors.habitsCardTint,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Icon(
                                Icons.auto_awesome_rounded,
                                size: 36,
                                color: AppColors.habitsMuted.withValues(
                                  alpha: 0.75,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              HabitsStrings.empty,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.manrope(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.habitsMuted,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return ReorderableListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimens.pagePaddingHLoose,
                      12,
                      AppDimens.pagePaddingHLoose,
                      8,
                    ),
                    buildDefaultDragHandles: false,
                    proxyDecorator: (child, index, animation) {
                      return AnimatedBuilder(
                        animation: animation,
                        builder: (context, _) {
                          final t = Curves.easeInOut.transform(animation.value);
                          return Transform.scale(
                            scale: 1.0 + 0.02 * t,
                            child: Opacity(
                              opacity: 0.92 - 0.08 * t,
                              child: child,
                            ),
                          );
                        },
                      );
                    },
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
                        padding: const EdgeInsets.only(bottom: 14),
                        child: HabitListCard(
                          habit: h,
                          listIndex: i,
                          onTap: () =>
                              context.push(AppRoutes.habitDetail, extra: h),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimens.pagePaddingHLoose,
                8,
                AppDimens.pagePaddingHLoose,
                16,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () => context.push(AppRoutes.habitNew),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.habitsPrimaryCta,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    textStyle: GoogleFonts.manrope(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_rounded, size: 22),
                      const SizedBox(width: 10),
                      Text(HabitsStrings.addHabit),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
