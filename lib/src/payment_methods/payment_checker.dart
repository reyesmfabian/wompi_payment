import 'package:wompi_payment_colombia/src/src_exports.dart';

abstract class PaymentChecker {
  final String transactionId;
  final WompiClient wompiClient;
  PaymentChecker({required this.transactionId, required this.wompiClient});

  checkPayment() {}
}
