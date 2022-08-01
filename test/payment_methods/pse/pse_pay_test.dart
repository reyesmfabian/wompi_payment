import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wompi_payment_colombia/src/src_exports.dart';

import 'pse_pay_test.mocks.dart';

@GenerateMocks([PsePay, PsePaymentResponse])
void main() {
  group('PsePay Tests', () {
    MockPsePay _psePay = MockPsePay();
    MockPsePaymentResponse _psePaymentResponse = MockPsePaymentResponse();
    test('PsePay Test Types', () async {
      expect(_psePay, isA<PsePay>());
    });
    test('PsePay Test', () async {
      when(_psePay.pay()).thenAnswer((_) async {
        return _psePaymentResponse;
      });

      /// ACT
      final _result = await WompiService.pay(paymentProcessor: _psePay);

      /// ASSERT
      verify(_psePay.pay());
      expect(_result, equals(_psePaymentResponse));
    });

    test('PsePay throws ArgumentError', () {
      when(_psePay.pay()).thenAnswer((_) {
        throw ArgumentError();
      });
      final _result = WompiService.pay(paymentProcessor: _psePay);

      /// ASSERT
      verify(_psePay.pay());
      expect(_result, throwsArgumentError);
    });
  });
}
