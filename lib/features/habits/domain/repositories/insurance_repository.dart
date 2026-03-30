abstract class InsuranceRepository {
  /// Returns how many insurance tokens are remaining for the given month.
  /// MVP: global 2 tokens per calendar month.
  Future<int> getRemainingTokens({required String monthKey});

  /// Consumes 1 token for the given month.
  Future<void> consumeToken({required String monthKey});
}

