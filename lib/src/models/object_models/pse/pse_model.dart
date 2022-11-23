import 'dart:convert';

PseRequest pseRequestFromJson(String str) =>
    PseRequest.fromJson(json.decode(str));

String pseRequestToJson(PseRequest data) => json.encode(data.toJson());

/// Creating a new type called PersonType with two possible values: natural and juridica.
enum PersonType { natural, juridica }

/// It's a Dart class that represents a PSE request
class PseRequest {
  PseRequest({
    required this.personType,
    required this.documentType,
    required this.amount,
    required this.bankCode,
    required this.paymentDescription,
  });

  PersonType personType;
  String documentType;
  int amount;
  String bankCode;
  String paymentDescription;

  /// It creates a PseRequest object from a json object.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The json object that contains the data to be converted to a
  /// PseRequest object.
  factory PseRequest.fromJson(Map<String, dynamic> json) => PseRequest(
        personType: PersonType.values.byName(json['personType']),
        documentType: json["documentType"],

        /// It takes the values of the variables in the class and puts them into a map
        amount: json["amount"],
        bankCode: json["bankCode"],
        paymentDescription: json["paymentDescription"],
      );

  Map<String, dynamic> toJson() => {
        "personType": personType,
        "documentType": documentType,
        "amount": amount,
        "bankCode": bankCode,
        "paymentDescription": paymentDescription,
      };
}
