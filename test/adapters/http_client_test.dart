import 'package:flutter_test/flutter_test.dart';
import 'package:wompi_payment_colombia/wompi_payment_colombia.dart';

void main() {
  group('HttClientAdapter Tests', () {
    test('Http Get Test', () async {
      final response =
          await HttpClientAdapter.get(url: 'https://www.google.com');
      expect(response, isNotNull);
    });
    test('Http Post Test', () async {
      final response =
          await HttpClientAdapter.post(url: 'https://www.google.com');
      expect(response.statusCode, 405);
    });
  });
}
