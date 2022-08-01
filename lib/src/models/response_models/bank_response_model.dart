import 'dart:convert';

BankModel bankModelFromJson(String str) => BankModel.fromJson(json.decode(str));

String bankModelToJson(BankModel data) => json.encode(data.toJson());

class BankModel {
  BankModel({
    required this.data,
    required this.meta,
  });

  List<Bank> data;
  Meta meta;

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        data: List<Bank>.from(json["data"].map((x) => Bank.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Bank {
  Bank({
    required this.financialInstitutionCode,
    required this.financialInstitutionName,
  });

  String financialInstitutionCode;
  String financialInstitutionName;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        financialInstitutionCode: json["financial_institution_code"],
        financialInstitutionName: json["financial_institution_name"],
      );

  Map<String, dynamic> toJson() => {
        "financial_institution_code": financialInstitutionCode,
        "financial_institution_name": financialInstitutionName,
      };
}

class Meta {
  Meta({
    required this.traceId,
  });

  String traceId;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        traceId: json["trace_id"],
      );

  Map<String, dynamic> toJson() => {
        "trace_id": traceId,
      };
}
