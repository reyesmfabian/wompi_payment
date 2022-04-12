import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'modelos/aceptacion.dart';
import 'modelos/consulta_nequi.dart';
import 'modelos/consulta_tarjeta.dart';
import 'modelos/repuesta_pago_nequi.dart';
import 'modelos/respuesta_pago_tarjeta.dart';
import 'modelos/tarjeta_tokenizada.dart';

enum Ambiente { dev, prod }

class PagoWompi {
  late final String llavePublica;
  late final Ambiente ambiente;
  late final String prefijoComercio;
  String moneda;

  static String sandBoxUrl = "https://sandbox.wompi.co";
  static String productionUrl = "https://production.wompi.co";

  PagoWompi(
      {required this.llavePublica,
      required this.ambiente,
      required this.prefijoComercio,
      this.moneda = 'COP'});

  Future<ModeloAceptacion> obtenerAceptacion() async {
    String url = ambiente == Ambiente.dev ? sandBoxUrl : productionUrl;
    String urlCompleta = "$url/v1/merchants/$llavePublica";
    Map<String, String> headers = {"Content-type": "application/json"};
    final response = await http.get(Uri.parse(urlCompleta), headers: headers);
    final data = ModeloAceptacion.fromJson(json.decode(response.body));
    return data;
  }

  /// **_REALIZAR PAGO CON TARJETA DE CRÉDITO_**
  ///
  /// **[referencia]** es un identificador único para el pago
  ///
  /// **[numeroTarjeta]** es el número de la tarjeta de crédito a utilizar como String
  ///
  /// **[cvc]** es el código de seguridad de la tarjeta de crédito
  ///
  /// **[year]** es el año de expiración de la tarjeta de crédito en formato 'YY'
  ///
  /// **[mes]** es el mes de expiración de la tarjeta de crédito en formato 'MM'
  ///
  /// **[valor]** es el valor del pago expresado en miles de pesos 100000
  ///
  /// **[email]** es el correo electrónico del cliente
  ///
  /// **[cuotas]** es el número de cuotas a pagar en formato '1'
  ///
  /// **[nombre]** es el nombre del cliente
  ///
  /// **[telefono]** es el número de teléfono del cliente
  ///
  /// **[tokenAceptacion]** es el token de aceptación generado por WOMPI
  Future<RespuestaPagoTarjeta> pagarConTarjeta({
    required String referencia,
    required String numeroTarjeta,
    required String cvc,
    required String year,
    required String mes,
    required int valor,
    required String email,
    required int cuotas,
    required String nombre,
    required String telefono,
    required String tokenAceptacion,
  }) async {
    String url = ambiente == Ambiente.dev ? sandBoxUrl : productionUrl;
    String urlCompleta = "$url/v1/tokens/cards";
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer $llavePublica'
    };
    // TOKENIZAR TARJETA DE CRÉDITO
    var response = await http.post(Uri.parse(urlCompleta),
        headers: headers,
        body: jsonEncode({
          'number': numeroTarjeta,
          'cvc': cvc,
          'exp_month': mes,
          'exp_year': year,
          'card_holder': nombre
        }));
    final tarjeta = TarjetaTokenizada.fromJson(json.decode(response.body));
    final tokenTarjeta = tarjeta.data.id;
    // GENERAR PAGO
    urlCompleta = "$url/v1/transactions/";
    headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer $llavePublica'
    };
    response = await http.post(Uri.parse(urlCompleta),
        headers: headers,
        body: jsonEncode({
          'acceptance_token': tokenAceptacion,
          'public_key': llavePublica,
          'amount_in_cents': valor * 100,
          'reference': prefijoComercio + referencia,
          'customer_email': email,
          'currency': moneda,
          'payment_method': {
            'type': 'CARD',
            'installments': cuotas,
            'token': tokenTarjeta
          },
          'customer_data': {'phone_number': telefono, 'full_name': nombre}
        }));
    final respuestaPago =
        RespuestaPagoTarjeta.fromJson(json.decode(response.body));
    return respuestaPago;
  }

  Future<ConsultaTarjeta> consultarTransaccionTarjeta(
      {required String idTransaccion}) async {
    String url = ambiente == Ambiente.dev ? sandBoxUrl : productionUrl;
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
    String url = ambiente == Ambiente.dev ? sandBoxUrl : productionUrl;
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
    String url = ambiente == Ambiente.dev ? sandBoxUrl : productionUrl;
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
