import 'package:wompi_pago/modelos/object_models/payment_request_model.dart';
import 'package:wompi_pago/services.dart/wompi_client.dart';
import 'package:wompi_pago/services.dart/wompi_service.dart';

abstract class SelectedPaymentMethod extends WompiService {
  final PaymentRequestData paymentRequest;
  SelectedPaymentMethod(this.paymentRequest, WompiClient wompiClient)
      : super(wompiClient);

  void pay() {}
  void checkPayment() {}
}
