import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../di/service_locator.dart';
import '../../../notifications/data/habit_reminder_scheduler.dart';
import '../../../notifications/domain/notifications_permission_service.dart';
import '../../domain/entities/habit.dart';
import '../../domain/repositories/habits_repository.dart';
import '../widgets/habit_icon.dart';

class HabitEditorScreen extends StatefulWidget {
  const HabitEditorScreen({super.key, this.existing});

  final Habit? existing;

  @override
  State<HabitEditorScreen> createState() => _HabitEditorScreenState();
}

class _Template {
  const _Template(this.title, this.iconKey, this.name);

  final String title;
  final String iconKey;
  final String name;
}

const _templates = <_Template>[
  _Template(HabitsStrings.templatesDrinkWater, 'water', 'Drink water'),
  _Template(HabitsStrings.templatesNoCoffee, 'custom', 'No coffee'),
  _Template(HabitsStrings.templatesFlour, 'read', 'Flour'),
  _Template(HabitsStrings.templatesYoga, 'meditate', 'Yoga'),
];

const _anchors = <String>[
  'sun',
  'leaf',
  'dumbbell',
  'book',
  'moon',
  'luna',
  'runner',
  'palette',
  'brain',
  'more',
];

class _HabitEditorScreenState extends State<HabitEditorScreen> {
  final _nameController = TextEditingController();
  final _scroll = ScrollController();

  Habit? get _existing => widget.existing;
  bool get _isEdit => _existing != null;

  late String _iconKey;
  late bool _reminderEnabled;
  late TimeOfDay _reminderTime;
  bool _saving = false;

  HabitsRepository get _habits => sl<HabitsRepository>();
  HabitReminderScheduler get _reminders => sl<HabitReminderScheduler>();

  static const _presetTimes = <int>[8 * 60, 12 * 60 + 30, 19 * 60];

  @override
  void initState() {
    super.initState();
    final h = _existing;
    _nameController.text = h?.name ?? '';
    _iconKey = h?.iconKey ?? 'sun';
    _reminderEnabled = h?.reminderEnabled ?? true;
    final mins = h?.reminderTimeMinutes ?? _presetTimes.first;
    _reminderTime = TimeOfDay(hour: mins ~/ 60, minute: mins % 60);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _scroll.dispose();
    super.dispose();
  }

  int get _timeMinutes => _reminderTime.hour * 60 + _reminderTime.minute;

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    setState(() => _saving = true);
    try {
      final minutes = _timeMinutes;
      if (_reminderEnabled) {
        await sl<NotificationsPermissionService>().requestPermission();
      }
      if (_isEdit) {
        final prev = _existing!;
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
      if (mounted) Navigator.of(context).pop(true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Widget _sectionTitle(String text) {
    return Text(
      text.toUpperCase(),
      style: GoogleFonts.manrope(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.08,
        color: AppColors.habitsMuted,
      ),
    );
  }

  Widget _templateCard(_Template t) {
    final selected = _nameController.text.trim() == t.name && _iconKey == t.iconKey;
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: () {
        setState(() {
          _iconKey = t.iconKey;
          _nameController.text = t.name;
        });
      },
      child: Ink(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: selected ? 1 : 0.95),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.habitsCardTint,
                borderRadius: BorderRadius.circular(50),
              ),
              alignment: Alignment.center,
              child: HabitIcon(
                iconKey: t.iconKey,
                size: 28,
                color: AppColors.habitsTitleInk,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              t.title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.habitsTitleInk,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _anchorSvgPath(String key) {
    if (key == 'luna') return 'assets/icons/anchor_moon.svg';
    return 'assets/icons/anchor_$key.svg';
  }

  Widget _visualAnchorHeading() {
    return Text(
      HabitsStrings.visualAnchor.toUpperCase(),
      style: GoogleFonts.manrope(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.05,
        color: AppColors.visualAnchorIconBrown,
      ),
    );
  }

  Widget _anchorItem(String key) {
    final selected = _iconKey == key;
    const diameter = 48.0;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _iconKey = key),
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected
              ? AppColors.visualAnchorSelected
              : AppColors.visualAnchorInactiveWell,
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          _anchorSvgPath(key),
          width: 30,
          height: 30,
          colorFilter: ColorFilter.mode(
            selected ? Colors.white : AppColors.visualAnchorIconBrown,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  Widget _timeChip(int minutes) {
    final selected = _timeMinutes == minutes;
    final tod = TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
    final label = minutes < 12 * 60 ? 'MORNING' : minutes < 18 * 60 ? 'NOON' : 'EVENING';
    return Expanded(
      child: Container(decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: selected
            ? AppColors.visualAnchorSelected
            : AppColors.visualAnchorInactiveWell,
        ),
        child: InkWell(
          onTap: () => setState(() => _reminderTime = tod),
          child: Ink(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: selected ? AppColors.todayTealDone : Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                Text(
                  label,
                  style: GoogleFonts.manrope(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: selected ? Colors.white70 : AppColors.habitsMuted,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tod.format(context),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: selected ? Colors.white : AppColors.habitsTitleInk,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.habitEditorScreenBg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 16, 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppColors.habitsMuted,
                    ),
                  ),
                  Text(
                    _isEdit
                        ? HabitsStrings.editTitle
                        : HabitsStrings.newHabitPageTitle,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 28 / 1.4,
                      fontWeight: FontWeight.w700,
                      color: AppColors.habitsPrimaryCta,
                    ),
                  ),
                  const Spacer(),
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.habitsCardTint,
                    child: Icon(
                      Icons.person,
                      size: 20,
                      color: AppColors.habitsMuted,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scroll,
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _sectionTitle(HabitsStrings.habitIdentity),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: 'What is your new ritual?',
                        hintStyle: GoogleFonts.manrope(
                          color: AppColors.habitsMuted.withValues(alpha: 0.45),
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    _sectionTitle(HabitsStrings.quickTemplates),
                    const SizedBox(height: 10),
                    GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.55,
                      shrinkWrap: true,
                      children: [for (final t in _templates) _templateCard(t)],
                    ),
                    const SizedBox(height: 22),
                    _visualAnchorHeading(),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.visualAnchorCardBg,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
                      child: GridView.count(
                        crossAxisCount: 5,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 1,
                        children: [
                          for (final a in _anchors)
                            Center(child: _anchorItem(a)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.habitsCardTint,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      HabitsStrings.reminderSwitch,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.habitsTitleInk,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Get a gentle nudge to stay on track.',
                                      style: GoogleFonts.manrope(
                                        fontSize: 13,
                                        color: AppColors.habitsBodyBrown,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch.adaptive(
                                value: _reminderEnabled,
                                activeColor: AppColors.todayTealDone,
                                activeTrackColor:
                                    AppColors.todayTealDone.withValues(alpha: 0.35),
                                onChanged: (v) =>
                                    setState(() => _reminderEnabled = v),
                              ),
                            ],
                          ),
                          if (_reminderEnabled) ...[
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                _timeChip(_presetTimes[0]),
                                const SizedBox(width: 8),
                                _timeChip(_presetTimes[1]),
                                const SizedBox(width: 8),
                                _timeChip(_presetTimes[2]),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    Container(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Color(0x26D8C2BB), width: 2),
                        ),
                      ),
                      child: Text(
                        HabitsStrings.quote,
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          height: 1.45,
                          color: AppColors.habitsBodyBrown,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: FilledButton(
                  onPressed: _saving ? null : _save,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.habitsPrimaryCta,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    textStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
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
                      : Text(HabitsStrings.saveHabitArrow),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
