// To parse this JSON data, do
//
//     final consultaTarjeta = consultaTarjetaFromJson(jsonString);

import 'dart:convert';

ConsultaTarjeta consultaTarjetaFromJson(String str) =>
    ConsultaTarjeta.fromJson(json.decode(str));

String consultaTarjetaToJson(ConsultaTarjeta data) =>
    json.encode(data.toJson());

class ConsultaTarjeta {
  ConsultaTarjeta({
    required this.data,
    required this.meta,
  });

  CardData data;
  CardMeta meta;

  factory ConsultaTarjeta.fromJson(Map<String, dynamic> json) =>
      ConsultaTarjeta(
        data: CardData.fromJson(json["data"]),
        meta: CardMeta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "meta": meta.toJson(),
      };
}

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
  DateTime createdAt;
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

  factory CardData.fromJson(Map<String, dynamic> json) => CardData(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
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

class CardPaymentMethod {
  CardPaymentMethod({
    required this.type,
    required this.extra,
    required this.installments,
  });

  String type;
  CardExtra extra;
  int installments;

  factory CardPaymentMethod.fromJson(Map<String, dynamic> json) =>
      CardPaymentMethod(
        type: json["type"],
        extra: CardExtra.fromJson(json["extra"]),
        installments: json["installments"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "extra": extra.toJson(),
        "installments": installments,
      };
}

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

  factory CardExtra.fromJson(Map<String, dynamic> json) => CardExtra(
        name: json["name"],
        brand: json["brand"],
        lastFour: json["last_four"],
        externalIdentifier: json["external_identifier"] ?? "",
        processorResponseCode: json["processor_response_code"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "brand": brand,
        "last_four": lastFour,
        "external_identifier": externalIdentifier,
        "processor_response_code": processorResponseCode,
      };
}

class CardMeta {
  CardMeta({
    required this.traceId,
  });

  String traceId;

  factory CardMeta.fromJson(Map<String, dynamic> json) => CardMeta(
        traceId: json["trace_id"],
      );

  Map<String, dynamic> toJson() => {
        "trace_id": traceId,
      };
}
