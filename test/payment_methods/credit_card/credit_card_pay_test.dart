import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wompi_payment_colombia/src/src_exports.dart';

class MockCreditCardPay extends Mock implements CreditCardPay {}

class MockCardPaymentResponse extends Mock implements CardPaymentResponse {}

void main() {
  MockCreditCardPay creditCardPay = MockCreditCardPay();
  MockCardPaymentResponse _cardPaymentResponse = MockCardPaymentResponse();
  group('CreditCardPay Tests', () {
    test('CreditCardPay Test Types', () async {
      expect(creditCardPay, isA<CreditCardPay>());
    });
    test('CreditCardPay Test', () async {
      when(() => creditCardPay.pay()).thenAnswer((_) async {
        return _cardPaymentResponse;
      });

      /// ACT
      final _result = await WompiService.pay(paymentProcessor: creditCardPay);

      /// ASSERT
      verify(() => creditCardPay.pay());
      expect(_result, equals(_cardPaymentResponse));
    });

    test('Credit Card Pay throws ArgumentError', () {
      when(() => creditCardPay.pay()).thenAnswer((_) {
        throw ArgumentError();
      });
      final _result = WompiService.pay(paymentProcessor: creditCardPay);

      /// ASSERT
      verify(() => creditCardPay.pay());
      expect(_result, throwsArgumentError);
    });
  });
}
