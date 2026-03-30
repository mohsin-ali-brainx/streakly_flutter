import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../domain/notifications_permission_service.dart';

class FlutterLocalNotificationsPermissionService
    implements NotificationsPermissionService {
  FlutterLocalNotificationsPermissionService(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;

  @override
  Future<bool> requestPermission() async {
    // iOS
    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (ios != null) {
      final granted = await ios.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }

    // macOS
    final macos = _plugin.resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>();
    if (macos != null) {
      final granted = await macos.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }

    // Android (13+)
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      final granted = await android.requestNotificationsPermission();
      return granted ?? true;
    }

    // Other platforms: treat as enabled.
    return true;
  }
}

