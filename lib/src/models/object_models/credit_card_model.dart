import 'dart:convert';

CreditCard creditCardFromJson(String str) =>
    CreditCard.fromJson(json.decode(str));

String creditCardToJson(CreditCard data) => json.encode(data.toJson());

/// **_CREAR NUEVA TARJETA DE CRÉDITO_**

class CreditCard {
  CreditCard({
    required this.cardNumber,
    required this.cvcCode,
    required this.expYear,
    required this.expMonth,
    required this.amount,
    required this.quotas,
    required this.cardHolder,
  });

  String cardNumber;
  String cvcCode;
  String expYear;
  String expMonth;
  int amount;
  int quotas;
  String cardHolder;

  factory CreditCard.fromJson(Map<String, dynamic> json) => CreditCard(
        cardNumber: json["card_number"],
        cvcCode: json["cvc_code"],
        expYear: json["exp_year"],
        expMonth: json["exp_month"],
        amount: json["amount"],
        quotas: json["quotas"],
        cardHolder: json["card_holder"],
      );

  Map<String, dynamic> toJson() => {
        "card_number": cardNumber,
        "cvc_code": cvcCode,
        "exp_year": expYear,
        "exp_month": expMonth,
        "amount": amount,
        "quotas": quotas,
        "card_holder": cardHolder,
      };
}
