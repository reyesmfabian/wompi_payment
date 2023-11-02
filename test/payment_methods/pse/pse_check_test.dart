import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart'; // Importa mocktail en lugar de mockito
import 'package:wompi_payment_colombia/src/src_exports.dart';

class MockPseCheck extends Mock implements PseCheck {}

class MockPsePaymentResponse extends Mock implements PsePaymentResponse {}

void main() {
  group('Pse Check Tests', () {
    test('Pse Check Types', () async {
      final _pseCheck = MockPseCheck();
      expect(_pseCheck, isA<PseCheck>());
    });

    test('Pse Check Test', () async {
      final _pseCheck = MockPseCheck();
      final _psePaymentResponse = MockPsePaymentResponse();

      // Configura el comportamiento del mock con when
      when(() => _pseCheck.checkPayment()).thenAnswer((_) async {
        return _psePaymentResponse;
      });

      // ACT
      final _result =
          await WompiService.checkPayment(paymentChecker: _pseCheck);

      // ASSERT
      verify(() => _pseCheck.checkPayment());
      expect(_result, equals(_psePaymentResponse));
    });

    test('Pse Check throws ArgumentError', () {
      final _pseCheck = MockPseCheck();

      // Configura el comportamiento del mock para que lance ArgumentError
      when(() => _pseCheck.checkPayment()).thenThrow(ArgumentError());

      // ACT
      final _result = WompiService.checkPayment(paymentChecker: _pseCheck);

      // ASSERT
      verify(() => _pseCheck.checkPayment());
      expect(() => _result, throwsArgumentError);
    });
  });
}
