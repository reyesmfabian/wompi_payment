import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wompi_payment_colombia/src/src_exports.dart';

// ignore: constant_identifier_names
enum Ambiente { TEST, PRODUCTION }

class WompiClient {
  late final String llavePublica;
  late final Ambiente ambiente;
  late final String prefijoComercio;
  String moneda;

  static String sandBoxUrl = "https://sandbox.wompi.co";
  static String productionUrl = "https://production.wompi.co";

  WompiClient(
      {required this.llavePublica,
      required this.ambiente,
      required this.prefijoComercio,
      this.moneda = 'COP'});

  String get wompiUrl =>
      ambiente == Ambiente.PRODUCTION ? productionUrl : sandBoxUrl;

  Future<ModeloAceptacion> getAcceptanceToken() async {
    String _url = wompiUrl;
    String urlCompleta = '$_url/v1/merchants/' + llavePublica;
    Map<String, String> headers = {"Content-type": "application/json"};
    final response = await http.get(Uri.parse(urlCompleta), headers: headers);
    final data = ModeloAceptacion.fromJson(json.decode(response.body));
    return data;
  }

  pay({required PaymentProcessor paymentProcessor}) async {
    return paymentProcessor.pay();
  }

  checkPayment({required PaymentChecker paymentChecker}) async {
    return paymentChecker.checkPayment();
  }
}
