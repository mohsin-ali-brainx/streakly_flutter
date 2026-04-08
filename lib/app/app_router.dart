import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/app_routes.dart';
import 'widgets/streakly_bottom_nav_bar.dart';
import '../core/prefs/domain/app_prefs_repository.dart';
import '../di/service_locator.dart';
import '../features/habits/presentation/screens/habits_screen.dart';
import '../features/habits/presentation/screens/habit_detail_screen.dart';
import '../features/habits/presentation/screens/habit_editor_screen.dart';
import '../features/habits/presentation/screens/streak_recovery_screen.dart';
import '../features/habits/presentation/screens/today_screen.dart';
import '../features/habits/domain/entities/habit.dart';
import '../features/onboarding/presentation/screens/onboarding_insurance_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_notifications_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_setup_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_welcome_screen.dart';
import '../features/onboarding/presentation/screens/splash_screen.dart';
import '../features/settings/presentation/screens/notifications_settings_screen.dart';
import '../features/settings/presentation/screens/insurance_settings_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';
import '../features/stats/presentation/screens/stats_screen.dart';

enum AppTab { today, habits, stats, settings }

String _locationForTab(AppTab tab) {
  return switch (tab) {
    AppTab.today => AppRoutes.today,
    AppTab.habits => AppRoutes.habits,
    AppTab.stats => AppRoutes.stats,
    AppTab.settings => AppRoutes.settings,
  };
}

AppTab _tabForLocation(String location) {
  if (location.startsWith(AppRoutes.habits)) return AppTab.habits;
  if (location.startsWith(AppRoutes.stats)) return AppTab.stats;
  if (location.startsWith(AppRoutes.settings)) return AppTab.settings;
  return AppTab.today;
}

/// Keeps first-time users on Welcome until prefs say the intro was completed.
FutureOr<String?> _onboardingWelcomeGuard(
  BuildContext context,
  GoRouterState state,
) async {
  final loc = state.matchedLocation;
  if (loc == AppRoutes.splash) return null;

  final prefs = sl<AppPrefsRepository>();
  if (await prefs.isOnboardingCompleted()) return null;

  final welcomeVisited = await prefs.onboardingWelcomeStepCompleted();
  final starterCreated = await prefs.starterHabitsCreated();
  if (welcomeVisited || starterCreated) return null;

  if (loc.startsWith(AppRoutes.onboardingSetup) ||
      loc.startsWith(AppRoutes.onboardingNotifications) ||
      loc.startsWith(AppRoutes.onboardingInsurance)) {
    return AppRoutes.onboardingWelcome;
  }
  return null;
}

class AppShellScaffold extends StatelessWidget {
  const AppShellScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    final AppTab tab = _tabForLocation(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: StreaklyBottomNavBar(
        selectedIndex: tab.index,
        onSelect: (index) {
          final next = AppTab.values[index];
          context.go(_locationForTab(next));
        },
      ),
    );
  }
}

GoRouter buildRouter({String initialLocation = AppRoutes.splash}) {
  return GoRouter(
    initialLocation: initialLocation,
    redirect: _onboardingWelcomeGuard,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboardingWelcome,
        builder: (context, state) => const OnboardingWelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboardingSetup,
        builder: (context, state) => const OnboardingSetupScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboardingNotifications,
        builder: (context, state) => const OnboardingNotificationsScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboardingInsurance,
        builder: (context, state) => const OnboardingInsuranceScreen(),
      ),
      GoRoute(
        path: AppRoutes.habitNew,
        builder: (context, state) => const HabitEditorScreen(),
      ),
      GoRoute(
        path: AppRoutes.habitEdit,
        builder: (context, state) {
          final habit = state.extra;
          if (habit is! Habit) return const HabitsScreen();
          return HabitEditorScreen(existing: habit);
        },
      ),
      GoRoute(
        path: AppRoutes.streakRecovery,
        builder: (context, state) {
          final args = state.extra;
          if (args is! StreakRecoveryArgs) return const TodayScreen();
          return StreakRecoveryScreen(args: args);
        },
      ),
      ShellRoute(
        builder: (context, state, child) => AppShellScaffold(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.today,
            builder: (context, state) => const TodayScreen(),
          ),
          GoRoute(
            path: AppRoutes.habits,
            builder: (context, state) => const HabitsScreen(),
          ),
          GoRoute(
            path: AppRoutes.habitDetail,
            builder: (context, state) {
              final habit = state.extra;
              if (habit is! Habit) return const HabitsScreen();
              return HabitDetailScreen(habit: habit);
            },
          ),
          GoRoute(
            path: AppRoutes.stats,
            builder: (context, state) => const StatsScreen(),
          ),
          GoRoute(
            path: AppRoutes.settings,
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: AppRoutes.settingsNotifications,
            builder: (context, state) => const NotificationsSettingsScreen(),
          ),
          GoRoute(
            path: AppRoutes.settingsInsurance,
            builder: (context, state) => const InsuranceSettingsScreen(),
          ),
        ],
      ),
    ],
  );
}
