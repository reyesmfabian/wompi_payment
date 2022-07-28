import 'dart:convert';

import 'package:wompi_payment_colombia/src/src_exports.dart';

class NequiCheck extends PaymentChecker {
  NequiCheck({required String transactionId, required WompiClient wompiClient})
      : super(transactionId: transactionId, wompiClient: wompiClient);

  @override
  Future<ConsultaNequi> checkPayment() async {
    String url = wompiClient.wompiUrl;
    String urlCompleta = "$url/v1/transactions/$transactionId";

    final response = await HttpClientAdapter.get(url: urlCompleta);

    if (response.statusCode == 200 || response.statusCode == 201) {
      ConsultaNequi respuestaConsulta =
          ConsultaNequi.fromJson(json.decode(response.body));
      if (respuestaConsulta.data.status == 'PENDING') {
        await Future.delayed(const Duration(seconds: 10));
        return checkPayment();
      }
      return respuestaConsulta;
    } else {
      throw ArgumentError(response.body);
    }
  }
}
