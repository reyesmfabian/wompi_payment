import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wompi_payment_colombia/src/src_exports.dart';

class MockNequiPay extends Mock implements NequiPay {}

class MockNequiPaymentResponse extends Mock implements NequiPaymentResponse {}

void main() {
  group('NequiPay Tests', () {
    MockNequiPay nequiPay = MockNequiPay();
    MockNequiPaymentResponse nequiPaymentResponse = MockNequiPaymentResponse();
    test('NequiPay Test Types', () async {
      expect(nequiPay, isA<NequiPay>());
    });
    test('NequiPay Test', () async {
      when(() => nequiPay.pay()).thenAnswer((_) async {
        return nequiPaymentResponse;
      });

      /// ACT
      final result = await WompiService.pay(paymentProcessor: nequiPay);

      /// ASSERT
      verify(() => nequiPay.pay());
      expect(result, equals(nequiPaymentResponse));
    });

    test('Nequi Pay throws ArgumentError', () {
      when(() => nequiPay.pay()).thenAnswer((_) {
        throw ArgumentError();
      });
      final result = WompiService.pay(paymentProcessor: nequiPay);

      /// ASSERT
      verify(() => nequiPay.pay());
      expect(result, throwsArgumentError);
    });
  });
}
