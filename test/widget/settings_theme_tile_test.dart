import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:streakly_app_flutter/app/theme_mode_controller.dart';
import 'package:streakly_app_flutter/core/prefs/domain/app_prefs_repository.dart';
import 'package:streakly_app_flutter/features/habits/domain/repositories/insurance_repository.dart';
import 'package:streakly_app_flutter/features/settings/presentation/screens/settings_screen.dart';

class _FakePrefs implements AppPrefsRepository {
  String _theme = 'system';

  @override
  Future<String> themeMode() async => _theme;

  @override
  Future<void> setThemeMode(String value) async {
    _theme = value;
  }

  @override
  Future<bool> starterHabitsCreated() async => false;
  @override
  Future<void> setStarterHabitsCreated(bool value) async {}
  @override
  Future<bool> onboardingWelcomeStepCompleted() async => false;
  @override
  Future<void> setOnboardingWelcomeStepCompleted(bool value) async {}
  @override
  Future<bool> isOnboardingCompleted() async => false;
  @override
  Future<void> setOnboardingCompleted(bool value) async {}
  @override
  Future<bool> notificationsPermissionAsked() async => false;
  @override
  Future<void> setNotificationsPermissionAsked(bool value) async {}
  @override
  Future<bool> notificationsEnabled() async => false;
  @override
  Future<void> setNotificationsEnabled(bool value) async {}
  @override
  Future<bool> onboardingNotificationsStepCompleted() async => false;
  @override
  Future<void> setOnboardingNotificationsStepCompleted(bool value) async {}
}

class _FakeInsuranceRepo implements InsuranceRepository {
  @override
  Future<int> getRemainingTokens({required String monthKey}) async => 2;
  @override
  Future<void> consumeToken({required String monthKey}) async {}
  @override
  Future<int> getTotalTokensConsumed() async => 0;
}

void main() {
  final sl = GetIt.instance;

  setUp(() async {
    await sl.reset();
    sl.registerSingleton<AppPrefsRepository>(_FakePrefs());
    sl.registerSingleton<ThemeModeController>(
      ThemeModeController(sl<AppPrefsRepository>()),
    );
    await sl<ThemeModeController>().load();
    sl.registerSingleton<InsuranceRepository>(_FakeInsuranceRepo());
  });

  testWidgets('Settings shows theme mode label', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider.value(
            value: sl<ThemeModeController>(),
            child: const SettingsScreen(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('System'), findsOneWidget);
  });
}

