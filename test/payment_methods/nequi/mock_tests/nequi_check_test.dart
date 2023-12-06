import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wompi_payment_colombia/src/src_exports.dart';

class MockNequiCheck extends Mock implements NequiCheck {}

class MockNequiCheckModel extends Mock implements NequiCheckModel {}

void main() {
  group('Nequi Check Tests', () {
    MockNequiCheck nequiCheck = MockNequiCheck();
    MockNequiCheckModel nequiCheckModel = MockNequiCheckModel();
    test('Nequi Check Types', () async {
      expect(nequiCheck, isA<NequiCheck>());
    });
    test('Nequi Check  Test', () async {
      when(() => nequiCheck.checkPayment()).thenAnswer((_) async {
        return nequiCheckModel;
      });

      /// ACT
      final result =
          await WompiService.checkPayment(paymentChecker: nequiCheck);

      /// ASSERT
      verify(() => nequiCheck.checkPayment());
      expect(result, equals(nequiCheckModel));
    });

    test('Nequi Check  throws ArgumentError', () {
      when(() => nequiCheck.checkPayment()).thenAnswer((_) {
        throw ArgumentError();
      });
      final result = WompiService.checkPayment(paymentChecker: nequiCheck);
      verify(() => nequiCheck.checkPayment());
      expect(result, throwsArgumentError);
    });
  });
}
