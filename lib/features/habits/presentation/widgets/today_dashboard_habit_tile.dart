import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../domain/entities/habit.dart';
import 'habit_icon.dart';

Color _wellColorForKey(String iconKey) {
  switch (iconKey) {
    case 'meditate':
      return AppColors.todayWellMeditate;
    case 'read':
    case 'book':
    case 'sun':
      return AppColors.todayWellRead;
    case 'walk':
    case 'runner':
    case 'dumbbell':
      return AppColors.todayWellWalk;
    case 'water':
    case 'leaf':
      return AppColors.todayWellWater;
    case 'journal':
      return AppColors.todayWellJournal;
    case 'moon':
    case 'luna':
      return AppColors.todayWellJournal;
    case 'palette':
    case 'brain':
      return AppColors.todayWellMeditate;
    case 'more':
      return AppColors.habitsCardTint;
    default:
      return AppColors.habitsCardTint;
  }
}

class TodayDashboardHabitTile extends StatelessWidget {
  const TodayDashboardHabitTile({
    super.key,
    required this.habit,
    required this.done,
    required this.streakDays,
    required this.onEdit,
    required this.onToggleDone,
  });

  final Habit habit;
  final bool done;
  final int streakDays;
  final VoidCallback onEdit;
  final VoidCallback onToggleDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0x1485736D),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onEdit,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
            child: Row(
              children: [
                _LeadingWell(
                  done: done,
                  iconKey: habit.iconKey,
                  onToggle: onToggleDone,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.name,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                          color: AppColors.habitsTitleInk,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        TodayStrings.streakCaps(streakDays),
                        style: GoogleFonts.manrope(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: AppColors.habitsMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: AppColors.habitsMuted,
                  ),
                  onPressed: () async {
                    final choice = await showModalBottomSheet<String>(
                      context: context,
                      backgroundColor: AppColors.habitsScreenBg,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (ctx) => SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.edit_outlined),
                              title: Text(TodayStrings.editHabit),
                              onTap: () => Navigator.pop(ctx, 'edit'),
                            ),
                          ],
                        ),
                      ),
                    );
                    if (choice == 'edit') onEdit();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LeadingWell extends StatelessWidget {
  const _LeadingWell({
    required this.done,
    required this.iconKey,
    required this.onToggle,
  });

  final bool done;
  final String iconKey;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: TodayStrings.toggleDoneTooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onToggle,
          customBorder: const CircleBorder(),
          child: Ink(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: done
                  ? AppColors.todayHabitDoneGreen
                  : _wellColorForKey(iconKey),
            ),
            child: Center(
              child: done
                  ? const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 26,
                    )
                  : HabitIcon(iconKey: iconKey, size: 22),
            ),
          ),
        ),
      ),
    );
  }
}
