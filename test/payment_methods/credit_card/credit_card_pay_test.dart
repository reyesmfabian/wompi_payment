import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wompi_payment_colombia/src/src_exports.dart';

import 'credit_card_pay_test.mocks.dart';

@GenerateMocks([CreditCardPay, CardPaymentResponse])
void main() {
  group('CreditCardPay Tests', () {
    MockCreditCardPay _creditCardPay = MockCreditCardPay();
    MockCardPaymentResponse _cardPaymentResponse = MockCardPaymentResponse();
    test('CreditCardPay Test Types', () async {
      expect(_creditCardPay, isA<CreditCardPay>());
    });
    test('CreditCardPay Test', () async {
      when(_creditCardPay.pay()).thenAnswer((_) async {
        return _cardPaymentResponse;
      });

      /// ACT
      final _result = await WompiService.pay(paymentProcessor: _creditCardPay);

      /// ASSERT
      verify(_creditCardPay.pay());
      expect(_result, equals(_cardPaymentResponse));
    });

    test('Credit Card Pay throws ArgumentError', () {
      when(_creditCardPay.pay()).thenAnswer((_) {
        throw ArgumentError();
      });
      final _result = WompiService.pay(paymentProcessor: _creditCardPay);

      /// ASSERT
      verify(_creditCardPay.pay());
      expect(_result, throwsArgumentError);
    });
  });
}
