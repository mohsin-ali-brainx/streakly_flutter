abstract class NotificationsPermissionService {
  /// Requests OS notification permission when needed.
  /// Returns whether notifications are enabled/granted after the request.
  Future<bool> requestPermission();

  Future<void> openAppSettings();
}

