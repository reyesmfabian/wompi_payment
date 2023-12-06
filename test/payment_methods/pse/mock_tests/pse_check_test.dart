import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart'; // Importa mocktail en lugar de mockito
import 'package:wompi_payment_colombia/src/src_exports.dart';

class MockPseCheck extends Mock implements PseCheck {}

class MockPsePaymentResponse extends Mock implements PsePaymentResponse {}

void main() {
  group('Pse Check Tests', () {
    test('Pse Check Types', () async {
      final pseCheck = MockPseCheck();
      expect(pseCheck, isA<PseCheck>());
    });

    test('Pse Check Test', () async {
      final pseCheck = MockPseCheck();
      final psePaymentResponse = MockPsePaymentResponse();

      // Configura el comportamiento del mock con when
      when(() => pseCheck.checkPayment()).thenAnswer((_) async {
        return psePaymentResponse;
      });

      // ACT
      final result = await WompiService.checkPayment(paymentChecker: pseCheck);

      // ASSERT
      verify(() => pseCheck.checkPayment());
      expect(result, equals(psePaymentResponse));
    });

    test('Pse Check throws ArgumentError', () {
      final pseCheck = MockPseCheck();

      // Configura el comportamiento del mock para que lance ArgumentError
      when(() => pseCheck.checkPayment()).thenThrow(ArgumentError());

      // ACT
      final result = WompiService.checkPayment(paymentChecker: pseCheck);

      // ASSERT
      verify(() => pseCheck.checkPayment());
      expect(() => result, throwsArgumentError);
    });
  });
}
