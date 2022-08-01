import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wompi_payment_colombia/src/src_exports.dart';

import 'wompi_acceptance_token_test.mocks.dart';

@GenerateMocks([AcceptanceResponse])
void main() {
  group('Wompi Service Tests', () {
    final _acceptanceResponse = MockAcceptanceResponse();
    test('Test Acceptance Model Type', () async {
      expect(_acceptanceResponse, isA<AcceptanceResponse>());
    });
  });
}
