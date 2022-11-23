import 'dart:convert';

import 'package:wompi_payment_colombia/src/src_exports.dart';

/// **_PAY BY CREDIT CARD_**
///
/// It creates a credit card token, then uses that token to create a payment
class CreditCardPay extends PaymentProcessor {
  final CreditCard creditCard;

  CreditCardPay(
      {required this.creditCard,
      required PaymentRequestData paymentRequest,
      required WompiClient wompiClient})
      : super(paymentRequest: paymentRequest, wompiClient: wompiClient);

  @override
  Future<CardPaymentResponse> pay() async {
    String url = wompiClient.wompiUrl;
    String finalUrl = "$url/v1/tokens/cards";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ' + wompiClient.publicKey
    };

    Map<String, dynamic> body = {
      'number': creditCard.cardNumber,
      'cvc': creditCard.cvcCode,
      'exp_month': creditCard.expMonth,
      'exp_year': creditCard.expYear,
      'card_holder': creditCard.cardHolder
    };

    // CREDIT CARD TOKENIZATION
    var response = await HttpClientAdapter.post(
        url: finalUrl, headers: headers, body: body);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ArgumentError(response.body);
    }

    /// Converting the response body to a TokenizedCard object.
    final tokenizedCard = TokenizedCard.fromJson(json.decode(response.body));

    final cardToken = tokenizedCard.data.id;

    // GENERATE PAYMENT
    finalUrl = "$url/v1/transactions/";

    headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ' + wompiClient.publicKey
    };

    body = {
      'acceptance_token': paymentRequest.acceptanceToken,
      'public_key': wompiClient.publicKey,
      'amount_in_cents': creditCard.amount * 100,
      'reference': wompiClient.businessPrefix + paymentRequest.reference,
      'customer_email': paymentRequest.email,
      'currency': wompiClient.currency,
      'payment_method': {
        'type': 'CARD',
        'installments': creditCard.quotas,
        'token': cardToken
      },
      'customer_data': {
        'phone_number': paymentRequest.phone,
        'full_name': paymentRequest.name
      }
    };

    /// A wrapper for the http package.
    response = await HttpClientAdapter.post(
        url: finalUrl, headers: headers, body: body);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ArgumentError(response.body);
    }

    /// Converting the response body to a CardPaymentResponse object.
    final paymentResponse =
        CardPaymentResponse.fromJson(json.decode(response.body));

    return paymentResponse;
  }
}
