import 'package:isar/isar.dart';

import '../../../../core/storage/isar_db.dart';
import '../../domain/repositories/insurance_repository.dart';
import '../isar/isar_insurance_ledger.dart';

class IsarInsuranceRepository implements InsuranceRepository {
  IsarInsuranceRepository(this._db);

  static const int _monthlyLimit = 2;

  final IsarDb _db;

  Isar get _isar => _db.isar;

  @override
  Future<int> getRemainingTokens({required String monthKey}) async {
    final ledger = await _isar.isarInsuranceLedgers
        .filter()
        .monthKeyEqualTo(monthKey)
        .findFirst();
    final used = ledger?.tokensUsed ?? 0;
    final remaining = _monthlyLimit - used;
    return remaining < 0 ? 0 : remaining;
  }

  @override
  Future<void> consumeToken({required String monthKey}) async {
    await _isar.writeTxn(() async {
      var ledger = await _isar.isarInsuranceLedgers
          .filter()
          .monthKeyEqualTo(monthKey)
          .findFirst();

      ledger ??= IsarInsuranceLedger()
        ..monthKey = monthKey
        ..tokensUsed = 0
        ..updatedAt = DateTime.now();

      if (ledger.tokensUsed < _monthlyLimit) {
        ledger.tokensUsed += 1;
        ledger.updatedAt = DateTime.now();
        await _isar.isarInsuranceLedgers.put(ledger);
      }
    });
  }
}

