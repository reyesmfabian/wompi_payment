import 'dart:async';
import 'dart:convert';

import 'package:wompi_payment_colombia/src/src_exports.dart';

/// Check credit card payment status
///
/// Args:
///
/// **transactionId (String):** The transaction id.
///
/// **wompiClient (WompiClient):** The WompiClient instance.
///
class CreditCardCheck extends PaymentChecker {
  CreditCardCheck(
      {required String transactionId, required WompiClient wompiClient})
      : super(transactionId: transactionId, wompiClient: wompiClient);

  /// Check the status of the transaction.
  ///
  /// Returns:
  /// A Future<CardCheckModel> object.
  @override
  Future<CardCheckModel> checkPayment() async {
    String url = wompiClient.wompiUrl;
    String finalUrl = "$url/v1/transactions/$transactionId";

    final response = await HttpClientAdapter.get(url: finalUrl);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ArgumentError(response.body);
    }

    /// Converting the response body to a CardCheckModel object.

    final checkResponse = CardCheckModel.fromJson(json.decode(response.body));

    /// This is a recursive function that checks the status of the transaction every 10 seconds until the
    /// transaction is approved or rejected.
    if (checkResponse.data.status == 'PENDING') {
      await Future.delayed(const Duration(seconds: 10));
      return checkPayment();
    }

    return checkResponse;
  }
}
