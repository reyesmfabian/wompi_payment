import 'dart:convert';

CardCheckModel cardCheckModelFromJson(String str) =>
    CardCheckModel.fromJson(json.decode(str));

String cardCheckModelToJson(CardCheckModel data) => json.encode(data.toJson());

/// A model class for the CardCheck API response.
class CardCheckModel {
  CardCheckModel({
    required this.data,
    required this.meta,
  });

  CardData data;
  CardMeta meta;

  factory CardCheckModel.fromJson(Map<String, dynamic> json) => CardCheckModel(
        data: CardData.fromJson(json["data"]),
        meta: CardMeta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "meta": meta.toJson(),
      };
}

/// A Dart class that is used to parse the JSON response from the API.
class CardData {
  CardData({
    required this.id,
    required this.createdAt,
    required this.amountInCents,
    required this.reference,
    required this.currency,
    required this.paymentMethodType,
    required this.paymentMethod,
    required this.redirectUrl,
    required this.status,
    required this.statusMessage,
    required this.merchant,
    required this.taxes,
  });

  String id;
  Object createdAt;
  int amountInCents;
  String reference;
  String currency;
  String paymentMethodType;
  CardPaymentMethod paymentMethod;
  dynamic redirectUrl;
  String status;
  dynamic statusMessage;
  CardMerchant merchant;
  List<dynamic> taxes;

  /// A factory constructor that takes in a json object and returns a CardData object.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON object that you want to convert to a CardData object.
  factory CardData.fromJson(Map<String, dynamic> json) => CardData(
        id: json["id"],
        createdAt: json["created_at"],
        amountInCents: json["amount_in_cents"],
        reference: json["reference"],
        currency: json["currency"],
        paymentMethodType: json["payment_method_type"],
        paymentMethod: CardPaymentMethod.fromJson(json["payment_method"]),
        redirectUrl: json["redirect_url"],
        status: json["status"],
        statusMessage: json["status_message"],
        merchant: CardMerchant.fromJson(json["merchant"]),
        taxes: List<dynamic>.from(json["taxes"].map((x) => x)),
      );

  /// It converts the object into a JSON object

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "amount_in_cents": amountInCents,
        "reference": reference,
        "currency": currency,
        "payment_method_type": paymentMethodType,
        "payment_method": paymentMethod.toJson(),
        "redirect_url": redirectUrl,
        "status": status,
        "status_message": statusMessage,
        "merchant": merchant.toJson(),
        "taxes": List<dynamic>.from(taxes.map((x) => x)),
      };
}

/// A Dart class that represents a CardMerchant object.
class CardMerchant {
  CardMerchant({
    required this.name,
    required this.legalName,
    required this.contactName,
    required this.phoneNumber,
    required this.logoUrl,
    required this.legalIdType,
    required this.email,
    required this.legalId,
  });

  String name;
  String legalName;
  String contactName;
  String phoneNumber;
  dynamic logoUrl;
  String legalIdType;
  String email;
  String legalId;

  /// A factory constructor that creates a CardMerchant object from a json string.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON object that contains the data to be parsed.
  factory CardMerchant.fromJson(Map<String, dynamic> json) => CardMerchant(
        name: json["name"],
        legalName: json["legal_name"],
        contactName: json["contact_name"],
        phoneNumber: json["phone_number"],
        logoUrl: json["logo_url"],
        legalIdType: json["legal_id_type"],
        email: json["email"],
        legalId: json["legal_id"],
      );

  /// It converts the object to a map.
  Map<String, dynamic> toJson() => {
        "name": name,
        "legal_name": legalName,
        "contact_name": contactName,
        "phone_number": phoneNumber,
        "logo_url": logoUrl,
        "legal_id_type": legalIdType,
        "email": email,
        "legal_id": legalId,
      };
}

/// A Dart class that is used to create a CardPaymentMethod object.
class CardPaymentMethod {
  CardPaymentMethod({
    required this.type,
    required this.extra,
    required this.installments,
  });

  String type;
  CardExtra extra;
  int installments;

  /// It creates a CardPaymentMethod object from a json object.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON object that you want to parse.
  factory CardPaymentMethod.fromJson(Map<String, dynamic> json) =>
      CardPaymentMethod(
        type: json["type"],
        extra: CardExtra.fromJson(json["extra"]),
        installments: json["installments"],
      );

  /// It converts the object to a json object.
  Map<String, dynamic> toJson() => {
        "type": type,
        "extra": extra.toJson(),
        "installments": installments,
      };
}

/// `CardExtra` is a class that represents the extra information about a card
class CardExtra {
  CardExtra({
    required this.name,
    required this.brand,
    required this.lastFour,
    required this.externalIdentifier,
    required this.processorResponseCode,
  });

  String name;
  String brand;
  String lastFour;
  String externalIdentifier;
  String processorResponseCode;

  /// A factory constructor that takes in a json object and returns a CardExtra object.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON object that contains the data for the card.
  factory CardExtra.fromJson(Map<String, dynamic> json) => CardExtra(
        name: json["name"],
        brand: json["brand"],
        lastFour: json["last_four"],
        externalIdentifier: json["external_identifier"] ?? "",
        processorResponseCode: json["processor_response_code"] ?? "",
      );

  /// It converts the object to a JSON object.
  Map<String, dynamic> toJson() => {
        "name": name,
        "brand": brand,
        "last_four": lastFour,
        "external_identifier": externalIdentifier,
        "processor_response_code": processorResponseCode,
      };
}

/// A Dart class that is used to parse the JSON response from the API.
class CardMeta {
  CardMeta();

  factory CardMeta.fromJson(Map<String, dynamic> json) => CardMeta();

  Map<String, dynamic> toJson() => {};
}
