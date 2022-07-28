import 'dart:async';
import 'dart:convert';

import 'package:wompi_payment_colombia/src/src_exports.dart';

/// Comprueba el estado del pago con tarjeta de crédito
///
/// Args:
///
/// **transactionId (String):** El id de la transacción.
///
/// **wompiClient (WompiClient):** La instancia de WompiClient.
///
class CreditCardCheck extends PaymentChecker {
  CreditCardCheck(
      {required String transactionId, required WompiClient wompiClient})
      : super(transactionId: transactionId, wompiClient: wompiClient);

  /// Comprueba el estado de la transacción.
  ///
  /// Returns:
  ///   Un objeto Future<ConsultaTarjeta>.
  @override
  Future<ConsultaTarjeta> checkPayment() async {
    String url = wompiClient.wompiUrl;
    String urlCompleta = "$url/v1/transactions/$transactionId";

    // Map<String, String> headers = {
    //   "Content-type": "application/json",
    //   'Authorization': 'Bearer' + wompiClient.llavePublica
    // };

    final response = await HttpClientAdapter.get(url: urlCompleta);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final respuestaConsulta =
          ConsultaTarjeta.fromJson(json.decode(response.body));
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
