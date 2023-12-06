import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wompi_payment_colombia/src/src_exports.dart';

class MockCreditCardPay extends Mock implements CreditCardPay {}

class MockCardPaymentResponse extends Mock implements CardPaymentResponse {}

void main() {
  MockCreditCardPay creditCardPay = MockCreditCardPay();
  MockCardPaymentResponse cardPaymentResponse = MockCardPaymentResponse();
  group('CreditCardPay Tests', () {
    test('CreditCardPay Test Types', () async {
      expect(creditCardPay, isA<CreditCardPay>());
    });
    test('CreditCardPay Test', () async {
      when(() => creditCardPay.pay()).thenAnswer((_) async {
        return cardPaymentResponse;
      });

      /// ACT
      final result = await WompiService.pay(paymentProcessor: creditCardPay);

      /// ASSERT
      verify(() => creditCardPay.pay());
      expect(result, equals(cardPaymentResponse));
    });

    test('Credit Card Pay throws ArgumentError', () {
      when(() => creditCardPay.pay()).thenAnswer((_) {
        throw ArgumentError();
      });
      final result0 = WompiService.pay(paymentProcessor: creditCardPay);

      /// ASSERT
      verify(() => creditCardPay.pay());
      expect(result0, throwsArgumentError);
    });
  });
}
