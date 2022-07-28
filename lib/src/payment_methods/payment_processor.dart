import 'package:wompi_payment_colombia/src/src_exports.dart';

abstract class PaymentProcessor {
  final WompiClient wompiClient;

  final PaymentRequestData paymentRequest;
  PaymentProcessor({required this.paymentRequest, required this.wompiClient});

  pay() {}
}
