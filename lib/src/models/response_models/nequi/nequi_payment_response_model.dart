import 'dart:convert';

NequiPaymentResponse nequiPaymentResponseFromJson(String str) =>
    NequiPaymentResponse.fromJson(json.decode(str));

String nequiPaymentResponseToJson(NequiPaymentResponse data) =>
    json.encode(data.toJson());

class NequiPaymentResponse {
  final NequiResponseData data;
  final NequiResponseMeta meta;

  NequiPaymentResponse({
    required this.data,
    required this.meta,
  });

  factory NequiPaymentResponse.fromJson(Map<String, dynamic> json) =>
      NequiPaymentResponse(
        data: NequiResponseData.fromJson(json["data"]),
        meta: NequiResponseMeta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "meta": meta.toJson(),
      };
}

class NequiResponseData {
  final String id;
  final DateTime createdAt;
  final dynamic finalizedAt;
  final int amountInCents;
  final String reference;
  final String customerEmail;
  final String currency;
  final String paymentMethodType;
  final PaymentMethod paymentMethod;
  final String status;
  final dynamic statusMessage;
  final dynamic billingData;
  final dynamic shippingAddress;
  final dynamic redirectUrl;
  final dynamic paymentSourceId;
  final dynamic paymentLinkId;
  final CustomerData customerData;
  final dynamic billId;
  final List<dynamic> taxes;
  final dynamic tipInCents;

  NequiResponseData({
    required this.id,
    required this.createdAt,
    required this.finalizedAt,
    required this.amountInCents,
    required this.reference,
    required this.customerEmail,
    required this.currency,
    required this.paymentMethodType,
    required this.paymentMethod,
    required this.status,
    required this.statusMessage,
    required this.billingData,
    required this.shippingAddress,
    required this.redirectUrl,
    required this.paymentSourceId,
    required this.paymentLinkId,
    required this.customerData,
    required this.billId,
    required this.taxes,
    required this.tipInCents,
  });

  factory NequiResponseData.fromJson(Map<String, dynamic> json) =>
      NequiResponseData(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        finalizedAt: json["finalized_at"],
        amountInCents: json["amount_in_cents"],
        reference: json["reference"],
        customerEmail: json["customer_email"],
        currency: json["currency"],
        paymentMethodType: json["payment_method_type"],
        paymentMethod: PaymentMethod.fromJson(json["payment_method"]),
        status: json["status"],
        statusMessage: json["status_message"],
        billingData: json["billing_data"],
        shippingAddress: json["shipping_address"],
        redirectUrl: json["redirect_url"],
        paymentSourceId: json["payment_source_id"],
        paymentLinkId: json["payment_link_id"],
        customerData: CustomerData.fromJson(json["customer_data"]),
        billId: json["bill_id"],
        taxes: List<dynamic>.from(json["taxes"].map((x) => x)),
        tipInCents: json["tip_in_cents"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "finalized_at": finalizedAt,
        "amount_in_cents": amountInCents,
        "reference": reference,
        "customer_email": customerEmail,
        "currency": currency,
        "payment_method_type": paymentMethodType,
        "payment_method": paymentMethod.toJson(),
        "status": status,
        "status_message": statusMessage,
        "billing_data": billingData,
        "shipping_address": shippingAddress,
        "redirect_url": redirectUrl,
        "payment_source_id": paymentSourceId,
        "payment_link_id": paymentLinkId,
        "customer_data": customerData.toJson(),
        "bill_id": billId,
        "taxes": List<dynamic>.from(taxes.map((x) => x)),
        "tip_in_cents": tipInCents,
      };
}

class CustomerData {
  final String fullName;
  final String phoneNumber;

  CustomerData({
    required this.fullName,
    required this.phoneNumber,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "phone_number": phoneNumber,
      };
}

class PaymentMethod {
  final String type;
  final Extra extra;
  final String phoneNumber;

  PaymentMethod({
    required this.type,
    required this.extra,
    required this.phoneNumber,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        type: json["type"],
        extra: Extra.fromJson(json["extra"]),
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "extra": extra.toJson(),
        "phone_number": phoneNumber,
      };
}

class Extra {
  final bool isThreeDs;

  Extra({
    required this.isThreeDs,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        isThreeDs: json["is_three_ds"],
      );

  Map<String, dynamic> toJson() => {
        "is_three_ds": isThreeDs,
      };
}

class NequiResponseMeta {
  NequiResponseMeta();

  factory NequiResponseMeta.fromJson(Map<String, dynamic> json) =>
      NequiResponseMeta();

  Map<String, dynamic> toJson() => {};
}
