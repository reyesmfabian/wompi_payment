import 'dart:convert';
import 'package:wompi_pago/src/src_exports.dart';

class NequiPay extends PaymentProcessor {
  final int amount;
  NequiPay(
      {required this.amount,
      required PaymentRequestData paymentRequest,
      required WompiClient wompiClient})
      : super(paymentRequest, wompiClient);

  @override
  Future<RespuestaPagoNequi> pay() async {
    String url = wompiClient.wompiUrl;
    // GENERAR PAGO
    String urlCompleta = "$url/v1/transactions/";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer' + wompiClient.llavePublica
    };

    Map<String, dynamic> body = {
      'acceptance_token': paymentRequest.acceptanceToken,
      'public_key': wompiClient.llavePublica,
      'amount_in_cents': amount * 100,
      'reference': wompiClient.prefijoComercio + paymentRequest.reference,
      'customer_email': paymentRequest.email,
      'currency': wompiClient.moneda,
      'payment_method': {
        'type': 'NEQUI',
        'phone_number': paymentRequest.phone,
      },
      'customer_data': {
        'phone_number': paymentRequest.phone,
        'full_name': paymentRequest.name
      }
    };

    final response = await HttpClientAdapter.post(
        url: urlCompleta, headers: headers, body: body);

    final respuestaPago =
        RespuestaPagoNequi.fromJson(json.decode(response.body));
    return respuestaPago;
  }
}
