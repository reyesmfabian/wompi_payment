import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:wompi_payment_colombia/src/src_exports.dart';

class NequiPay extends PaymentProcessor {
  final int amount;
  final String phoneNumberToPay;

  NequiPay(
      {required this.amount,
      required PaymentRequestData paymentRequest,
      required this.phoneNumberToPay,
      required WompiClient wompiClient})
      : super(paymentRequest: paymentRequest, wompiClient: wompiClient);

  @override
  Future<NequiPaymentResponse> pay() async {
    if (phoneNumberToPay.length != 10) {
      throw ArgumentError('The telephone number must be 10 digits long.');
    }

    String url = wompiClient.wompiUrl;
    // GENERAR PAGO
    String finalUrl = "$url/transactions/";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${wompiClient.publicKey}'
    };

    // Encrypt the signature in SHA-256
    final bytes = utf8.encode(
      wompiClient.businessPrefix +
          paymentRequest.reference +
          (amount * 100).toString() +
          wompiClient.currency +
          wompiClient.integrityKey,
    );
    final signatureSha256 = sha256.convert(bytes).toString();

    Map<String, dynamic> body = {
      'acceptance_token': paymentRequest.acceptanceToken,
      'public_key': wompiClient.publicKey,
      'signature': signatureSha256,
      'amount_in_cents': amount * 100,
      'reference': wompiClient.businessPrefix + paymentRequest.reference,
      'customer_email': paymentRequest.email,
      'currency': wompiClient.currency,
      'payment_method': {'type': 'NEQUI', 'phone_number': phoneNumberToPay},
      'customer_data': {
        'phone_number': paymentRequest.phone,
        'full_name': paymentRequest.name
      }
    };

    final response = await HttpClientAdapter.post(
        url: finalUrl, headers: headers, body: body);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ArgumentError(response.body);
    }
    final paymentResponse =
        NequiPaymentResponse.fromJson(json.decode(response.body));

    return paymentResponse;
  }
}
