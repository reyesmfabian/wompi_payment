import 'dart:convert';

BankModel bankModelFromJson(String str) => BankModel.fromJson(json.decode(str));

String bankModelToJson(BankModel data) => json.encode(data.toJson());

/// A model class for the Bank API response.
class BankModel {
  BankModel({
    required this.data,
    required this.meta,
  });

  List<Bank> data;
  Meta meta;

  /// A factory constructor that creates a BankModel object from a json string.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON data that you want to convert to a Dart object.
  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        data: List<Bank>.from(json["data"].map((x) => Bank.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  /// It converts the data into a json format.
  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

/// A class that represents a bank.
class Bank {
  Bank({
    required this.financialInstitutionCode,
    required this.financialInstitutionName,
  });

  String financialInstitutionCode;
  String financialInstitutionName;

  /// A factory constructor that creates a Bank object from a json object.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON object that you want to convert to a Dart object.
  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        financialInstitutionCode: json["financial_institution_code"],
        financialInstitutionName: json["financial_institution_name"],
      );

  /// It converts the object to a JSON object.
  Map<String, dynamic> toJson() => {
        "financial_institution_code": financialInstitutionCode,
        "financial_institution_name": financialInstitutionName,
      };
}

/// A class that is used to parse the JSON response from the API.
class Meta {
  Meta({
    required this.traceId,
  });

  String traceId;

  /// It creates a Meta object from a json string.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON object that you want to convert to a Meta object.
  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        traceId: json["trace_id"],
      );

  /// It converts the object to a JSON object.
  Map<String, dynamic> toJson() => {
        "trace_id": traceId,
      };
}
