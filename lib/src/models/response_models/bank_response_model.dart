import 'dart:convert';

/// Converts a JSON string [str] into a [BankModel] object.
BankModel bankModelFromJson(String str) => BankModel.fromJson(json.decode(str));

/// Converts a [BankModel] object [data] into a JSON string.
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

class Bank {
  Bank({
    /// The code of the financial institution.
    required this.financialInstitutionCode,

    /// The name of the financial institution.
    required this.financialInstitutionName,
  });

  /// The line `String financialInstitutionCode;` is declaring a variable named `financialInstitutionCode`
  /// of type `String` in the `Bank` class. This variable is used to store the financial institution code
  /// of a bank.
  String financialInstitutionCode;

  /// The line `String financialInstitutionName;` is declaring a variable named `financialInstitutionName`
  /// of type `String` in the `Bank` class. This variable is used to store the financial institution name
  /// of a bank.
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
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta();

  Map<String, dynamic> toJson() => {};
}
