import 'dart:convert';

RespuestaPagoNequi respuestaPagoNequiFromJson(String str) =>
    RespuestaPagoNequi.fromJson(json.decode(str));

String respuestaPagoNequiToJson(RespuestaPagoNequi data) =>
    json.encode(data.toJson());

class RespuestaPagoNequi {
  RespuestaPagoNequi({
    required this.data,
    required this.meta,
  });

  RespuestaNequiData data;
  RespuestaNequiMeta meta;

  factory RespuestaPagoNequi.fromJson(Map<String, dynamic> json) =>
      RespuestaPagoNequi(
        data: RespuestaNequiData.fromJson(json["data"]),
        meta: RespuestaNequiMeta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "meta": meta.toJson(),
      };
}

class RespuestaNequiData {
  RespuestaNequiData({
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
  RespuestaNequiPaymentMethod paymentMethod;
  String status;
  dynamic statusMessage;
  dynamic billingData;
  dynamic shippingAddress;
  dynamic redirectUrl;
  dynamic paymentSourceId;
  dynamic paymentLinkId;
  RespuestaNequiCustomerData customerData;
  dynamic billId;
  List<dynamic> taxes;

  factory RespuestaNequiData.fromJson(Map<String, dynamic> json) =>
      RespuestaNequiData(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        finalizedAt: json["finalized_at"],
        amountInCents: json["amount_in_cents"],
        reference: json["reference"],
        customerEmail: json["customer_email"],
        currency: json["currency"],
        paymentMethodType: json["payment_method_type"],
        paymentMethod:
            RespuestaNequiPaymentMethod.fromJson(json["payment_method"]),
        status: json["status"],
        statusMessage: json["status_message"],
        billingData: json["billing_data"],
        shippingAddress: json["shipping_address"],
        redirectUrl: json["redirect_url"],
        paymentSourceId: json["payment_source_id"],
        paymentLinkId: json["payment_link_id"],
        customerData:
            RespuestaNequiCustomerData.fromJson(json["customer_data"]),
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

class RespuestaNequiCustomerData {
  RespuestaNequiCustomerData({
    required this.fullName,
    required this.phoneNumber,
  });

  String fullName;
  String phoneNumber;

  factory RespuestaNequiCustomerData.fromJson(Map<String, dynamic> json) =>
      RespuestaNequiCustomerData(
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "phone_number": phoneNumber,
      };
}

class RespuestaNequiPaymentMethod {
  RespuestaNequiPaymentMethod({
    required this.type,
    required this.phoneNumber,
  });

  String type;
  String phoneNumber;

  factory RespuestaNequiPaymentMethod.fromJson(Map<String, dynamic> json) =>
      RespuestaNequiPaymentMethod(
        type: json["type"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "phone_number": phoneNumber,
      };
}

class RespuestaNequiMeta {
  RespuestaNequiMeta({
    required this.traceId,
  });

  String traceId;

  factory RespuestaNequiMeta.fromJson(Map<String, dynamic> json) =>
      RespuestaNequiMeta(
        traceId: json["trace_id"],
      );

  Map<String, dynamic> toJson() => {
        "trace_id": traceId,
      };
}
