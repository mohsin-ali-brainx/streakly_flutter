import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../domain/entities/habit.dart';
import 'habit_icon.dart';

String habitScheduleCaption(BuildContext context, Habit habit) {
  if (!habit.reminderEnabled || habit.reminderTimeMinutes == null) {
    return HabitsStrings.scheduleNoReminder.toUpperCase();
  }
  final mins = habit.reminderTimeMinutes!;
  final tod = TimeOfDay(hour: mins ~/ 60, minute: mins % 60);
  final formatted = MaterialLocalizations.of(context).formatTimeOfDay(tod);
  return '${HabitsStrings.dailyAt} $formatted'.toUpperCase();
}

/// Figma-style list row: white card, icon well, Jakarta title, schedule caption.
class HabitListCard extends StatelessWidget {
  const HabitListCard({
    super.key,
    required this.habit,
    required this.listIndex,
    required this.onTap,
  });

  final Habit habit;
  final int listIndex;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0x1485736D),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 16, 12, 16),
            child: Row(
              children: [
                ReorderableDragStartListener(
                  index: listIndex,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.drag_indicator_rounded,
                      color: AppColors.habitsMuted,
                      size: 24,
                    ),
                  ),
                ),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.habitsIconWellFill,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  alignment: Alignment.center,
                  child: HabitIcon(iconKey: habit.iconKey, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.name,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                          letterSpacing: -0.2,
                          color: AppColors.habitsTitleInk,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        habitScheduleCaption(context, habit),
                        style: GoogleFonts.manrope(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.6,
                          height: 1.3,
                          color: AppColors.habitsBodyBrown,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.habitsMuted.withValues(alpha: 0.45),
                  size: 28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
