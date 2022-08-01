import 'package:flutter_test/flutter_test.dart';
import 'package:wompi_payment_colombia/src/src_exports.dart';

void main() {
  group('Wompi Client Tests', () {
    test('Test Client & SandBox URL', () {
      WompiClient _wompiClient = WompiClient(
          publicKey: 'testKey',
          environment: Environment.TEST,
          businessPrefix: 'Pref');
      expect(_wompiClient.publicKey, isA<String>());
      expect(_wompiClient.environment, Environment.TEST);
      expect(_wompiClient.businessPrefix, isA<String>());
      expect(_wompiClient.wompiUrl, 'https://sandbox.wompi.co');
    });
    test(
      "Test Production URL",
      () {
        WompiClient _wompiClient = WompiClient(
            publicKey: 'testKey',
            environment: Environment.PRODUCTION,
            businessPrefix: 'Pref');
        expect(_wompiClient.wompiUrl, 'https://production.wompi.co');
      },
    );
  });
}
