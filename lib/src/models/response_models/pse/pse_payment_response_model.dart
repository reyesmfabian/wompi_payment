import 'dart:convert';

PsePaymentResponse psePaymentResponseFromJson(String str) =>
    PsePaymentResponse.fromJson(json.decode(str));

String psePaymentResponseToJson(PsePaymentResponse data) =>
    json.encode(data.toJson());

/// A class that is used to parse the response from the API.
class PsePaymentResponse {
  PsePaymentResponse({
    required this.data,
    required this.meta,
  });

  PsePaymentResponseData data;
  PsePaymentResponseMeta meta;

  /// It creates a PsePaymentResponse object from a json string.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON response from the API.
  factory PsePaymentResponse.fromJson(Map<String, dynamic> json) =>
      PsePaymentResponse(
        data: PsePaymentResponseData.fromJson(json["data"]),
        meta: PsePaymentResponseMeta.fromJson(json["meta"]),
      );

  /// It converts the object to a json object.
  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "meta": meta.toJson(),
      };
}

/// A class that represents the response of a payment request.
class PsePaymentResponseData {
  PsePaymentResponseData({
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
  PsePaymentResponsePaymentMethod paymentMethod;
  String redirectUrl;
  String status;
  String statusMessage;
  PsePaymentResponseMerchant merchant;
  List<dynamic> taxes;

  /// It takes a JSON object and returns a Dart object
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON response from the API.
  factory PsePaymentResponseData.fromJson(Map<String, dynamic> json) =>
      PsePaymentResponseData(
          id: json["id"],
          createdAt: json["created_at"],
          amountInCents: json["amount_in_cents"],
          reference: json["reference"],
          currency: json["currency"],
          paymentMethodType: json["payment_method_type"],
          paymentMethod:
              PsePaymentResponsePaymentMethod.fromJson(json["payment_method"]),
          redirectUrl: json["redirect_url"] ?? "",
          status: json["status"],
          statusMessage: json["status_message"] ?? "",
          merchant: PsePaymentResponseMerchant.fromJson(json["merchant"] ?? {}),
          taxes: List<dynamic>.from(json["taxes"].map((x) => x)));

  /// It converts the object to a json object.
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

/// A class that represents the merchant object in the response.
class PsePaymentResponseMerchant {
  PsePaymentResponseMerchant({
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

  /// It takes a Map<String, dynamic> and returns a PsePaymentResponseMerchant
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON object that contains the data to be parsed.

  factory PsePaymentResponseMerchant.fromJson(Map<String, dynamic> json) =>
      PsePaymentResponseMerchant(
        name: json["name"] ?? "",
        legalName: json["legal_name"] ?? "",
        contactName: json["contact_name"] ?? "",
        phoneNumber: json["phone_number"] ?? "",
        logoUrl: json["logo_url"] ?? "",
        legalIdType: json["legal_id_type"] ?? "",
        email: json["email"] ?? "",
        legalId: json["legal_id"] ?? "",
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

/// A class that represents the response of a payment method.
class PsePaymentResponsePaymentMethod {
  PsePaymentResponsePaymentMethod({
    required this.type,
    this.extra,
    required this.userType,
    required this.userLegalId,
    required this.userLegalIdType,
    required this.paymentDescription,
    required this.financialInstitutionCode,
  });

  String type;
  PsePaymentResponseExtra? extra;
  int userType;
  String userLegalId;
  String userLegalIdType;
  String paymentDescription;
  String financialInstitutionCode;

  /// A factory constructor that creates a new PsePaymentResponsePaymentMethod object from a Map object.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON object that contains the data to be parsed.
  factory PsePaymentResponsePaymentMethod.fromJson(Map<String, dynamic> json) =>
      PsePaymentResponsePaymentMethod(
        type: json["type"],
        extra: json["extra"] == null
            ? null
            : PsePaymentResponseExtra.fromJson(json["extra"]),
        userType: json["user_type"],
        userLegalId: json["user_legal_id"],
        userLegalIdType: json["user_legal_id_type"],
        paymentDescription: json["payment_description"],
        financialInstitutionCode: json["financial_institution_code"],
      );

  /// It converts the object into a map
  Map<String, dynamic> toJson() => {
        "type": type,
        "extra": extra?.toJson(),
        "user_type": userType,
        "user_legal_id": userLegalId,
        "user_legal_id_type": userLegalIdType,
        "payment_description": paymentDescription,
        "financial_institution_code": financialInstitutionCode,
      };
}

/// A class that represents the extra information that is returned by the PSE payment gateway.

class PsePaymentResponseExtra {
  PsePaymentResponseExtra({
    required this.ticketId,
    required this.returnCode,
    required this.requestDate,
    required this.asyncPaymentUrl,
    required this.traceabilityCode,
    required this.transactionCycle,
    required this.transactionState,
    required this.externalIdentifier,
    required this.bankProcessingDate,
  });

  String ticketId;
  String returnCode;
  DateTime requestDate;
  String asyncPaymentUrl;
  String traceabilityCode;
  String transactionCycle;
  dynamic transactionState;
  String externalIdentifier;
  DateTime bankProcessingDate;

  /// It takes a JSON object and returns a PsePaymentResponseExtra object
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The json object returned by the API.
  factory PsePaymentResponseExtra.fromJson(Map<String, dynamic> json) =>
      PsePaymentResponseExtra(
        ticketId: json["ticket_id"] ?? "",
        returnCode: json["return_code"] ?? "",
        requestDate:
            DateTime.parse(json["request_date"] ?? DateTime.now().toString()),
        asyncPaymentUrl: json["async_payment_url"] ?? "",
        traceabilityCode: json["traceability_code"] ?? "",
        transactionCycle: json["transaction_cycle"] ?? "",
        transactionState: json["transaction_state"] ?? "",
        externalIdentifier: json["external_identifier"] ?? "",
        bankProcessingDate: DateTime.parse(
            json["bank_processing_date"] ?? DateTime.now().toString()),
      );

  /// It converts the object to a json object.
  Map<String, dynamic> toJson() => {
        "ticket_id": ticketId,
        "return_code": returnCode,
        "request_date":
            "${requestDate.year.toString().padLeft(4, '0')}-${requestDate.month.toString().padLeft(2, '0')}-${requestDate.day.toString().padLeft(2, '0')}",
        "async_payment_url": asyncPaymentUrl,
        "traceability_code": traceabilityCode,
        "transaction_cycle": transactionCycle,
        "transaction_state": transactionState,
        "external_identifier": externalIdentifier,
        "bank_processing_date":
            "${bankProcessingDate.year.toString().padLeft(4, '0')}-${bankProcessingDate.month.toString().padLeft(2, '0')}-${bankProcessingDate.day.toString().padLeft(2, '0')}",
      };
}

/// A class that is used to parse the response from the API.
class PsePaymentResponseMeta {
  PsePaymentResponseMeta();

  factory PsePaymentResponseMeta.fromJson(Map<String, dynamic> json) =>
      PsePaymentResponseMeta();

  Map<String, dynamic> toJson() => {};
}
