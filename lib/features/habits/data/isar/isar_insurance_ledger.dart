import 'package:isar/isar.dart';

part 'isar_insurance_ledger.g.dart';

@collection
class IsarInsuranceLedger {
  IsarInsuranceLedger();

  Id id = Isar.autoIncrement;

  /// Calendar month key `yyyy-MM`.
  @Index(unique: true)
  late String monthKey;

  int tokensUsed = 0;

  late DateTime updatedAt;
}

