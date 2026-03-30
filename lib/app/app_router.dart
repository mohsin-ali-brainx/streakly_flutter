import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/app_routes.dart';
import '../core/prefs/domain/app_prefs_repository.dart';
import '../di/service_locator.dart';
import '../features/habits/presentation/screens/habits_screen.dart';
import '../features/habits/presentation/screens/today_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_insurance_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_notifications_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_setup_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_welcome_screen.dart';
import '../features/onboarding/presentation/screens/splash_screen.dart';
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
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab.index,
        onDestinationSelected: (index) {
          final next = AppTab.values[index];
          context.go(_locationForTab(next));
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.today), label: 'Today'),
          NavigationDestination(icon: Icon(Icons.view_list), label: 'Habits'),
          NavigationDestination(icon: Icon(Icons.insights), label: 'Stats'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
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
            path: AppRoutes.stats,
            builder: (context, state) => const StatsScreen(),
          ),
          GoRoute(
            path: AppRoutes.settings,
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
}

