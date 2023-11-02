import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart'; // Importa mocktail en lugar de mockito
import 'package:wompi_payment_colombia/src/src_exports.dart';

class MockCreditCardCheck extends Mock implements CreditCardCheck {}

class MockCardCheckModel extends Mock implements CardCheckModel {}

void main() {
  CreditCardCheck creditCardCheck = MockCreditCardCheck();
  CardCheckModel cardCheckModel = MockCardCheckModel();

  group('Credit Card Check Tests', () {
    test('CreditCard Check  Test', () async {
      // Configura el comportamiento del mock con when
      when(() => creditCardCheck.checkPayment()).thenAnswer((_) async {
        return cardCheckModel;
      });

      // ACT
      final _result =
          await WompiService.checkPayment(paymentChecker: creditCardCheck);

      // ASSERT
      expect(_result, equals(cardCheckModel));
    });

    test('CreditCard Check  throws ArgumentError', () {
      // Configura el comportamiento del mock para que lance ArgumentError
      when(() => creditCardCheck.checkPayment()).thenThrow(ArgumentError());

      // ACT
      final _result =
          WompiService.checkPayment(paymentChecker: creditCardCheck);

      // ASSERT
      expect(() => _result, throwsArgumentError);
    });
  });
}
