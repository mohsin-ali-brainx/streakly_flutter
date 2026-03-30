import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../prefs/data/isar/isar_app_prefs.dart';
import '../../features/habits/data/isar/isar_habit.dart';
import '../../features/habits/data/isar/isar_habit_day_status.dart';
import '../../features/habits/data/isar/isar_insurance_ledger.dart';

class IsarDb {
  IsarDb(this.isar);

  final Isar isar;

  static Future<IsarDb> open() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [
        IsarAppPrefsSchema,
        IsarHabitSchema,
        IsarHabitDayStatusSchema,
        IsarInsuranceLedgerSchema,
      ],
      directory: dir.path,
    );
    return IsarDb(isar);
  }
}

