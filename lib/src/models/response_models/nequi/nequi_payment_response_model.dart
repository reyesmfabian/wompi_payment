import 'dart:convert';

NequiPaymentResponse nequiPaymentResponseFromJson(String str) =>
    NequiPaymentResponse.fromJson(json.decode(str));

String nequiPaymentResponseToJson(NequiPaymentResponse data) =>
    json.encode(data.toJson());

class NequiPaymentResponse {
  NequiPaymentResponse({
    required this.data,
    required this.meta,
  });

  NequiResponseData data;
  NequiResponseMeta meta;

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
  });

  String id;
  DateTime createdAt;
  dynamic finalizedAt;
  int amountInCents;
  String reference;
  String customerEmail;
  String currency;
  String paymentMethodType;
  NequiResponsePaymentMethod paymentMethod;
  String status;
  dynamic statusMessage;
  dynamic billingData;
  dynamic shippingAddress;
  dynamic redirectUrl;
  dynamic paymentSourceId;
  dynamic paymentLinkId;
  NequiResponseCustomerData customerData;
  dynamic billId;
  List<dynamic> taxes;

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
        paymentMethod:
            NequiResponsePaymentMethod.fromJson(json["payment_method"]),
        status: json["status"],
        statusMessage: json["status_message"],
        billingData: json["billing_data"],
        shippingAddress: json["shipping_address"],
        redirectUrl: json["redirect_url"],
        paymentSourceId: json["payment_source_id"],
        paymentLinkId: json["payment_link_id"],
        customerData: NequiResponseCustomerData.fromJson(json["customer_data"]),
        billId: json["bill_id"],
        taxes: List<dynamic>.from(json["taxes"].map((x) => x)),
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
      };
}

class NequiResponseCustomerData {
  NequiResponseCustomerData({
    required this.fullName,
    required this.phoneNumber,
  });

  String fullName;
  String phoneNumber;

  factory NequiResponseCustomerData.fromJson(Map<String, dynamic> json) =>
      NequiResponseCustomerData(
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "phone_number": phoneNumber,
      };
}

class NequiResponsePaymentMethod {
  NequiResponsePaymentMethod({
    required this.type,
    required this.phoneNumber,
  });

  String type;
  String phoneNumber;

  factory NequiResponsePaymentMethod.fromJson(Map<String, dynamic> json) =>
      NequiResponsePaymentMethod(
        type: json["type"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "phone_number": phoneNumber,
      };
}

class NequiResponseMeta {
  NequiResponseMeta({
    required this.traceId,
  });

  String traceId;

  factory NequiResponseMeta.fromJson(Map<String, dynamic> json) =>
      NequiResponseMeta(
        traceId: json["trace_id"],
      );

  Map<String, dynamic> toJson() => {
        "trace_id": traceId,
      };
}
