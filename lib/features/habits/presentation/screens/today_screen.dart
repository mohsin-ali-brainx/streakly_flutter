import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../domain/entities/habit.dart';
import '../controller/today_controller.dart';
import '../widgets/today_dashboard_habit_tile.dart';
import '../widgets/today_dashboard_header.dart';
import '../widgets/today_insight_card.dart';
import '../widgets/today_insurance_card.dart';
import '../widgets/today_progress_card.dart';
import 'streak_recovery_screen.dart';

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
      child: const _TodayScaffold(),
    );
  }
}

class _TodayScaffold extends StatelessWidget {
  const _TodayScaffold();

  static String _dateLine() {
    return DateFormat('EEEE, MMM d').format(DateTime.now()).toUpperCase();
  }

  Future<void> _openRecovery(
    BuildContext context,
    TodayController c,
  ) async {
    final targetId = c.insuranceHabitId;
    final state = c.insuranceState;
    if (targetId == null || state == null) return;
    Habit? target;
    for (final h in c.habits) {
      if (h.id == targetId) {
        target = h;
        break;
      }
    }
    if (target == null) return;
    final confirmed = await context.push<bool>(
      AppRoutes.streakRecovery,
      extra: StreakRecoveryArgs(
        habitName: target.name,
        streakAtRisk: c.insuranceStreakDays ?? 0,
        tokensRemaining: state.tokensRemainingThisMonth,
      ),
    );
    if (confirmed == true) {
      final ok = await c.applyInsurance();
      if (!context.mounted) return;
      if (!ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(TodayStrings.recoveryFailed)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false,
      backgroundColor: AppColors.todayScreenBg,
      drawer: Drawer(
        backgroundColor: AppColors.habitsScreenBg,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
                decoration: const BoxDecoration(
                  color: AppColors.habitsCardTint,
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    AppStrings.appName,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ctaBrown,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: Text(
                  SettingsStrings.title,
                  style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  context.go(AppRoutes.settings);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.habitNew),
        backgroundColor: AppColors.habitsPrimaryCta,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 28),
      ),
      body: SafeArea(
        bottom: false,
        child: Consumer<TodayController>(
          builder: (context, c, _) {
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: TodayDashboardHeader()),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimens.pagePaddingHLoose,
                    0,
                    AppDimens.pagePaddingHLoose,
                    8,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _dateLine(),
                          style: GoogleFonts.manrope(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.9,
                            height: 1.35,
                            color: AppColors.habitsMuted,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${TodayStrings.greetingTimePrefix()}, ${TodayStrings.greetingName}',
                          style: GoogleFonts.fraunces(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            height: 1.15,
                            color: AppColors.habitsTitleInk,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimens.pagePaddingHLoose,
                    8,
                    AppDimens.pagePaddingHLoose,
                    12,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: TodayProgressCard(
                      done: c.completedTodayCount,
                      total: c.habitCount,
                    ),
                  ),
                ),
                if (c.showInsuranceBanner && c.insuranceState != null)
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimens.pagePaddingHLoose,
                      0,
                       AppDimens.pagePaddingHLoose,
                      12,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: TodayInsuranceCard(
                        state: c.insuranceState!,
                        streakDays: c.insuranceStreakDays ?? 0,
                        busy: c.insuranceBusy,
                        onUse: () => _openRecovery(context, c),
                      ),
                    ),
                  ),
                if (c.habitCount > 0)
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimens.pagePaddingHLoose,
                      4,
                      AppDimens.pagePaddingHLoose,
                      16,
                    ),
                    sliver: const SliverToBoxAdapter(child: TodayInsightCard()),
                  ),
                if (c.habits.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 24, 32, 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 88,
                            height: 88,
                            decoration: BoxDecoration(
                              color: AppColors.habitsCardTint,
                              borderRadius: BorderRadius.circular(44),
                            ),
                            child: Icon(
                              Icons.event_available_rounded,
                              size: 40,
                              color: AppColors.habitsMuted.withValues(
                                alpha: 0.7,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            TodayStrings.emptyTitle,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppColors.habitsTitleInk,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            TodayStrings.emptyBody,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.manrope(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                              color: AppColors.habitsMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else ...[
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimens.pagePaddingHLoose,
                      0,
                      AppDimens.pagePaddingHLoose,
                      12,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            TodayStrings.sectionHabits.toUpperCase(),
                            style: GoogleFonts.manrope(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.9,
                              color: AppColors.habitsMuted,
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.go(AppRoutes.habits),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              foregroundColor: AppColors.habitsPrimaryCta,
                            ),
                            child: Text(
                              TodayStrings.manageLink,
                              style: GoogleFonts.manrope(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimens.pagePaddingHLoose,
                      0,
                      AppDimens.pagePaddingHLoose,
                      100,
                    ),
                    sliver: SliverList.separated(
                      itemCount: c.habits.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final habit = c.habits[index];
                        final done = c.isDoneToday(habit.id);
                        final streak = c.streakFor(habit.id)?.current ?? 0;

                        return TodayDashboardHabitTile(
                          key: ValueKey(habit.id),
                          habit: habit,
                          done: done,
                          streakDays: streak,
                          onEdit: () =>
                              context.push(AppRoutes.habitEdit, extra: habit),
                          onToggleDone: () => c.toggleDone(habit.id),
                        );
                      },
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
