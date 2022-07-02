import 'dart:convert';

import 'package:wompi_pago/modelos/object_models/credit_card_model.dart';
import 'package:wompi_pago/modelos/object_models/payment_request_model.dart';
import 'package:wompi_pago/modelos/response_models/respuesta_pago_tarjeta.dart';
import 'package:wompi_pago/modelos/response_models/tarjeta_tokenizada.dart';
import 'package:wompi_pago/services.dart/wompi_client.dart';
import 'package:http/http.dart' as http;

import '../selected_payment_method.dart';

class CreditCardPay extends SelectedPaymentMethod {
  final CreditCard creditCard;

  CreditCardPay(
      {required this.creditCard,
      required PaymentRequestData paymentRequest,
      required WompiClient wompiClient})
      : super(paymentRequest, wompiClient);

  @override

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
  Future<void> pay() async {
    print(paymentRequest.toJson());
    print(wompiClient.ambiente);
    print(creditCard.toJson());
    // String url = wompiClient.url;
    // String urlCompleta = "$url/v1/tokens/cards";
    // Map<String, String> headers = {
    //   "Content-type": "application/json",
    //   'Authorization': 'Bearer $wompiClient.llavePublica'
    // };
    // // TOKENIZAR TARJETA DE CRÉDITO
    // var response = await http.post(Uri.parse(urlCompleta),
    //     headers: headers,
    //     body: jsonEncode({
    //       'number': creditCard.cardNumber,
    //       'cvc': creditCard.cvcCode,
    //       'exp_month': creditCard.expMonth,
    //       'exp_year': creditCard.expYear,
    //       'card_holder': creditCard.cardHolder
    //     }));
    // final tarjeta = TarjetaTokenizada.fromJson(json.decode(response.body));

    // final tokenTarjeta = tarjeta.data.id;
    // // GENERAR PAGO
    // urlCompleta = "$url/v1/transactions/";
    // headers = {
    //   "Content-type": "application/json",
    //   'Authorization': 'Bearer $wompiClient.llavePublica'
    // };
    // response = await http.post(Uri.parse(urlCompleta),
    //     headers: headers,
    //     body: jsonEncode({
    //       'acceptance_token': paymentRequest.acceptanceToken,
    //       'public_key': wompiClient.llavePublica,
    //       'amount_in_cents': creditCard.amount * 100,
    //       'reference': wompiClient.prefijoComercio + paymentRequest.reference,
    //       'customer_email': paymentRequest.email,
    //       'currency': wompiClient.moneda,
    //       'payment_method': {
    //         'type': 'CARD',
    //         'installments': creditCard.quotas,
    //         'token': tokenTarjeta
    //       },
    //       'customer_data': {
    //         'phone_number': paymentRequest.phone,
    //         'full_name': paymentRequest.name
    //       }
    //     }));
    // final respuestaPago =
    //     RespuestaPagoTarjeta.fromJson(json.decode(response.body));
    // return respuestaPago;
  }

  @override
  void checkPayment() {
    // TODO: implement checkPayment
  }
}

test() {
  WompiClient wompiClient = WompiClient(
      ambiente: Ambiente.PRODUCCION,
      llavePublica: 'llave publica',
      prefijoComercio: 'prefijo comercio');
  CreditCard creditCard = CreditCard(
      cardNumber: '1212121',
      cvcCode: '212121',
      expYear: '212121',
      expMonth: '2121',
      amount: 21212,
      quotas: 2121,
      cardHolder: 'fabian');
  PaymentRequestData paymentRequest = PaymentRequestData(
      acceptanceToken: 'token',
      email: 'test@mail.com',
      name: 'pagador',
      phone: '333333',
      reference: 'referencia');
  CreditCardPay creditCardPay = CreditCardPay(
      creditCard: creditCard,
      paymentRequest: paymentRequest,
      wompiClient: wompiClient);
  creditCardPay.pay();
}
