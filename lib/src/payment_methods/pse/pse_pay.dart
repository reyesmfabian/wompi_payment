import 'dart:async';
import 'dart:convert';

import 'package:wompi_payment_colombia/src/src_exports.dart';

class PsePay extends PaymentProcessor {
  final PseRequest pseRequest;

  PsePay(
      {required this.pseRequest,
      required PaymentRequestData paymentRequest,
      required WompiClient wompiClient})
      : super(paymentRequest: paymentRequest, wompiClient: wompiClient);

  @override
  Future<PsePaymentResponse> pay() async {
    String url = wompiClient.wompiUrl;
    // GENERAR PAGO
    String urlCompleta = "$url/v1/transactions/";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ' + wompiClient.publicKey
    };

    Map<String, dynamic> body = {
      'acceptance_token': paymentRequest.acceptanceToken,
      'public_key': wompiClient.publicKey,
      'amount_in_cents': pseRequest.amount * 100,
      'reference': wompiClient.businessPrefix + paymentRequest.reference,
      'customer_email': paymentRequest.email,
      'currency': wompiClient.currency,
      "payment_method": {
        "type": "PSE",
        "user_type": pseRequest.personType.index,
        "user_legal_id_type": pseRequest.documentType,
        "user_legal_id": paymentRequest.document,
        "financial_institution_code": pseRequest.bankCode,
        "payment_description": pseRequest.paymentDescription
      },
      'customer_data': {
        'phone_number': paymentRequest.phone,
        'full_name': paymentRequest.name
      }
    };

    final response = await HttpClientAdapter.post(
        url: urlCompleta, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final respuestaPago =
          PsePaymentResponse.fromJson(json.decode(response.body));

      final respuestaPse =
          await _checkPaymentUrl(transactionId: respuestaPago.data.id);

      return respuestaPse;
    } else {
      throw ArgumentError(response.body);
    }
  }

  Future<PsePaymentResponse> _checkPaymentUrl(
      {required String transactionId}) async {
    String url = wompiClient.wompiUrl;
    String urlCompleta = "$url/v1/transactions/$transactionId";

    final response = await HttpClientAdapter.get(url: urlCompleta);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ArgumentError(response.body);
    }

    final respuestaConsulta =
        PsePaymentResponse.fromJson(json.decode(response.body));

    if (respuestaConsulta.data.status == "ERROR") {
      throw ArgumentError(respuestaConsulta.data.statusMessage);
    }

    if (respuestaConsulta.data.paymentMethod.extra == null) {
      await Future.delayed(const Duration(seconds: 3));
      return _checkPaymentUrl(transactionId: transactionId);
    }

    return respuestaConsulta;
  }
}
