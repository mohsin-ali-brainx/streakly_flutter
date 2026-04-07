import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/startup_error_app.dart';
import 'di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Object? startupError;
  StackTrace? startupStack;
  try {
    await setupServiceLocator();
  } catch (e, st) {
    startupError = e;
    startupStack = st;
    debugPrint('Startup failed: $e');
    debugPrint('$st');
  }

  if (startupError != null) {
    runApp(StartupErrorApp(error: startupError, stackTrace: startupStack));
  } else {
    runApp(const StreaklyApp());
  }
}
