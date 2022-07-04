import 'dart:async';
import 'dart:convert';

import 'package:wompi_pago/src/adapters/http_client.dart';
import 'package:wompi_pago/src/models/response_models/consulta_nequi.dart';
import 'package:wompi_pago/src/payment_methods/payment_checker.dart';
import 'package:wompi_pago/src/services/wompi_client.dart';

class NequiCheck extends PaymentChecker {
  NequiCheck({required String transactionId, required WompiClient wompiClient})
      : super(transactionId, wompiClient);

  @override
  Future<ConsultaNequi> checkPayment() async {
    String url = wompiClient.wompiUrl;
    String urlCompleta = "$url/v1/transactions/$transactionId";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer' + wompiClient.llavePublica
    };

    final response =
        await HttpClientAdapter.get(url: urlCompleta, headers: headers);

    final respuestaConsulta =
        ConsultaNequi.fromJson(json.decode(response.body));
    if (respuestaConsulta.data.status == 'PENDING') {
      Timer(const Duration(seconds: 2), () {
        checkPayment();
      });
    }
    return respuestaConsulta;
  }
}
