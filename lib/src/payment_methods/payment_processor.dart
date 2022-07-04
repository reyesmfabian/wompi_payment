import 'package:wompi_pago/src/models/object_models/payment_request_model.dart';
import 'package:wompi_pago/src/services/wompi_client.dart';
import 'package:wompi_pago/src/services/wompi_service.dart';

abstract class PaymentProcessor extends WompiService {
  final PaymentRequestData paymentRequest;
  PaymentProcessor(this.paymentRequest, WompiClient wompiClient)
      : super(wompiClient);

  pay() {}
}
