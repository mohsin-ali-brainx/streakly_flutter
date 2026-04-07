import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimens.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../di/service_locator.dart';
import '../../../notifications/data/habit_reminder_scheduler.dart';
import '../../../notifications/domain/notifications_permission_service.dart';
import '../../domain/entities/habit.dart';
import '../../domain/repositories/habits_repository.dart';
import 'habit_emoji_badge.dart';

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
      showDragHandle: true,
      builder: (context) => HabitEditorSheet(existing: existing),
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
        await _reminders.syncFromHabit(h);
      } else {
        final created = await _habits.createHabit(
          name: name,
          iconKey: _iconKey,
          reminderEnabled: _reminderEnabled,
          reminderTimeMinutes: _reminderEnabled ? minutes : null,
        );
        await _reminders.syncFromHabit(created);
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

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppDimens.space2xl,
          0,
          AppDimens.space2xl,
          AppDimens.space2xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _isEdit ? HabitsStrings.editTitle : HabitsStrings.addTitle,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppDimens.space2xl),
            TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: HabitsStrings.nameLabel,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppDimens.space2xl),
            Text(
              HabitsStrings.iconLabel,
              style: textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppDimens.spaceSm),
            Wrap(
              spacing: AppDimens.spaceSm,
              runSpacing: AppDimens.spaceSm,
              children: [
                for (final key in kHabitEditorIconKeys)
                  ChoiceChip(
                    label: HabitEmojiBadge(iconKey: key, size: 22),
                    selected: _iconKey == key,
                    onSelected: (_) => setState(() => _iconKey = key),
                  ),
              ],
            ),
            const SizedBox(height: AppDimens.space2xl),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(HabitsStrings.reminderSwitch),
              subtitle: Text(
                _reminderEnabled
                    ? _reminderTime.format(context)
                    : HabitsStrings.reminderOff,
                style: textTheme.bodySmall?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
              value: _reminderEnabled,
              onChanged: (v) => setState(() => _reminderEnabled = v),
            ),
            if (_reminderEnabled) ...[
              const SizedBox(height: AppDimens.spaceSm),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: _pickTime,
                  icon: const Icon(Icons.schedule),
                  label: Text(HabitsStrings.pickTime),
                ),
              ),
            ],
            const SizedBox(height: AppDimens.space3xl),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(HabitsStrings.save),
            ),
            if (_isEdit) ...[
              const SizedBox(height: AppDimens.spaceLg),
              TextButton(
                onPressed: _saving ? null : _archive,
                child: Text(
                  HabitsStrings.archiveHabit,
                  style: TextStyle(color: cs.error),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
