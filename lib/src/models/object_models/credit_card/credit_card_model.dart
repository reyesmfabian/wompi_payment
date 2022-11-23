import 'dart:convert';

CreditCard creditCardFromJson(String str) =>
    CreditCard.fromJson(json.decode(str));

String creditCardToJson(CreditCard data) => json.encode(data.toJson());

/// **_CREATE NEW CREDIT CARD_**

/// Create new credit card
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

  /// It creates a CreditCard object from a json object.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The json object that contains the credit card information.
  factory CreditCard.fromJson(Map<String, dynamic> json) => CreditCard(
        cardNumber: json["card_number"],
        cvcCode: json["cvc_code"],
        expYear: json["exp_year"],
        expMonth: json["exp_month"],
        amount: json["amount"],
        quotas: json["quotas"],
        cardHolder: json["card_holder"],
      );

  /// It takes the values of the variables in the class and puts them in a map
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
