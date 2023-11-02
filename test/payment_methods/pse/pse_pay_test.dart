import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart'; // Importa mocktail en lugar de mockito
import 'package:wompi_payment_colombia/src/src_exports.dart';

class MockPsePay extends Mock implements PsePay {}

class MockPsePaymentResponse extends Mock implements PsePaymentResponse {}

void main() {
  group('PsePay Tests', () {
    test('PsePay Test Types', () async {
      final _psePay = MockPsePay();
      expect(_psePay, isA<PsePay>());
    });

    test('PsePay Test', () async {
      final _psePay = MockPsePay();
      final _psePaymentResponse = MockPsePaymentResponse();

      // Configura el comportamiento del mock con when
      when(() => _psePay.pay()).thenAnswer((_) async {
        return _psePaymentResponse;
      });

      // ACT
      final _result = await WompiService.pay(paymentProcessor: _psePay);

      // ASSERT
      verify(
        () => _psePay.pay(),
      ); // Verifica que se haya llamado al método "pay" en _psePay
      expect(_result, equals(_psePaymentResponse));
    });

    test('PsePay throws ArgumentError', () {
      final _psePay = MockPsePay();

      // Configura el comportamiento del mock para que lance ArgumentError
      when(() => _psePay.pay()).thenThrow(ArgumentError());

      // ACT
      final _result = WompiService.pay(paymentProcessor: _psePay);

      // ASSERT
      verify(
        () => _psePay.pay(),
      ); // Verifica que se haya llamado al método "pay" en _psePay
      expect(() => _result, throwsArgumentError);
    });
  });
}
