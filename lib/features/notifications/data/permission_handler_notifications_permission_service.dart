import 'package:permission_handler/permission_handler.dart' as ph;

import '../domain/notifications_permission_service.dart';

class PermissionHandlerNotificationsPermissionService
    implements NotificationsPermissionService {
  @override
  Future<bool> requestPermission() async {
    final status = await ph.Permission.notification.request();
    return status.isGranted;
  }

  @override
  Future<void> openAppSettings() async {
    await ph.openAppSettings();
  }
}

