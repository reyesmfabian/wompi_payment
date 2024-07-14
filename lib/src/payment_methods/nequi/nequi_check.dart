import 'dart:convert';

import 'package:wompi_payment_colombia/src/src_exports.dart';

/// Checks the status of a transaction and returns a NequiCheckModel object.
class NequiCheck extends PaymentChecker {
  NequiCheck({
    required String transactionId,
    required WompiClient wompiClient,
    this.loopUntilStatusChange = true,
  }) : super(transactionId: transactionId, wompiClient: wompiClient);

  final bool loopUntilStatusChange;

  @override
  Future<NequiCheckModel> checkPayment() async {
    String url = wompiClient.wompiUrl;
    String finalUrl = "$url/transactions/$transactionId";

    final response = await HttpClientAdapter.get(url: finalUrl);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ArgumentError(response.body);
    }

    NequiCheckModel checkResponse =
        NequiCheckModel.fromJson(json.decode(response.body));

    if (checkResponse.data.status == 'PENDING' && loopUntilStatusChange) {
      await Future.delayed(const Duration(seconds: 10));
      return checkPayment();
    }

    return checkResponse;
  }
}
