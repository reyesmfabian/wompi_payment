import 'dart:convert';

import 'package:wompi_payment_colombia/src/src_exports.dart';

class NequiCheck extends PaymentChecker {
  NequiCheck({required String transactionId, required WompiClient wompiClient})
      : super(transactionId: transactionId, wompiClient: wompiClient);

  @override
  Future<NequiCheckModel> checkPayment() async {
    String url = wompiClient.wompiUrl;
    String finalUrl = "$url/v1/transactions/$transactionId";

    final response = await HttpClientAdapter.get(url: finalUrl);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ArgumentError(response.body);
    }

    NequiCheckModel checkResponse =
        NequiCheckModel.fromJson(json.decode(response.body));

    if (checkResponse.data.status == 'PENDING') {
      await Future.delayed(const Duration(seconds: 10));
      return checkPayment();
    }

    return checkResponse;
  }
}
