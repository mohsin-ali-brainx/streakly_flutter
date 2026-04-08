import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('smoke', (tester) async {
    // App bootstrap is covered by widget/unit tests; this smoke test ensures
    // integration_test wiring works in CI/devices.
    expect(true, isTrue);
  });
}

