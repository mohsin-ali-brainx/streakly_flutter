import 'package:flutter/material.dart';

/// Shown when [setupServiceLocator] fails so you see the real error instead of a silent crash.
class StartupErrorApp extends StatelessWidget {
  const StartupErrorApp({
    super.key,
    required this.error,
    this.stackTrace,
  });

  final Object error;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Streakly couldn’t start',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          error.toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                        if (stackTrace != null) ...[
                          const SizedBox(height: 16),
                          Text(
                            'Stack trace',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 8),
                          SelectableText(
                            stackTrace.toString(),
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                        const SizedBox(height: 24),
                        const Text(
                          'If you recently updated the app, uninstall it (or clear app storage) '
                          'and install again — the local database format may have changed.',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
