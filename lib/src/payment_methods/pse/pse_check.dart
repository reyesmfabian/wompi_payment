import 'dart:async';
import 'dart:convert';

import 'package:wompi_payment_colombia/src/src_exports.dart';

/// A class that extends [PaymentChecker] to implement the PSE payment
/// verification process.
///
/// This class provides an implementation of the [checkPayment] method
/// specific to PSE payment method using the Wompi API.
class PseCheck extends PaymentChecker {
  /// Constructs a [PseCheck] instance requiring a [transactionId]
  /// and a [wompiClient] to communicate with the Wompi API.
  PseCheck({
    required String transactionId,
    required WompiClient wompiClient,
    this.loopUntilStatusChange = true,
  }) : super(transactionId: transactionId, wompiClient: wompiClient);

  final bool loopUntilStatusChange;

  /// Checks the status of a PSE payment transaction.
  ///
  /// It constructs the URL for the Wompi API request using the [transactionId]
  /// and sends a GET request via [HttpClientAdapter]. If the status code of
  /// the response is not 200 or 201, an [ArgumentError] is thrown.
  ///
  /// On a successful response, it decodes the body of the response and
  /// constructs a [PsePaymentResponse] using the decoded JSON data.
  ///
  /// Returns a [Future] that completes with a [PsePaymentResponse] object
  /// representing the status of the payment transaction.
  @override
  Future<PsePaymentResponse> checkPayment() async {
    String url = wompiClient.wompiUrl;
    String finalUrl = "$url/transactions/$transactionId";

    final response = await HttpClientAdapter.get(url: finalUrl);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ArgumentError(response.body);
    }

    final checkResponse =
        PsePaymentResponse.fromJson(json.decode(response.body));

    if (checkResponse.data.status == 'PENDING' && loopUntilStatusChange) {
      await Future.delayed(const Duration(seconds: 10));
      return checkPayment();
    }

    return checkResponse;
  }
}
