import 'dart:convert';

RespuestaPagoTarjeta respuestaPagoTarjetaFromJson(String str) =>
    RespuestaPagoTarjeta.fromJson(json.decode(str));

String respuestaPagoTarjetaToJson(RespuestaPagoTarjeta data) =>
    json.encode(data.toJson());

class RespuestaPagoTarjeta {
  RespuestaPagoTarjeta({
    required this.data,
    required this.meta,
  });

  RespuestaTarjetaData data;
  RespuestaTarjetaMeta meta;

  factory RespuestaPagoTarjeta.fromJson(Map<String, dynamic> json) =>
      RespuestaPagoTarjeta(
        data: RespuestaTarjetaData.fromJson(json["data"]),
        meta: RespuestaTarjetaMeta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "meta": meta.toJson(),
      };
}

class RespuestaTarjetaData {
  RespuestaTarjetaData({
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
  RespuestaTarjetaPaymentMethod paymentMethod;
  String status;
  dynamic statusMessage;
  dynamic billingData;
  dynamic shippingAddress;
  dynamic redirectUrl;
  dynamic paymentSourceId;
  dynamic paymentLinkId;
  RespuestaTarjetaCustomerData customerData;
  dynamic billId;
  List<dynamic> taxes;

  factory RespuestaTarjetaData.fromJson(Map<String, dynamic> json) =>
      RespuestaTarjetaData(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        finalizedAt: json["finalized_at"],
        amountInCents: json["amount_in_cents"],
        reference: json["reference"],
        customerEmail: json["customer_email"],
        currency: json["currency"],
        paymentMethodType: json["payment_method_type"],
        paymentMethod:
            RespuestaTarjetaPaymentMethod.fromJson(json["payment_method"]),
        status: json["status"],
        statusMessage: json["status_message"],
        billingData: json["billing_data"],
        shippingAddress: json["shipping_address"],
        redirectUrl: json["redirect_url"],
        paymentSourceId: json["payment_source_id"],
        paymentLinkId: json["payment_link_id"],
        customerData:
            RespuestaTarjetaCustomerData.fromJson(json["customer_data"]),
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

class RespuestaTarjetaCustomerData {
  RespuestaTarjetaCustomerData({
    required this.fullName,
    required this.phoneNumber,
  });

  String fullName;
  String phoneNumber;

  factory RespuestaTarjetaCustomerData.fromJson(Map<String, dynamic> json) =>
      RespuestaTarjetaCustomerData(
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "phone_number": phoneNumber,
      };
}

class RespuestaTarjetaPaymentMethod {
  RespuestaTarjetaPaymentMethod({
    required this.type,
    required this.extra,
    required this.installments,
  });

  String type;
  RespuestaTarjetaExtra extra;
  int installments;

  factory RespuestaTarjetaPaymentMethod.fromJson(Map<String, dynamic> json) =>
      RespuestaTarjetaPaymentMethod(
        type: json["type"],
        extra: RespuestaTarjetaExtra.fromJson(json["extra"]),
        installments: json["installments"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "extra": extra.toJson(),
        "installments": installments,
      };
}

class RespuestaTarjetaExtra {
  RespuestaTarjetaExtra({
    required this.bin,
    required this.name,
    required this.brand,
    required this.expYear,
    required this.expMonth,
    required this.lastFour,
    required this.cardHolder,
  });

  String bin;
  String name;
  String brand;
  String expYear;
  String expMonth;
  String lastFour;
  String cardHolder;

  factory RespuestaTarjetaExtra.fromJson(Map<String, dynamic> json) =>
      RespuestaTarjetaExtra(
        bin: json["bin"],
        name: json["name"],
        brand: json["brand"],
        expYear: json["exp_year"],
        expMonth: json["exp_month"],
        lastFour: json["last_four"],
        cardHolder: json["card_holder"],
      );

  Map<String, dynamic> toJson() => {
        "bin": bin,
        "name": name,
        "brand": brand,
        "exp_year": expYear,
        "exp_month": expMonth,
        "last_four": lastFour,
        "card_holder": cardHolder,
      };
}

class RespuestaTarjetaMeta {
  RespuestaTarjetaMeta({
    required this.traceId,
  });

  String traceId;

  factory RespuestaTarjetaMeta.fromJson(Map<String, dynamic> json) =>
      RespuestaTarjetaMeta(
        traceId: json["trace_id"],
      );

  Map<String, dynamic> toJson() => {
        "trace_id": traceId,
      };
}
