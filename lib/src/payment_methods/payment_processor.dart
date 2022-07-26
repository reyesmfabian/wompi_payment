import 'package:wompi_payment_colombia/src/src_exports.dart';

abstract class PaymentProcessor extends WompiService {
  final PaymentRequestData paymentRequest;
  PaymentProcessor(this.paymentRequest, WompiClient wompiClient)
      : super(wompiClient: wompiClient);

  pay() {}
}
