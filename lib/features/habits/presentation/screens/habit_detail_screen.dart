import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../core/time/local_day.dart';
import '../../../../di/service_locator.dart';
import '../../../notifications/data/habit_reminder_scheduler.dart';
import '../../domain/entities/habit.dart';
import '../../domain/entities/habit_day_status.dart';
import '../../domain/repositories/habit_status_repository.dart';
import '../../domain/repositories/habits_repository.dart';
import '../../domain/repositories/insurance_repository.dart';
import '../../domain/services/month_key.dart';
import '../../domain/services/streak_calculator.dart';
import '../../domain/usecases/get_habit_streaks.dart';
import '../widgets/habit_icon.dart';

class HabitDetailScreen extends StatefulWidget {
  const HabitDetailScreen({super.key, required this.habit});

  final Habit habit;

  @override
  State<HabitDetailScreen> createState() => _HabitDetailScreenState();
}

class _DetailData {
  const _DetailData({
    required this.habit,
    required this.statuses,
    required this.streak,
    required this.tokensRemaining,
  });

  final Habit habit;
  final List<HabitDayStatus> statuses;
  final StreakSummary streak;
  final int tokensRemaining;
}

class _HabitDetailScreenState extends State<HabitDetailScreen> {
  late Habit _habit = widget.habit;
  late Future<_DetailData> _future = _load();

  Future<_DetailData> _load() async {
    final habits = await sl<HabitsRepository>().getActiveHabits();
    final latest = habits.where((h) => h.id == _habit.id).toList();
    if (latest.isEmpty) {
      throw StateError('Habit not found');
    }
    _habit = latest.first;
    final statuses = await sl<HabitStatusRepository>().getStatusesForHabit(
      _habit.id,
    );
    final streak = await sl<GetHabitStreaks>()(habitId: _habit.id);
    final monthKey = MonthKey.of(DateTime.now());
    final remain = await sl<InsuranceRepository>().getRemainingTokens(
      monthKey: monthKey,
    );
    return _DetailData(
      habit: _habit,
      statuses: statuses,
      streak: streak,
      tokensRemaining: remain,
    );
  }

  String _scheduleLine(Habit habit) {
    if (!habit.reminderEnabled || habit.reminderTimeMinutes == null) {
      return HabitsStrings.scheduleNoReminder.toUpperCase();
    }
    final m = habit.reminderTimeMinutes!;
    final tod = TimeOfDay(hour: m ~/ 60, minute: m % 60);
    final text = MaterialLocalizations.of(context).formatTimeOfDay(tod);
    return '${HabitsStrings.dailyAt} $text'.toUpperCase();
  }

  Set<String> _doneDays(List<HabitDayStatus> statuses) {
    return statuses
        .where(
          (s) =>
              s.status == HabitDayCompletionStatus.done ||
              s.status == HabitDayCompletionStatus.insured,
        )
        .map((s) => s.dayKey)
        .toSet();
  }

  Set<String> _missedDays(List<HabitDayStatus> statuses) {
    return statuses
        .where((s) => s.status == HabitDayCompletionStatus.missed)
        .map((s) => s.dayKey)
        .toSet();
  }

  List<DateTime> _last28Days() {
    final end = LocalDay.todayStart();
    return List<DateTime>.generate(
      28,
      (i) => end.subtract(Duration(days: 27 - i)),
      growable: false,
    );
  }

  Future<void> _openEditor() async {
    final changed = await context.push<bool>(
      AppRoutes.habitEdit,
      extra: _habit,
    );
    if (!mounted || changed != true) return;
    setState(() => _future = _load());
  }

  Future<void> _archiveHabit() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(HabitsStrings.archiveTitle),
        content: Text(HabitsStrings.archiveBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(AppStrings.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(HabitsStrings.archiveConfirm),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await sl<HabitReminderScheduler>().cancel(_habit.id);
    await sl<HabitsRepository>().archiveHabit(_habit.id);
    if (!mounted) return;
    context.go(AppRoutes.habits);
  }

  Widget _statCard({
    required String title,
    required String value,
    Widget? trailing,
    Widget? footer,
    Color? color,
  }) {
    return Expanded(
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(48),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: GoogleFonts.manrope(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: AppColors.habitsMuted,
              ),
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -2,
                    color: title == HabitsStrings.currentStreak
                        ? AppColors.habitsPrimaryCta
                        : AppColors.habitsBodyBrown,
                    height: 1,
                  ),
                ),
                if (trailing != null) ...[const SizedBox(width: 4), trailing],
              ],
            ),
            const SizedBox(height: 10),
            footer ??
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0EEE9),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _missedMark() {
    return SizedBox(
      width: 10,
      height: 10,
      child: CustomPaint(painter: _XMarkPainter(color: const Color(0x66BA1A1A))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.habitsScreenBg,
      child: SafeArea(
        child: FutureBuilder<_DetailData>(
          future: _future,
          builder: (context, snap) {
            if (!snap.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final data = snap.data!;
            final done = _doneDays(data.statuses);
            final missed = _missedDays(data.statuses);
            final days = _last28Days();
            final used = 2 - data.tokensRemaining;
            final progress = data.streak.best > 0
                ? (data.streak.current / data.streak.best).clamp(0.0, 1.0)
                : 0.0;
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => context.go(AppRoutes.habits),
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: AppColors.habitsMuted,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          AppStrings.appName,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 32 / 1.3,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.6,
                            color: AppColors.habitsPrimaryCta,
                          ),
                        ),
                        const Spacer(),
                        const CircleAvatar(
                          radius: 19,
                          backgroundColor: AppColors.habitsCardTint,
                          child: Icon(
                            Icons.person_rounded,
                            color: AppColors.habitsMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.habitsIconWellFill,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Center(
                            child: HabitIcon(
                              iconKey: data.habit.iconKey,
                              size: 24,
                              color: AppColors.habitsTitleInk,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.habit.name,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 38 / 1.3,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.8,
                                  color: AppColors.habitsTitleInk,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _scheduleLine(data.habit),
                                style: GoogleFonts.manrope(
                                  fontSize: 26 / 1.8,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.habitsBodyBrown,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        _statCard(
                          title: HabitsStrings.currentStreak,
                          value: '${data.streak.current}',
                          trailing: Icon(
                            Icons.local_fire_department_rounded,
                            size: 18,
                            color: AppColors.habitsPrimaryCta,
                          ),
                          footer: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0EEE9),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FractionallySizedBox(
                                widthFactor: progress,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.habitsPrimaryCta,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        _statCard(
                          title: HabitsStrings.bestStreak,
                          value: '${data.streak.best}',
                          color: AppColors.habitsCardTint,
                          footer: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0x4DCCE3CF),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                HabitsStrings.personalBest,
                                style: GoogleFonts.manrope(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF516656),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.habitsCardTint,
                        borderRadius: BorderRadius.circular(48),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                HabitsStrings.activity,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.habitsTitleInk,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.todayTealDone,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                HabitsStrings.done.toUpperCase(),
                                style: GoogleFonts.manrope(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                  color: AppColors.habitsMuted,
                                ),
                              ),
                              const SizedBox(width: 10),
                              _missedMark(),
                              const SizedBox(width: 4),
                              Text(
                                HabitsStrings.missed.toUpperCase(),
                                style: GoogleFonts.manrope(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                  color: AppColors.habitsMuted,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: 'MTWTFSS'
                                .split('')
                                .map(
                                  (d) => Text(
                                    d,
                                    style: GoogleFonts.manrope(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFFD8C2BB),
                                    ),
                                  ),
                                )
                                .toList(growable: false),
                          ),
                          const SizedBox(height: 10),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: days.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                ),
                            itemBuilder: (context, i) {
                              final day = days[i];
                              final key = LocalDay.dayKey(day);
                              final isToday =
                                  LocalDay.dayKey(LocalDay.todayStart()) == key;
                              if (done.contains(key)) {
                                return Center(
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: AppColors.todayTealDone,
                                      shape: BoxShape.circle,
                                      boxShadow: isToday
                                          ? [
                                              BoxShadow(
                                                color: AppColors.todayTealDone
                                                    .withValues(alpha: 0.45),
                                                blurRadius: 8,
                                              ),
                                            ]
                                          : null,
                                    ),
                                  ),
                                );
                              }
                              if (missed.contains(key)) {
                                return Center(
                                  child: _missedMark(),
                                );
                              }
                              final inFuture = day.isAfter(
                                LocalDay.todayStart(),
                              );
                              return Center(
                                child: Container(
                                  width: inFuture ? 8 : 10,
                                  height: inFuture ? 8 : 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0x66D8C2BB),
                                      width: 1.2,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 18),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.todayInsuranceCardGrey,
                        borderRadius: BorderRadius.circular(48),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            color: AppColors.habitsBodyBrown,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  HabitsStrings.streakInsurance,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 22 / 1.4,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.habitsBodyBrown,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  HabitsStrings.insuranceBody,
                                  style: GoogleFonts.manrope(
                                    fontSize: 12,
                                    height: 1.3,
                                    color: AppColors.habitsBodyBrown.withValues(
                                      alpha: 0.7,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '$used/2',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 32 / 1.3,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.habitsBodyBrown,
                                ),
                              ),
                              Text(
                                HabitsStrings.usedThisMonth.toUpperCase(),
                                textAlign: TextAlign.right,
                                style: GoogleFonts.manrope(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                  color: AppColors.habitsMuted.withValues(
                                    alpha: 0.7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                  sliver: SliverToBoxAdapter(
                    child: SizedBox(
                      height: 52,
                      child: FilledButton.icon(
                        onPressed: _openEditor,
                        icon: Icon(Icons.edit_outlined, size: 18),
                        label: Text(HabitsStrings.editHabit),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.todayInsuranceCardGrey,
                          foregroundColor: AppColors.habitsBodyBrown,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                          textStyle: GoogleFonts.manrope(
                            fontWeight: FontWeight.w700,
                            fontSize: 18 / 1.2,
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  sliver: SliverToBoxAdapter(
                    child: TextButton.icon(
                      onPressed: _archiveHabit,
                      icon: Icon(
                        Icons.inventory_2_outlined,
                        size: 16,
                        color: AppColors.habitsArchiveInk,
                      ),
                      label: Text(
                        HabitsStrings.archiveHabit,
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.habitsArchiveInk,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _XMarkPainter extends CustomPainter {
  _XMarkPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(const Offset(1, 1), Offset(size.width - 1, size.height - 1), p);
    canvas.drawLine(Offset(size.width - 1, 1), Offset(1, size.height - 1), p);
  }

  @override
  bool shouldRepaint(covariant _XMarkPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
