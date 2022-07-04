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
    required this.acceptanceToken,
    required this.reference,
  });

  String email;
  String phone;
  String name;
  String acceptanceToken;
  String reference;

  factory PaymentRequestData.fromJson(Map<String, dynamic> json) =>
      PaymentRequestData(
        email: json["email"],
        phone: json["phone"],
        name: json["name"],
        acceptanceToken: json["acceptance_token"],
        reference: json["reference"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "phone": phone,
        "name": name,
        "acceptance_token": acceptanceToken,
        "reference": reference,
      };
}
