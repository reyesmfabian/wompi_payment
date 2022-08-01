import 'dart:async';
import 'dart:convert';

import 'package:wompi_payment_colombia/src/src_exports.dart';

class PseCheck extends PaymentChecker {
  PseCheck({required String transactionId, required WompiClient wompiClient})
      : super(transactionId: transactionId, wompiClient: wompiClient);

  @override
  Future<PsePaymentResponse> checkPayment() async {
    String url = wompiClient.wompiUrl;
    String urlCompleta = "$url/v1/transactions/$transactionId";

    // Map<String, String> headers = {
    //   "Content-type": "application/json",
    //   'Authorization': 'Bearer' + wompiClient.publicKey
    // };

    final response = await HttpClientAdapter.get(url: urlCompleta);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ArgumentError(response.body);
    }
    final respuestaConsulta =
        PsePaymentResponse.fromJson(json.decode(response.body));
    return respuestaConsulta;
  }
}
