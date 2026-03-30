import 'package:flutter/foundation.dart';

import '../../../../core/prefs/domain/app_prefs_repository.dart';
import '../../../../di/service_locator.dart';

class OnboardingInsuranceController extends ChangeNotifier {
  OnboardingInsuranceController({AppPrefsRepository? prefsRepository})
      : _prefsRepository = prefsRepository ?? sl<AppPrefsRepository>();

  final AppPrefsRepository _prefsRepository;

  bool _submitting = false;
  bool get submitting => _submitting;

  Future<void> finish() async {
    if (_submitting) return;
    _submitting = true;
    notifyListeners();
    try {
      await _prefsRepository.setOnboardingCompleted(true);
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }
}
