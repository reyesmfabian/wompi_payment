import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wompi_payment_colombia/src/src_exports.dart';

class MockNequiCheck extends Mock implements NequiCheck {}

class MockNequiCheckModel extends Mock implements NequiCheckModel {}

void main() {
  group('Nequi Check Tests', () {
    MockNequiCheck _nequiCheck = MockNequiCheck();
    MockNequiCheckModel _nequiCheckModel = MockNequiCheckModel();
    test('Nequi Check Types', () async {
      expect(_nequiCheck, isA<NequiCheck>());
    });
    test('Nequi Check  Test', () async {
      when(() => _nequiCheck.checkPayment()).thenAnswer((_) async {
        return _nequiCheckModel;
      });

      /// ACT
      final _result =
          await WompiService.checkPayment(paymentChecker: _nequiCheck);

      /// ASSERT
      verify(() => _nequiCheck.checkPayment());
      expect(_result, equals(_nequiCheckModel));
    });

    test('Nequi Check  throws ArgumentError', () {
      when(() => _nequiCheck.checkPayment()).thenAnswer((_) {
        throw ArgumentError();
      });
      final _result = WompiService.checkPayment(paymentChecker: _nequiCheck);
      verify(() => _nequiCheck.checkPayment());
      expect(_result, throwsArgumentError);
    });
  });
}
