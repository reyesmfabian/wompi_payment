import 'package:flutter_test/flutter_test.dart';
import 'package:wompi_payment_colombia/src/src_exports.dart';

void main() {
  group('Wompi Client Tests', () {
    test('Test Client & SandBox URL', () {
      WompiClient wompiClient = WompiClient(
        publicKey: 'testKey',
        environment: Environment.TEST,
        businessPrefix: 'Pref',
      );
      expect(wompiClient.publicKey, isA<String>());
      expect(wompiClient.environment, Environment.TEST);
      expect(wompiClient.businessPrefix, isA<String>());
      expect(wompiClient.wompiUrl, 'https://sandbox.wompi.co/v1');
    });
    test(
      "Test Production URL",
      () {
        WompiClient wompiClient = WompiClient(
            publicKey: 'testKey',
            environment: Environment.PRODUCTION,
            businessPrefix: 'Pref');
        expect(wompiClient.wompiUrl, 'https://production.wompi.co/v1');
      },
    );
  });
}
