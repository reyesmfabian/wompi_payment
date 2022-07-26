import 'dart:async';
import 'dart:convert';

import 'package:wompi_payment_colombia/src/src_exports.dart';

class PseCheck extends PaymentChecker {
  PseCheck({required String transactionId, required WompiClient wompiClient})
      : super(transactionId, wompiClient);

  @override
  Future<RespuestaPse> checkPayment() async {
    String url = wompiClient.wompiUrl;
    String urlCompleta = "$url/v1/transactions/$transactionId";

    // Map<String, String> headers = {
    //   "Content-type": "application/json",
    //   'Authorization': 'Bearer' + wompiClient.llavePublica
    // };

    final response = await HttpClientAdapter.get(url: urlCompleta);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final respuestaConsulta =
          RespuestaPse.fromJson(json.decode(response.body));

      if (respuestaConsulta.data.status == 'PENDING') {
        Timer(const Duration(seconds: 2), () {
          checkPayment();
        });
      }
      return respuestaConsulta;
    } else {
      throw ArgumentError(response.body);
    }
  }
}
