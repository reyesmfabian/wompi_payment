import 'dart:convert';
import 'package:wompi_payment_colombia/src/src_exports.dart';

class NequiPay extends PaymentProcessor {
  final int amount;
  final String phoneNumberToPay;

  NequiPay(
      {required this.amount,
      required PaymentRequestData paymentRequest,
      required this.phoneNumberToPay,
      required WompiClient wompiClient})
      : super(paymentRequest: paymentRequest, wompiClient: wompiClient);

  @override
  Future<RespuestaPagoNequi> pay() async {
    if (phoneNumberToPay.length != 10) {
      throw ArgumentError('El numero de teléfono debe tener 10 dígitos');
    }

    String url = wompiClient.wompiUrl;
    // GENERAR PAGO
    String urlCompleta = "$url/v1/transactions/";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ' + wompiClient.llavePublica
    };

    Map<String, dynamic> body = {
      'acceptance_token': paymentRequest.acceptanceToken,
      'public_key': wompiClient.llavePublica,
      'amount_in_cents': amount * 100,
      'reference': wompiClient.prefijoComercio + paymentRequest.reference,
      'customer_email': paymentRequest.email,
      'currency': wompiClient.moneda,
      'payment_method': {'type': 'NEQUI', 'phone_number': phoneNumberToPay},
      'customer_data': {
        'phone_number': paymentRequest.phone,
        'full_name': paymentRequest.name
      }
    };

    final response = await HttpClientAdapter.post(
        url: urlCompleta, headers: headers, body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final respuestaPago =
          RespuestaPagoNequi.fromJson(json.decode(response.body));
      return respuestaPago;
    } else {
      throw ArgumentError(response.body);
    }
  }
}
