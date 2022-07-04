import 'package:wompi_pago/src/services/wompi_client.dart';
import 'package:wompi_pago/src/services/wompi_service.dart';

abstract class PaymentChecker extends WompiService {
  final String transactionId;
  PaymentChecker(this.transactionId, WompiClient wompiClient)
      : super(wompiClient);

  checkPayment() {}
}
