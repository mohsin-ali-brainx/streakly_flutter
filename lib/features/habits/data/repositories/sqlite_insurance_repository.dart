import '../../../../core/storage/app_database.dart';
import '../../domain/repositories/insurance_repository.dart';

class SqliteInsuranceRepository implements InsuranceRepository {
  SqliteInsuranceRepository(this._db);

  static const int _monthlyLimit = 2;

  final AppDatabase _db;

  @override
  Future<int> getRemainingTokens({required String monthKey}) async {
    final rows = await _db.database.query(
      'insurance_ledger',
      where: 'month_key = ?',
      whereArgs: [monthKey],
      limit: 1,
    );
    final used = rows.isEmpty ? 0 : rows.single['tokens_used'] as int;
    final remaining = _monthlyLimit - used;
    return remaining < 0 ? 0 : remaining;
  }

  @override
  Future<void> consumeToken({required String monthKey}) async {
    await _db.database.transaction((txn) async {
      final rows = await txn.query(
        'insurance_ledger',
        where: 'month_key = ?',
        whereArgs: [monthKey],
        limit: 1,
      );

      final now = DateTime.now().toIso8601String();
      if (rows.isEmpty) {
        await txn.insert('insurance_ledger', {
          'month_key': monthKey,
          'tokens_used': 1,
          'updated_at': now,
        });
        return;
      }

      final used = rows.single['tokens_used'] as int;
      if (used >= _monthlyLimit) return;

      await txn.update(
        'insurance_ledger',
        {
          'tokens_used': used + 1,
          'updated_at': now,
        },
        where: 'month_key = ?',
        whereArgs: [monthKey],
      );
    });
  }
}
