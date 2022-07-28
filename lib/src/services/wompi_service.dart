import 'dart:convert';
import 'package:wompi_payment_colombia/src/src_exports.dart';

class WompiService {
  static pay({required PaymentProcessor paymentProcessor}) async {
    return paymentProcessor.pay();
  }

  static checkPayment({required PaymentChecker paymentChecker}) async {
    return paymentChecker.checkPayment();
  }

  static Future<ModeloAceptacion> getAcceptanceToken(
      {required WompiClient wompiClient}) async {
    String _url = wompiClient.wompiUrl;
    String urlCompleta = '$_url/v1/merchants/' + wompiClient.llavePublica;
    Map<String, String> headers = {"Content-type": "application/json"};
    final response =
        await HttpClientAdapter.get(url: urlCompleta, headers: headers);
    final data = ModeloAceptacion.fromJson(json.decode(response.body));
    return data;
  }
}
