import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wompi_payment_colombia/src/src_exports.dart';

import 'pse_check_test.mocks.dart';

@GenerateMocks([PseCheck, PsePaymentResponse])
void main() {
  group('Pse Check Tests', () {
    MockPseCheck _pseCheck = MockPseCheck();
    MockPsePaymentResponse _psePaymentResponse = MockPsePaymentResponse();
    test('Pse Check Types', () async {
      expect(_pseCheck, isA<PseCheck>());
    });
    test('Pse Check  Test', () async {
      when(_pseCheck.checkPayment()).thenAnswer((_) async {
        return _psePaymentResponse;
      });

      /// ACT
      final _result =
          await WompiService.checkPayment(paymentChecker: _pseCheck);

      /// ASSERT
      verify(_pseCheck.checkPayment());
      expect(_result, equals(_psePaymentResponse));
    });

    test('Pse Check throws ArgumentError', () {
      when(_pseCheck.checkPayment()).thenAnswer((_) {
        throw ArgumentError();
      });
      final _result = WompiService.checkPayment(paymentChecker: _pseCheck);
      verify(_pseCheck.checkPayment());
      expect(_result, throwsArgumentError);
    });
  });
}
