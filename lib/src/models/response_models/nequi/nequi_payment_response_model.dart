import 'dart:convert';

NequiPaymentResponse nequiPaymentResponseFromJson(String str) =>
    NequiPaymentResponse.fromJson(json.decode(str));

String nequiPaymentResponseToJson(NequiPaymentResponse data) =>
    json.encode(data.toJson());

/// A class that represents the response from the Nequi API.
class NequiPaymentResponse {
  NequiPaymentResponse({
    required this.data,
    required this.meta,
  });

  NequiResponseData data;
  NequiResponseMeta meta;

  /// It creates a NequiPaymentResponse object from a json object.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The json response from the server.
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

/// A class that contains the data that is returned from the API.
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

  /// A factory constructor that creates a NequiResponseData object from a json object.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON response from the API.
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

  /// It converts the object into a JSON object

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

/// A class that represents the response of the Nequi API.
class NequiResponseCustomerData {
  NequiResponseCustomerData({
    required this.fullName,
    required this.phoneNumber,
  });

  String fullName;
  String phoneNumber;

  /// It creates a new instance of the NequiResponseCustomerData class from a JSON object.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON object that you want to parse.
  factory NequiResponseCustomerData.fromJson(Map<String, dynamic> json) =>
      NequiResponseCustomerData(
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
      );

  /// It converts the object to a map.
  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "phone_number": phoneNumber,
      };
}

/// A class that represents the response of the payment method.
class NequiResponsePaymentMethod {
  NequiResponsePaymentMethod({
    required this.type,
    required this.phoneNumber,
  });

  String type;
  String phoneNumber;

  /// A factory constructor that creates a new NequiResponsePaymentMethod object from a JSON map.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON object that you want to parse.
  factory NequiResponsePaymentMethod.fromJson(Map<String, dynamic> json) =>
      NequiResponsePaymentMethod(
        type: json["type"],
        phoneNumber: json["phone_number"],
      );

  /// It converts the object to a JSON object.
  Map<String, dynamic> toJson() => {
        "type": type,
        "phone_number": phoneNumber,
      };
}

/// A class that represents the meta data of a response from Nequi.
class NequiResponseMeta {
  NequiResponseMeta({
    required this.traceId,
  });

  String traceId;

  /// It creates a NequiResponseMeta object from a json object.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON object that you want to parse.
  factory NequiResponseMeta.fromJson(Map<String, dynamic> json) =>
      NequiResponseMeta(
        traceId: json["trace_id"],
      );

  /// It converts the object to a JSON object.
  Map<String, dynamic> toJson() => {
        "trace_id": traceId,
      };
}
