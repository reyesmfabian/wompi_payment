import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart'; // Importa mocktail en lugar de mockito
import 'package:wompi_payment_colombia/src/src_exports.dart';

class MockPsePay extends Mock implements PsePay {}

class MockPsePaymentResponse extends Mock implements PsePaymentResponse {}

void main() {
  group('PsePay Tests', () {
    test('PsePay Test Types', () async {
      final psePay0 = MockPsePay();
      expect(psePay0, isA<PsePay>());
    });

    test('PsePay Test', () async {
      final psePay1 = MockPsePay();
      final psePaymentResponse = MockPsePaymentResponse();

      // Configura el comportamiento del mock con when
      when(() => psePay1.pay()).thenAnswer((_) async {
        return psePaymentResponse;
      });

      // ACT
      final result0 = await WompiService.pay(paymentProcessor: psePay1);

      // ASSERT
      verify(
        () => psePay1.pay(),
      ); // Verifica que se haya llamado al método "pay" en _psePay
      expect(result0, equals(psePaymentResponse));
    });

    test('PsePay throws ArgumentError', () {
      final psePay = MockPsePay();

      // Configura el comportamiento del mock para que lance ArgumentError
      when(() => psePay.pay()).thenThrow(ArgumentError());

      // ACT
      final result = WompiService.pay(paymentProcessor: psePay);

      // ASSERT
      verify(
        () => psePay.pay(),
      ); // Verifica que se haya llamado al método "pay" en _psePay
      expect(() => result, throwsArgumentError);
    });
  });
}
