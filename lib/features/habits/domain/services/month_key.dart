import 'package:intl/intl.dart';

class MonthKey {
  static String of(DateTime dtLocal) {
    final local = dtLocal.toLocal();
    return DateFormat('yyyy-MM').format(DateTime(local.year, local.month));
  }
}

