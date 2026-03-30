import 'package:intl/intl.dart';

/// Utilities for defining "habit days" in the user's local timezone.
///
/// MVP rule: a day is the local calendar day (00:00–23:59).
class LocalDay {
  static DateTime startOfDay(DateTime dt) {
    final local = dt.toLocal();
    return DateTime(local.year, local.month, local.day);
  }

  static DateTime todayStart() => startOfDay(DateTime.now());

  /// Stable string key for a local date, e.g. `2026-03-30`.
  static String dayKey(DateTime dayStartLocal) {
    final d = startOfDay(dayStartLocal);
    return DateFormat('yyyy-MM-dd').format(d);
  }

  static DateTime parseDayKey(String key) {
    // Interpreted as local.
    final parts = key.split('-').map(int.parse).toList();
    return DateTime(parts[0], parts[1], parts[2]);
  }
}

