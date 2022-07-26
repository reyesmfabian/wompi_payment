import 'package:wompi_payment_colombia/src/src_exports.dart';

abstract class PaymentChecker extends WompiService {
  final String transactionId;
  PaymentChecker(this.transactionId, WompiClient wompiClient)
      : super(wompiClient: wompiClient);

  checkPayment() {}
}
