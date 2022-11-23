import 'dart:convert';

PaymentRequestData paymentRequestDataFromJson(String str) =>
    PaymentRequestData.fromJson(json.decode(str));

String paymentRequestDataToJson(PaymentRequestData data) =>
    json.encode(data.toJson());

/// It's a Dart class that has the same properties as the JSON object we want to send to the server
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

  /// A factory constructor that creates a PaymentRequestData object from a json object.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON object that contains the data to be sent to the server.
  factory PaymentRequestData.fromJson(Map<String, dynamic> json) =>
      PaymentRequestData(
        email: json["email"],
        phone: json["phone"],
        name: json["name"],
        document: json["document"],
        acceptanceToken: json["acceptance_token"],
        reference: json["reference"],
      );

  /// It takes the values of the class' attributes and puts them in a map
  Map<String, dynamic> toJson() => {
        "email": email,
        "phone": phone,
        "name": name,
        "document": document,
        "acceptance_token": acceptanceToken,
        "reference": reference,
      };
}
