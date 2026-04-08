import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../di/service_locator.dart';
import '../../../habits/domain/entities/habit.dart';
import '../../../habits/domain/repositories/habits_repository.dart';
import '../../../notifications/data/habit_reminder_scheduler.dart';
import '../../../notifications/domain/notifications_permission_service.dart';

class NotificationsSettingsScreen extends StatelessWidget {
  const NotificationsSettingsScreen({super.key});

  Future<void> _updateHabit(
    BuildContext context, {
    required Habit habit,
    required bool reminderEnabled,
    required int? reminderTimeMinutes,
  }) async {
    final next = Habit(
      id: habit.id,
      name: habit.name,
      iconKey: habit.iconKey,
      createdAt: habit.createdAt,
      sortOrder: habit.sortOrder,
      reminderEnabled: reminderEnabled,
      reminderTimeMinutes: reminderEnabled ? reminderTimeMinutes : null,
      archived: habit.archived,
    );

    await sl<HabitsRepository>().updateHabit(next);
    try {
      await sl<HabitReminderScheduler>().syncFromHabit(next);
    } catch (_) {}
  }

  Future<void> _toggleReminder(BuildContext context, Habit habit, bool on) async {
    if (on) {
      final granted = await sl<NotificationsPermissionService>()
          .requestPermission();
      if (!context.mounted) return;
      if (!granted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(NotificationsStrings.deniedBody)),
        );
        await _updateHabit(
          context,
          habit: habit,
          reminderEnabled: false,
          reminderTimeMinutes: habit.reminderTimeMinutes,
        );
        return;
      }
    }

    if (!context.mounted) return;
    final minutes = habit.reminderTimeMinutes ?? (8 * 60);
    await _updateHabit(
      context,
      habit: habit,
      reminderEnabled: on,
      reminderTimeMinutes: minutes,
    );
  }

  Future<void> _pickTime(BuildContext context, Habit habit) async {
    final mins = habit.reminderTimeMinutes ?? (8 * 60);
    final initial = TimeOfDay(hour: mins ~/ 60, minute: mins % 60);
    final picked = await showTimePicker(context: context, initialTime: initial);
    if (!context.mounted) return;
    if (picked == null) return;
    final nextMins = picked.hour * 60 + picked.minute;

    await _updateHabit(
      context,
      habit: habit,
      reminderEnabled: true,
      reminderTimeMinutes: nextMins,
    );
  }

  String _timeLabel(BuildContext context, Habit habit) {
    if (!habit.reminderEnabled || habit.reminderTimeMinutes == null) {
      return HabitsStrings.scheduleNoReminder;
    }
    final m = habit.reminderTimeMinutes!;
    final tod = TimeOfDay(hour: m ~/ 60, minute: m % 60);
    return MaterialLocalizations.of(context).formatTimeOfDay(tod);
  }

  @override
  Widget build(BuildContext context) {
    final repo = sl<HabitsRepository>();
    return Scaffold(
      backgroundColor: AppColors.habitsScreenBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.space2xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(Icons.chevron_left_rounded, color: AppColors.habitsMuted),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      SettingsStrings.notificationsTitle,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.habitsTitleInk,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                SettingsStrings.notificationsSubtitle,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                  color: AppColors.habitsBodyBrown,
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: StreamBuilder<List<Habit>>(
                  stream: repo.watchActiveHabits(),
                  builder: (context, snap) {
                    final habits = snap.data ?? const <Habit>[];
                    if (habits.isEmpty) {
                      return Center(
                        child: Text(
                          HabitsStrings.empty,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            color: AppColors.habitsMuted,
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      itemCount: habits.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, i) {
                        final h = habits[i];
                        final enabled = h.reminderEnabled;
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x1485736D),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      h.name,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.habitsTitleInk,
                                      ),
                                    ),
                                  ),
                                  Switch.adaptive(
                                    value: enabled,
                                    activeColor: AppColors.todayTealDone,
                                    activeTrackColor: AppColors.todayTealDone
                                        .withValues(alpha: 0.35),
                                    onChanged: (v) => _toggleReminder(
                                      context,
                                      h,
                                      v,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              InkWell(
                                borderRadius: BorderRadius.circular(14),
                                onTap: enabled ? () => _pickTime(context, h) : null,
                                child: Ink(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: enabled
                                        ? AppColors.habitsCardTint
                                        : AppColors.habitsCardTint.withValues(
                                            alpha: 0.55,
                                          ),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.schedule_rounded,
                                        size: 18,
                                        color: enabled
                                            ? AppColors.habitsBodyBrown
                                            : AppColors.habitsMuted,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        _timeLabel(context, h),
                                        style: GoogleFonts.manrope(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: enabled
                                              ? AppColors.habitsTitleInk
                                              : AppColors.habitsMuted,
                                        ),
                                      ),
                                      const Spacer(),
                                      if (enabled)
                                        Icon(
                                          Icons.chevron_right_rounded,
                                          color: AppColors.habitsMuted
                                              .withValues(alpha: 0.55),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

