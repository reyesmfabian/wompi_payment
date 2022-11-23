import 'dart:async';
import 'dart:convert';

import 'package:wompi_payment_colombia/src/src_exports.dart';

/// Comprueba el estado del pago con tarjeta de crédito
///
/// Args:
///
/// **transactionId (String):** El id de la transacción.
///
/// **wompiClient (WompiClient):** La instancia de WompiClient.
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

    final checkResponse = CardCheckModel.fromJson(json.decode(response.body));

    if (checkResponse.data.status == 'PENDING') {
      await Future.delayed(const Duration(seconds: 10));
      return checkPayment();
    }

    return checkResponse;
  }
}
