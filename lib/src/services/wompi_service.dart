import 'dart:convert';

import 'package:wompi_payment_colombia/src/src_exports.dart';

class WompiService {
  static pay({required PaymentProcessor paymentProcessor}) async {
    return paymentProcessor.pay();
  }

  static checkPayment({required PaymentChecker paymentChecker}) async {
    return paymentChecker.checkPayment();
  }

  /// Makes a GET request to the Wompi API to obtain the acceptance token
  ///
  /// Args:
  /// wompiClient (WompiClient): this is the object containing the public key and the url of wompi.
  ///
  /// Returns:
  ///  AcceptResponse.
  static Future<AcceptanceResponse> getAcceptance(
      {required WompiClient wompiClient}) async {
    String _url = wompiClient.wompiUrl;
    String urlCompleta = '$_url/v1/merchants/' + wompiClient.publicKey;
    Map<String, String> headers = {"Content-type": "application/json"};

    final response =
        await HttpClientAdapter.get(url: urlCompleta, headers: headers);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ArgumentError(response.body);
    }

    final acceptanceData =
        AcceptanceResponse.fromJson(json.decode(response.body));

    return acceptanceData;
  }

  /// Retrieve the list of Banks for PSE payments.
  static Future<List<Bank>> getBanks({required WompiClient wompiClient}) async {
    String _url = wompiClient.wompiUrl;
    String urlCompleta = '$_url/v1/pse/financial_institutions';

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer " + wompiClient.publicKey
    };

    final response =
        await HttpClientAdapter.get(url: urlCompleta, headers: headers);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ArgumentError(response.body);
    }

    final bankResponse = BankModel.fromJson(json.decode(response.body));

    final List<Bank> banks = bankResponse.data;

    return banks;
  }
}
