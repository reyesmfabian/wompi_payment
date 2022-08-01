import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wompi_payment_colombia/src/src_exports.dart';

import 'nequi_pay_test.mocks.dart';

@GenerateMocks([NequiPay, NequiPaymentResponse])
void main() {
  group('NequiPay Tests', () {
    MockNequiPay _nequiPay = MockNequiPay();
    MockNequiPaymentResponse _nequiPaymentResponse = MockNequiPaymentResponse();
    test('NequiPay Test Types', () async {
      expect(_nequiPay, isA<NequiPay>());
    });
    test('NequiPay Test', () async {
      when(_nequiPay.pay()).thenAnswer((_) async {
        return _nequiPaymentResponse;
      });

      /// ACT
      final _result = await WompiService.pay(paymentProcessor: _nequiPay);

      /// ASSERT
      verify(_nequiPay.pay());
      expect(_result, equals(_nequiPaymentResponse));
    });

    test('Nequi Pay throws ArgumentError', () {
      when(_nequiPay.pay()).thenAnswer((_) {
        throw ArgumentError();
      });
      final _result = WompiService.pay(paymentProcessor: _nequiPay);

      /// ASSERT
      verify(_nequiPay.pay());
      expect(_result, throwsArgumentError);
    });
  });
}
