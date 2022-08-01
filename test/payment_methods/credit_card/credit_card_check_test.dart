import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wompi_payment_colombia/src/src_exports.dart';

import 'credit_card_check_test.mocks.dart';

@GenerateMocks([CreditCardCheck, CardCheckModel])
void main() {
  group('Credit Card Check Tests', () {
    MockCreditCardCheck _creditCardCheck = MockCreditCardCheck();
    MockCardCheckModel _cardCheckModel = MockCardCheckModel();
    test('CreditCard Check Types', () async {
      expect(_creditCardCheck, isA<CreditCardCheck>());
    });
    test('CreditCard Check  Test', () async {
      when(_creditCardCheck.checkPayment()).thenAnswer((_) async {
        return _cardCheckModel;
      });

      /// ACT
      final _result =
          await WompiService.checkPayment(paymentChecker: _creditCardCheck);

      /// ASSERT
      verify(_creditCardCheck.checkPayment());
      expect(_result, equals(_cardCheckModel));
    });

    test('CreditCard Check  throws ArgumentError', () {
      when(_creditCardCheck.checkPayment()).thenAnswer((_) {
        throw ArgumentError();
      });
      final _result =
          WompiService.checkPayment(paymentChecker: _creditCardCheck);
      verify(_creditCardCheck.checkPayment());
      expect(_result, throwsArgumentError);
    });
  });
}
