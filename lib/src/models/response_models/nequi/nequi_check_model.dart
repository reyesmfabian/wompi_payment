import 'dart:convert';

NequiCheckModel nequiCheckModelFromJson(String str) =>
    NequiCheckModel.fromJson(json.decode(str));

String nequiCheckModelToJson(NequiCheckModel data) =>
    json.encode(data.toJson());

class NequiCheckModel {
  final NequiData data;
  final NequiMeta meta;

  NequiCheckModel({
    required this.data,
    required this.meta,
  });

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

class NequiData {
  final String id;
  final DateTime createdAt;
  final DateTime finalizedAt;
  final int amountInCents;
  final String reference;
  final String currency;
  final String paymentMethodType;
  final NequiPaymentMethod paymentMethod;
  final dynamic paymentLinkId;
  final dynamic redirectUrl;
  final String status;
  final dynamic statusMessage;
  final Merchant merchant;
  final List<dynamic> taxes;
  final dynamic tipInCents;

  NequiData({
    required this.id,
    required this.createdAt,
    required this.finalizedAt,
    required this.amountInCents,
    required this.reference,
    required this.currency,
    required this.paymentMethodType,
    required this.paymentMethod,
    required this.paymentLinkId,
    required this.redirectUrl,
    required this.status,
    required this.statusMessage,
    required this.merchant,
    required this.taxes,
    required this.tipInCents,
  });

  factory NequiData.fromJson(Map<String, dynamic> json) => NequiData(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        finalizedAt: DateTime.parse(json["finalized_at"]),
        amountInCents: json["amount_in_cents"],
        reference: json["reference"],
        currency: json["currency"],
        paymentMethodType: json["payment_method_type"],
        paymentMethod: NequiPaymentMethod.fromJson(json["payment_method"]),
        paymentLinkId: json["payment_link_id"],
        redirectUrl: json["redirect_url"],
        status: json["status"],
        statusMessage: json["status_message"],
        merchant: Merchant.fromJson(json["merchant"]),
        taxes: List<dynamic>.from(json["taxes"].map((x) => x)),
        tipInCents: json["tip_in_cents"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "finalized_at": finalizedAt.toIso8601String(),
        "amount_in_cents": amountInCents,
        "reference": reference,
        "currency": currency,
        "payment_method_type": paymentMethodType,
        "payment_method": paymentMethod.toJson(),
        "payment_link_id": paymentLinkId,
        "redirect_url": redirectUrl,
        "status": status,
        "status_message": statusMessage,
        "merchant": merchant.toJson(),
        "taxes": List<dynamic>.from(taxes.map((x) => x)),
        "tip_in_cents": tipInCents,
      };
}

class Merchant {
  final int id;
  final String name;
  final String legalName;
  final String contactName;
  final String phoneNumber;
  final dynamic logoUrl;
  final String legalIdType;
  final String email;
  final String legalId;
  final String publicKey;

  Merchant({
    required this.id,
    required this.name,
    required this.legalName,
    required this.contactName,
    required this.phoneNumber,
    required this.logoUrl,
    required this.legalIdType,
    required this.email,
    required this.legalId,
    required this.publicKey,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
        id: json["id"],
        name: json["name"],
        legalName: json["legal_name"],
        contactName: json["contact_name"],
        phoneNumber: json["phone_number"],
        logoUrl: json["logo_url"],
        legalIdType: json["legal_id_type"],
        email: json["email"],
        legalId: json["legal_id"],
        publicKey: json["public_key"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "legal_name": legalName,
        "contact_name": contactName,
        "phone_number": phoneNumber,
        "logo_url": logoUrl,
        "legal_id_type": legalIdType,
        "email": email,
        "legal_id": legalId,
        "public_key": publicKey,
      };
}

class NequiPaymentMethod {
  final String type;
  final NequiExtra extra;
  final String phoneNumber;

  NequiPaymentMethod({
    required this.type,
    required this.extra,
    required this.phoneNumber,
  });

  factory NequiPaymentMethod.fromJson(Map<String, dynamic> json) =>
      NequiPaymentMethod(
        type: json["type"],
        extra: NequiExtra.fromJson(json["extra"]),
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "extra": extra.toJson(),
        "phone_number": phoneNumber,
      };
}

class NequiExtra {
  final bool isThreeDs;
  final String transactionId;
  final String externalIdentifier;

  NequiExtra({
    required this.isThreeDs,
    required this.transactionId,
    required this.externalIdentifier,
  });

  factory NequiExtra.fromJson(Map<String, dynamic> json) => NequiExtra(
        isThreeDs: json["is_three_ds"],
        transactionId: json["transaction_id"],
        externalIdentifier: json["external_identifier"],
      );

  Map<String, dynamic> toJson() => {
        "is_three_ds": isThreeDs,
        "transaction_id": transactionId,
        "external_identifier": externalIdentifier,
      };
}

class NequiMeta {
  NequiMeta();

  factory NequiMeta.fromJson(Map<String, dynamic> json) => NequiMeta();

  Map<String, dynamic> toJson() => {};
}
