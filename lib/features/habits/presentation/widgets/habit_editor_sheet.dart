import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../di/service_locator.dart';
import '../../../notifications/data/habit_reminder_scheduler.dart';
import '../../../notifications/domain/notifications_permission_service.dart';
import '../../domain/entities/habit.dart';
import '../../domain/repositories/habits_repository.dart';
import 'habit_icon.dart';

/// Keys that match [HabitEmojiBadge.emojiForKey].
const List<String> kHabitEditorIconKeys = [
  'read',
  'water',
  'meditate',
  'walk',
  'journal',
  'custom',
];

class HabitEditorSheet extends StatefulWidget {
  const HabitEditorSheet({super.key, this.existing});

  final Habit? existing;

  static Future<void> open(BuildContext context, {Habit? existing}) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => HabitEditorSheet(existing: existing),
    );
  }

  @override
  State<HabitEditorSheet> createState() => _HabitEditorSheetState();
}

class _HabitEditorSheetState extends State<HabitEditorSheet> {
  final _nameController = TextEditingController();
  late String _iconKey;
  late bool _reminderEnabled;
  late TimeOfDay _reminderTime;
  bool _saving = false;

  HabitsRepository get _habits => sl<HabitsRepository>();
  HabitReminderScheduler get _reminders => sl<HabitReminderScheduler>();

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final h = widget.existing;
    _nameController.text = h?.name ?? '';
    _iconKey = h?.iconKey ?? 'read';
    _reminderEnabled = h?.reminderEnabled ?? false;
    final mins = h?.reminderTimeMinutes ?? (9 * 60);
    _reminderTime = TimeOfDay(hour: mins ~/ 60, minute: mins % 60);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
    );
    if (picked != null) setState(() => _reminderTime = picked);
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    setState(() => _saving = true);
    try {
      final minutes = _reminderTime.hour * 60 + _reminderTime.minute;

      if (_reminderEnabled) {
        await sl<NotificationsPermissionService>().requestPermission();
      }

      if (_isEdit) {
        final prev = widget.existing!;
        final h = Habit(
          id: prev.id,
          name: name,
          iconKey: _iconKey,
          createdAt: prev.createdAt,
          sortOrder: prev.sortOrder,
          reminderEnabled: _reminderEnabled,
          reminderTimeMinutes: _reminderEnabled ? minutes : null,
          archived: prev.archived,
        );
        await _habits.updateHabit(h);
        try {
          await _reminders.syncFromHabit(h);
        } catch (_) {}
      } else {
        final created = await _habits.createHabit(
          name: name,
          iconKey: _iconKey,
          reminderEnabled: _reminderEnabled,
          reminderTimeMinutes: _reminderEnabled ? minutes : null,
        );
        try {
          await _reminders.syncFromHabit(created);
        } catch (_) {}
      }
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _archive() async {
    final h = widget.existing;
    if (h == null) return;
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
    if (ok != true || !mounted) return;

    setState(() => _saving = true);
    try {
      await _reminders.cancel(h.id);
      await _habits.archiveHabit(h.id);
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Widget _sectionLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: GoogleFonts.manrope(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
        height: 1.5,
        color: AppColors.habitsMuted,
      ),
    );
  }

  Widget _iconOption(String key) {
    final sel = _iconKey == key;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _iconKey = key),
        customBorder: const CircleBorder(),
        child: Ink(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: sel
                ? AppColors.habitsIconWellFill
                : AppColors.habitsCardTint,
            border: Border.all(
              color: sel ? AppColors.habitsPrimaryCta : Colors.transparent,
              width: 2,
            ),
          ),
          child: Center(
            child: HabitIcon(
              iconKey: key,
              size: 22,
              color: AppColors.habitsTitleInk,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.habitsScreenBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A85736D),
            blurRadius: 40,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppDimens.pagePaddingHLoose,
            12,
            AppDimens.pagePaddingHLoose,
            AppDimens.space4xl + 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD8C2BB),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _isEdit ? HabitsStrings.editTitle : HabitsStrings.addTitle,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                  letterSpacing: -0.5,
                  color: AppColors.habitsTitleInk,
                ),
              ),
              const SizedBox(height: 24),
              _sectionLabel(HabitsStrings.sectionHabitName),
              const SizedBox(height: 10),
              TextField(
                controller: _nameController,
                textCapitalization: TextCapitalization.sentences,
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.habitsTitleInk,
                ),
                decoration: InputDecoration(
                  hintText: HabitsStrings.nameHint,
                  hintStyle: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.habitsMuted.withValues(alpha: 0.65),
                  ),
                  filled: true,
                  fillColor: AppColors.habitsCardTint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _sectionLabel(HabitsStrings.sectionIcon),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final key in kHabitEditorIconKeys) _iconOption(key),
                ],
              ),
              const SizedBox(height: 24),
              _sectionLabel(HabitsStrings.sectionReminder),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.habitsCardTint,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                HabitsStrings.reminderSwitch,
                                style: GoogleFonts.manrope(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.habitsTitleInk,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _reminderEnabled
                                    ? _reminderTime.format(context)
                                    : HabitsStrings.reminderOff,
                                style: GoogleFonts.manrope(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.habitsMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch.adaptive(
                          value: _reminderEnabled,
                          activeColor: AppColors.habitsPrimaryCta,
                          activeTrackColor:
                              AppColors.habitsPrimaryCta.withValues(alpha: 0.35),
                          onChanged: (v) => setState(() => _reminderEnabled = v),
                        ),
                      ],
                    ),
                    if (_reminderEnabled) ...[
                      const SizedBox(height: 12),
                      TextButton.icon(
                        onPressed: _pickTime,
                        icon: Icon(
                          Icons.schedule_rounded,
                          size: 20,
                          color: AppColors.habitsPrimaryCta,
                        ),
                        label: Text(
                          HabitsStrings.pickTime,
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppColors.habitsPrimaryCta,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: _saving ? null : _save,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.habitsPrimaryCta,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    disabledBackgroundColor:
                        AppColors.habitsPrimaryCta.withValues(alpha: 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    textStyle: GoogleFonts.manrope(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  child: _saving
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(HabitsStrings.save),
                ),
              ),
              if (_isEdit) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: TextButton(
                    onPressed: _saving ? null : _archive,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.habitsArchiveInk,
                      textStyle: GoogleFonts.manrope(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 18,
                          color: AppColors.habitsArchiveInk,
                        ),
                        const SizedBox(width: 8),
                        Text(HabitsStrings.archiveHabit),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
