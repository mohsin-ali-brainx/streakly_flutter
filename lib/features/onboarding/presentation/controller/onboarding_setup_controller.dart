import 'package:flutter/foundation.dart';

import '../../../../core/prefs/domain/app_prefs_repository.dart';
import '../../../../di/service_locator.dart';
import '../../../habits/domain/repositories/habits_repository.dart';
import '../../domain/starter_habit_template.dart';

class OnboardingSetupController extends ChangeNotifier {
  OnboardingSetupController({
    HabitsRepository? habitsRepository,
    AppPrefsRepository? prefsRepository,
  })  : _habitsRepository = habitsRepository ?? sl<HabitsRepository>(),
        _prefsRepository = prefsRepository ?? sl<AppPrefsRepository>();

  final HabitsRepository _habitsRepository;
  final AppPrefsRepository _prefsRepository;

  final Set<String> _selectedIds = {'read10', 'meditate', 'walk'};
  final List<StarterHabitTemplate> _customTemplates = [];

  bool _submitting = false;
  bool get submitting => _submitting;

  Set<String> get selectedIds => Set.unmodifiable(_selectedIds);

  List<StarterHabitTemplate> get customTemplates =>
      List.unmodifiable(_customTemplates);

  int get selectedCount => _selectedIds.length;

  void toggle(String templateId) {
    if (_submitting) return;
    if (_selectedIds.contains(templateId)) {
      _selectedIds.remove(templateId);
    } else {
      _selectedIds.add(templateId);
    }
    notifyListeners();
  }

  /// Adds a user-defined habit and selects it. [subtitle] is optional; a
  /// default is used when empty.
  void addCustomHabit({
    required String title,
    String? subtitle,
  }) {
    if (_submitting) return;
    final trimmed = title.trim();
    if (trimmed.isEmpty) return;

    final id = 'custom_${DateTime.now().microsecondsSinceEpoch}';
    final sub = (subtitle?.trim().isNotEmpty ?? false)
        ? subtitle!.trim()
        : 'Your personal habit.';

    _customTemplates.add(
      StarterHabitTemplate(
        id: id,
        title: trimmed,
        subtitle: sub,
        iconKey: 'custom',
      ),
    );
    _selectedIds.add(id);
    notifyListeners();
  }

  void removeCustomTemplate(String templateId) {
    if (_submitting) return;
    _customTemplates.removeWhere((t) => t.id == templateId);
    _selectedIds.remove(templateId);
    notifyListeners();
  }

  Future<void> finishSetup() async {
    if (_submitting) return;
    _submitting = true;
    notifyListeners();
    try {
      final alreadyCreated = await _prefsRepository.starterHabitsCreated();
      if (alreadyCreated) return;

      final builtIn = kStarterTemplates
          .where((t) => _selectedIds.contains(t.id))
          .toList(growable: false);
      final custom = _customTemplates
          .where((t) => _selectedIds.contains(t.id))
          .toList(growable: false);
      final selected = [...builtIn, ...custom];

      // Ensure at least 1 habit exists; if user deselected all, add one default.
      final safeSelected =
          selected.isEmpty ? [kStarterTemplates.first] : selected;

      for (final t in safeSelected) {
        await _habitsRepository.createHabit(
          name: t.title,
          iconKey: t.iconKey,
        );
      }

      await _prefsRepository.setStarterHabitsCreated(true);
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }
}

