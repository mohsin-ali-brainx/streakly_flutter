import 'package:flutter/foundation.dart';

import '../../../../core/prefs/domain/app_prefs_repository.dart';
import '../../../../di/service_locator.dart';

class OnboardingWelcomeController extends ChangeNotifier {
  OnboardingWelcomeController({AppPrefsRepository? prefsRepository})
      : _prefsRepository = prefsRepository ?? sl<AppPrefsRepository>();

  final AppPrefsRepository _prefsRepository;

  bool _submitting = false;
  bool get submitting => _submitting;

  Future<void> continueToSetup() async {
    if (_submitting) return;
    _submitting = true;
    notifyListeners();
    try {
      await _prefsRepository.setOnboardingWelcomeStepCompleted(true);
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }
}
