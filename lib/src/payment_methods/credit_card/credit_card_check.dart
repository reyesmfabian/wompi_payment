import 'dart:convert';

import 'package:wompi_pago/src/adapters/http_client.dart';
import 'package:wompi_pago/src/models/response_models/consulta_tarjeta.dart';
import 'package:wompi_pago/src/payment_methods/payment_checker.dart';
import 'package:wompi_pago/src/services/wompi_client.dart';

class CreditCardCheck extends PaymentChecker {
  CreditCardCheck(
      {required String transactionId, required WompiClient wompiClient})
      : super(transactionId, wompiClient);

  @override
  Future<ConsultaTarjeta> checkPayment() async {
    String url = wompiClient.wompiUrl;
    String urlCompleta = "$url/v1/transactions/$transactionId";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer' + wompiClient.llavePublica
    };

    final response =
        await HttpClientAdapter.get(url: urlCompleta, headers: headers);

    final respuestaConsulta =
        ConsultaTarjeta.fromJson(json.decode(response.body));
    if (respuestaConsulta.data.status == 'PENDING') {
      checkPayment();
    }
    return respuestaConsulta;
  }
}
