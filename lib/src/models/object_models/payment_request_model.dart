import 'dart:convert';

PaymentRequestData paymentRequestDataFromJson(String str) =>
    PaymentRequestData.fromJson(json.decode(str));

String paymentRequestDataToJson(PaymentRequestData data) =>
    json.encode(data.toJson());

class PaymentRequestData {
  PaymentRequestData({
    required this.email,
    required this.phone,
    required this.name,
    required this.reference,
    required this.acceptanceToken,
    required this.document,
  });

  String email;
  String phone;
  String name;
  String reference;
  String acceptanceToken;
  String document;

  factory PaymentRequestData.fromJson(Map<String, dynamic> json) =>
      PaymentRequestData(
        email: json["email"],
        phone: json["phone"],
        name: json["name"],
        document: json["document"],
        acceptanceToken: json["acceptance_token"],
        reference: json["reference"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "phone": phone,
        "name": name,
        "document": document,
        "acceptance_token": acceptanceToken,
        "reference": reference,
      };
}
