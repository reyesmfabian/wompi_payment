// To parse this JSON data, do
//
//     final NequiCheckModel = NequiCheckModelFromJson(jsonString);

import 'dart:convert';

NequiCheckModel nequiCheckModelFromJson(String str) =>
    NequiCheckModel.fromJson(json.decode(str));

String nequiCheckModelToJson(NequiCheckModel data) =>
    json.encode(data.toJson());

/// A model class that is used to parse the json response from the API.

class NequiCheckModel {
  NequiCheckModel({
    required this.data,
    required this.meta,
  });

  NequiData data;
  NequiMeta meta;

  factory NequiCheckModel.fromJson(Map<String, dynamic> json) =>
      NequiCheckModel(
        data: NequiData.fromJson(json["data"]),
        meta: NequiMeta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "meta": meta.toJson(),
      };
}

/// A class that represents the data that is returned from the Nequi API.
class NequiData {
  NequiData({
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
  NequiPaymentMethod paymentMethod;
  dynamic redirectUrl;
  String status;
  dynamic statusMessage;
  NequiMerchant merchant;
  List<dynamic> taxes;

  factory NequiData.fromJson(Map<String, dynamic> json) => NequiData(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        amountInCents: json["amount_in_cents"],
        reference: json["reference"],
        currency: json["currency"],
        paymentMethodType: json["payment_method_type"],
        paymentMethod: NequiPaymentMethod.fromJson(json["payment_method"]),
        redirectUrl: json["redirect_url"],
        status: json["status"],
        statusMessage: json["status_message"],
        merchant: NequiMerchant.fromJson(json["merchant"]),
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

/// It's a Dart class that represents a Nequi merchant
class NequiMerchant {
  NequiMerchant({
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
  String logoUrl;
  String legalIdType;
  String email;
  String legalId;

  factory NequiMerchant.fromJson(Map<String, dynamic> json) => NequiMerchant(
        name: json["name"],
        legalName: json["legal_name"],
        contactName: json["contact_name"],
        phoneNumber: json["phone_number"],
        logoUrl: json["logo_url"] ?? "",
        legalIdType: json["legal_id_type"] ?? "",
        email: json["email"] ?? "",
        legalId: json["legal_id"] ?? "",
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

/// It converts the object to a json object
class NequiPaymentMethod {
  NequiPaymentMethod({
    required this.type,
    required this.extra,
    required this.phoneNumber,
  });

  String type;
  NequiExtra extra;
  String phoneNumber;

  /// It converts the object to a json object.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The json object to be converted.
  factory NequiPaymentMethod.fromJson(Map<String, dynamic> json) =>
      NequiPaymentMethod(
        type: json["type"] ?? "",
        extra: NequiExtra.fromJson(json["extra"] ??
            Map<String, dynamic>.from({
              "transaction_id": "",
              "external_identifier": "",
              "nequi_transaction_id": ""
            })),
        phoneNumber: json["phone_number"],
      );

  /// It converts the object to a json object.
  Map<String, dynamic> toJson() => {
        "type": type,
        "extra": extra.toJson(),
        "phone_number": phoneNumber,
      };
}

/// It converts the JSON object to a Dart object.
class NequiExtra {
  NequiExtra({
    required this.transactionId,
    required this.externalIdentifier,
  });

  String transactionId;
  String externalIdentifier;

  /// A factory constructor that creates a new NequiExtra object from a map.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON object that you want to convert to a NequiExtra object.
  factory NequiExtra.fromJson(Map<String, dynamic> json) => NequiExtra(
        transactionId: json["transaction_id"],
        externalIdentifier: json["external_identifier"],
      );

  /// It converts the object to a JSON object.
  Map<String, dynamic> toJson() => {
        "transaction_id": transactionId,
        "external_identifier": externalIdentifier,
      };
}

/// A class that represents the metadata of a Nequi API call.
class NequiMeta {
  NequiMeta({
    required this.traceId,
  });

  String traceId;

  /// It creates a NequiMeta object from a json string.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON object that you want to parse.
  factory NequiMeta.fromJson(Map<String, dynamic> json) => NequiMeta(
        traceId: json["trace_id"],
      );

  Map<String, dynamic> toJson() => {
        "trace_id": traceId,
      };
}
