import 'dart:convert';

TokenizedCard tokenizedCardFromJson(String str) =>
    TokenizedCard.fromJson(json.decode(str));

String tokenizedCardToJson(TokenizedCard data) => json.encode(data.toJson());

class TokenizedCard {
  TokenizedCard({
    required this.status,
    required this.data,
  });

  String status;
  TokenizedCardData data;

  factory TokenizedCard.fromJson(Map<String, dynamic> json) => TokenizedCard(
        status: json["status"],
        data: TokenizedCardData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class TokenizedCardData {
  TokenizedCardData({
    required this.id,
    required this.createdAt,
    required this.brand,
    required this.name,
    required this.lastFour,
    required this.bin,
    required this.expYear,
    required this.expMonth,
    required this.cardHolder,
    required this.expiresAt,
  });

  String id;
  DateTime createdAt;
  String brand;
  String name;
  String lastFour;
  String bin;
  String expYear;
  String expMonth;
  String cardHolder;
  DateTime expiresAt;

  factory TokenizedCardData.fromJson(Map<String, dynamic> json) =>
      TokenizedCardData(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        brand: json["brand"],
        name: json["name"],
        lastFour: json["last_four"],
        bin: json["bin"],
        expYear: json["exp_year"],
        expMonth: json["exp_month"],
        cardHolder: json["card_holder"],
        expiresAt: DateTime.parse(json["expires_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "brand": brand,
        "name": name,
        "last_four": lastFour,
        "bin": bin,
        "exp_year": expYear,
        "exp_month": expMonth,
        "card_holder": cardHolder,
        "expires_at": expiresAt.toIso8601String(),
      };
}
