import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wompi_pago/modelos/response_models/aceptacion.dart';
import 'package:wompi_pago/modelos/response_models/consulta_nequi.dart';
import 'package:wompi_pago/modelos/response_models/consulta_tarjeta.dart';
import 'package:wompi_pago/modelos/response_models/repuesta_pago_nequi.dart';
import 'package:wompi_pago/modelos/response_models/respuesta_pago_tarjeta.dart';
import 'package:wompi_pago/modelos/response_models/tarjeta_tokenizada.dart';
import 'package:wompi_pago/payment_methods/wompi/wompi_methods/selected_payment_method.dart';

enum Ambiente { PRUEBAS, PRODUCCION }

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

  get url => ambiente == Ambiente.PRODUCCION ? productionUrl : sandBoxUrl;

  pay({required SelectedPaymentMethod paymentMethod}) async {
    paymentMethod.pay();
  }

  checkPayment({required SelectedPaymentMethod paymentMethod}) async {
    paymentMethod.checkPayment();
  }

  Future<ModeloAceptacion> obtenerAceptacion() async {
    String url = ambiente == Ambiente.PRUEBAS ? sandBoxUrl : productionUrl;
    String urlCompleta = "$url/v1/merchants/$llavePublica";
    Map<String, String> headers = {"Content-type": "application/json"};
    final response = await http.get(Uri.parse(urlCompleta), headers: headers);
    final data = ModeloAceptacion.fromJson(json.decode(response.body));
    return data;
  }

  Future<ConsultaTarjeta> consultarTransaccionTarjeta(
      {required String idTransaccion}) async {
    String url = ambiente == Ambiente.PRUEBAS ? sandBoxUrl : productionUrl;
    String urlCompleta = "$url/v1/transactions/$idTransaccion";
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer $llavePublica'
    };
    final response = await http.get(Uri.parse(urlCompleta), headers: headers);
    final respuestaConsulta =
        ConsultaTarjeta.fromJson(json.decode(response.body));
    if (respuestaConsulta.data.status == 'PENDING') {
      consultarTransaccionTarjeta(idTransaccion: idTransaccion);
    }
    return respuestaConsulta;
  }

  Future<RespuestaPagoNequi> pagarConNequi({
    required String referencia,
    required int valor,
    required String email,
    required String nombre,
    required String telefono,
    required String tokenAceptacion,
  }) async {
    String url = ambiente == Ambiente.PRUEBAS ? sandBoxUrl : productionUrl;
    // GENERAR PAGO
    String urlCompleta = "$url/v1/transactions/";
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer $llavePublica'
    };
    final response = await http.post(Uri.parse(urlCompleta),
        headers: headers,
        body: jsonEncode({
          'acceptance_token': tokenAceptacion,
          'public_key': llavePublica,
          'amount_in_cents': valor * 100,
          'reference': prefijoComercio + referencia,
          'customer_email': email,
          'currency': moneda,
          'payment_method': {
            'type': 'NEQUI',
            'phone_number': telefono,
          },
          'customer_data': {'phone_number': telefono, 'full_name': nombre}
        }));
    final respuestaPago =
        RespuestaPagoNequi.fromJson(json.decode(response.body));
    return respuestaPago;
  }

  Future<ConsultaNequi> consultarTransaccionNequi(
      {required String idTransaccion}) async {
    String url = ambiente == Ambiente.PRUEBAS ? sandBoxUrl : productionUrl;
    String urlCompleta = "$url/v1/transactions/$idTransaccion";
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer $llavePublica'
    };
    final response = await http.get(Uri.parse(urlCompleta), headers: headers);
    final respuestaConsulta =
        ConsultaNequi.fromJson(json.decode(response.body));
    if (respuestaConsulta.data.status == 'PENDING') {
      Timer(const Duration(seconds: 2), () {
        consultarTransaccionNequi(idTransaccion: idTransaccion);
      });
    }
    return respuestaConsulta;
  }
}
