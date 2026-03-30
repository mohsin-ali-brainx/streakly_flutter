import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/bootstrap_routing.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/prefs/domain/app_prefs_repository.dart';
import '../../../../di/service_locator.dart';
import '../../../../shared/presentation/widgets/streakly_wordmark.dart';

/// Cold-start splash: shows briefly, then routes using [resolveInitialOnboardingLocation].
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateWhenReady();
  }

  Future<void> _navigateWhenReady() async {
    final prefs = sl<AppPrefsRepository>();
    final results = await Future.wait<dynamic>([
      Future<void>.delayed(AppDurations.splashMinDisplay),
      resolveInitialOnboardingLocation(prefs),
    ]);
    if (!mounted) return;
    final next = results[1]! as String;
    context.go(next);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StreaklyWordmark.splash(),
            const SizedBox(height: 28),
            SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: scheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
