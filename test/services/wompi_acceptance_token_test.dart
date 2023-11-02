import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wompi_payment_colombia/src/src_exports.dart';

class MockAcceptanceResponse extends Mock implements AcceptanceResponse {}

void main() {
  group('Wompi Service Tests', () {
    final _acceptanceResponse = MockAcceptanceResponse();
    test('Test Acceptance Model Type', () async {
      expect(_acceptanceResponse, isA<AcceptanceResponse>());
    });
  });
}
