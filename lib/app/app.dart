import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_router.dart';
import '../ui/theme/app_theme.dart';

class StreaklyApp extends StatefulWidget {
  const StreaklyApp({super.key});

  @override
  State<StreaklyApp> createState() => _StreaklyAppState();
}

class _StreaklyAppState extends State<StreaklyApp> {
  late final GoRouter _router = buildRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Streakly',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}

