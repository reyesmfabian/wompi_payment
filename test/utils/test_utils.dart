import 'package:wompi_payment_colombia/wompi_payment_colombia.dart';

abstract class TestUtils {
  static const String customerEmail = ''; // Test Email
  static const String customerPhone = ''; // Test User Phone Must be 10 digits
  static const String customerName = ''; // Test User Name
  static const String customerDocument = ''; // Test User Document
  static const String nequiNumberToPayApproved = "3991111111";
  static const String nequiNumberToPayDeclined = "3992222222";
  static const int amountToPay = 25000;

  static WompiClient wompiClient = WompiClient(
    publicKey: '', // Business Sandbox PublicKey
    environment: Environment.TEST,
    businessPrefix: '', // Business Prefix
    currency: 'COP',
  );
}
