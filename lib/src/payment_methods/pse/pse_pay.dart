import 'dart:async';
import 'dart:convert';

import 'package:wompi_payment_colombia/src/src_exports.dart';

class PsePay extends PaymentProcessor {
  final PseRequest pseRequest;

  PsePay(
      {required this.pseRequest,
      required PaymentRequestData paymentRequest,
      required WompiClient wompiClient})
      : super(paymentRequest, wompiClient);

  @override
  Future<String> pay() async {
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
      'amount_in_cents': pseRequest.amount * 100,
      'reference': wompiClient.prefijoComercio + paymentRequest.reference,
      'customer_email': paymentRequest.email,
      'currency': wompiClient.moneda,
      "payment_method": {
        "type": "PSE",
        "user_type": pseRequest.tipoPersona,
        "user_legal_id_type": pseRequest.tipoDocumento,
        "user_legal_id": paymentRequest.document,
        "financial_institution_code": pseRequest.bankCode,
        "payment_description": pseRequest.descripcionPago
      },
      'customer_data': {
        'phone_number': paymentRequest.phone,
        'full_name': paymentRequest.name
      }
    };

    final response = await HttpClientAdapter.post(
        url: urlCompleta, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final respuestaPago = RespuestaPse.fromJson(json.decode(response.body));

      final urlPago =
          await _checkPaymentUrl(transactionId: respuestaPago.data.id);

      return urlPago;
    } else {
      throw ArgumentError(response.body);
    }
  }

  Future<String> _checkPaymentUrl({required String transactionId}) async {
    String url = wompiClient.wompiUrl;
    String urlCompleta = "$url/v1/transactions/$transactionId";

    final response = await HttpClientAdapter.get(url: urlCompleta);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final respuestaConsulta =
          RespuestaPse.fromJson(json.decode(response.body));

      if (respuestaConsulta.data.paymentMethod.extra == null) {
        Timer(const Duration(seconds: 2), () {
          _checkPaymentUrl(transactionId: transactionId);
        });
      }
      return respuestaConsulta.data.paymentMethod.extra!.asyncPaymentUrl;
    } else {
      throw ArgumentError(response.body);
    }
  }
}
