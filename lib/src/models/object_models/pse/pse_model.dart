import 'dart:convert';

PseRequest pseRequestFromJson(String str) =>
    PseRequest.fromJson(json.decode(str));

String pseRequestToJson(PseRequest data) => json.encode(data.toJson());

enum PersonType { natural, juridica }

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

  factory PseRequest.fromJson(Map<String, dynamic> json) => PseRequest(
        personType: PersonType.values.byName(json['personType']),
        documentType: json["documentType"],
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
