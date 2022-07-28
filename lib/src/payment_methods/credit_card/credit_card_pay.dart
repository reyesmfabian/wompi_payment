import 'dart:convert';

import 'package:wompi_payment_colombia/src/src_exports.dart';

/// **_PAGAR POR MEDIO DE TARJETA DE CRÉDITO_**
///
class CreditCardPay extends PaymentProcessor {
  final CreditCard creditCard;

  CreditCardPay(
      {required this.creditCard,
      required PaymentRequestData paymentRequest,
      required WompiClient wompiClient})
      : super(paymentRequest: paymentRequest, wompiClient: wompiClient);

  @override
  Future<RespuestaPagoTarjeta> pay() async {
    String url = wompiClient.wompiUrl;
    String urlCompleta = "$url/v1/tokens/cards";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ' + wompiClient.llavePublica
    };

    Map<String, dynamic> body = {
      'number': creditCard.cardNumber,
      'cvc': creditCard.cvcCode,
      'exp_month': creditCard.expMonth,
      'exp_year': creditCard.expYear,
      'card_holder': creditCard.cardHolder
    };

    // TOKENIZAR TARJETA DE CRÉDITO
    var response = await HttpClientAdapter.post(
        url: urlCompleta, headers: headers, body: body);

    final tarjeta = TarjetaTokenizada.fromJson(json.decode(response.body));

    final tokenTarjeta = tarjeta.data.id;

    // GENERAR PAGO
    urlCompleta = "$url/v1/transactions/";

    headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ' + wompiClient.llavePublica
    };

    body = {
      'acceptance_token': paymentRequest.acceptanceToken,
      'public_key': wompiClient.llavePublica,
      'amount_in_cents': creditCard.amount * 100,
      'reference': wompiClient.prefijoComercio + paymentRequest.reference,
      'customer_email': paymentRequest.email,
      'currency': wompiClient.moneda,
      'payment_method': {
        'type': 'CARD',
        'installments': creditCard.quotas,
        'token': tokenTarjeta
      },
      'customer_data': {
        'phone_number': paymentRequest.phone,
        'full_name': paymentRequest.name
      }
    };

    response = await HttpClientAdapter.post(
        url: urlCompleta, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final respuestaPago =
          RespuestaPagoTarjeta.fromJson(json.decode(response.body));
      return respuestaPago;
    } else {
      throw ArgumentError(response.body);
    }
  }
}
