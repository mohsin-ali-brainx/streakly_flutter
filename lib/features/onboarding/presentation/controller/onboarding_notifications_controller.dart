import 'package:flutter/foundation.dart';

import '../../../../core/prefs/domain/app_prefs_repository.dart';
import '../../../../di/service_locator.dart';
import '../../../notifications/domain/notifications_permission_service.dart';

class OnboardingNotificationsController extends ChangeNotifier {
  OnboardingNotificationsController({
    AppPrefsRepository? prefsRepository,
    NotificationsPermissionService? permissionService,
  })  : _prefsRepository = prefsRepository ?? sl<AppPrefsRepository>(),
        _permissionService =
            permissionService ?? sl<NotificationsPermissionService>();

  final AppPrefsRepository _prefsRepository;
  final NotificationsPermissionService _permissionService;

  bool _submitting = false;
  bool get submitting => _submitting;

  bool? _granted;
  bool? get granted => _granted;

  Future<bool> enable() async {
    if (_submitting) return _granted ?? false;
    _submitting = true;
    notifyListeners();
    try {
      await _prefsRepository.setNotificationsPermissionAsked(true);
      final granted = await _permissionService.requestPermission();
      await _prefsRepository.setNotificationsEnabled(granted);
      await _prefsRepository.setOnboardingNotificationsStepCompleted(true);
      _granted = granted;
      return granted;
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }

  Future<void> skip() async {
    if (_submitting) return;
    _submitting = true;
    notifyListeners();
    try {
      await _prefsRepository.setNotificationsPermissionAsked(true);
      await _prefsRepository.setNotificationsEnabled(false);
      await _prefsRepository.setOnboardingNotificationsStepCompleted(true);
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }

  Future<void> openSettings() async {
    if (_submitting) return;
    await _permissionService.openAppSettings();
  }
}

