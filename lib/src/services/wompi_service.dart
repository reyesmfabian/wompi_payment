import 'dart:convert';

import 'package:wompi_payment_colombia/src/src_exports.dart';

class WompiService {
  /// Processes the payment using the given payment processor.
  ///
  /// Args:
  /// paymentProcessor (PaymentProcessor): the payment processor to handle the payment.
  ///
  /// Returns:
  ///   A future that resolves to the result of the payment processing.
  static pay({required PaymentProcessor paymentProcessor}) async {
    return paymentProcessor.pay();
  }

  /// Checks the payment status using the given payment checker.
  ///
  /// Args:
  /// paymentChecker (PaymentChecker): the payment checker to verify payment status.
  ///
  /// Returns:
  ///   A future that resolves to the result of the payment check.
  static checkPayment({required PaymentChecker paymentChecker}) async {
    return paymentChecker.checkPayment();
  }

  /// Makes a GET request to the Wompi API to obtain the acceptance token
  ///
  /// Args:
  /// wompiClient (WompiClient): this is the object containing the public key and the url of wompi.
  ///
  /// Returns:
  ///  AcceptanceResponse: The acceptance token response from Wompi API.
  static Future<AcceptanceResponse> getAcceptance(
      {required WompiClient wompiClient}) async {
    String url = wompiClient.wompiUrl;
    String finalUrl = '$url/merchants/${wompiClient.publicKey}';
    Map<String, String> headers = {"Content-type": "application/json"};

    final response =
        await HttpClientAdapter.get(url: finalUrl, headers: headers);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ArgumentError(response.body);
    }

    final acceptanceData =
        AcceptanceResponse.fromJson(json.decode(response.body));

    return acceptanceData;
  }

  /// Retrieve the list of Banks for PSE payments.
  ///
  /// Args:
  /// wompiClient (WompiClient): Client instance with configuration for Wompi API.
  ///
  /// Returns:
  ///   Future<List<Bank>>: A list of banks available for PSE payments.
  static Future<List<Bank>> getBanks({required WompiClient wompiClient}) async {
    String url = wompiClient.wompiUrl;
    String finalUrl = '$url/pse/financial_institutions';

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${wompiClient.publicKey}"
    };

    final response =
        await HttpClientAdapter.get(url: finalUrl, headers: headers);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ArgumentError(response.body);
    }

    final bankResponse = BankModel.fromJson(json.decode(response.body));

    final List<Bank> banks = bankResponse.data;

    return banks;
  }
}
