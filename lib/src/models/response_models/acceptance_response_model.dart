// To parse this JSON data, do
//
//     final AcceptanceResponse = AcceptanceResponseFromJson(jsonString);

import 'dart:convert';

AcceptanceResponse acceptanceResponseFromJson(String str) =>
    AcceptanceResponse.fromJson(json.decode(str));

String acceptanceResponseToJson(AcceptanceResponse data) =>
    json.encode(data.toJson());

class AcceptanceResponse {
  AcceptanceResponse({
    required this.data,
  });

  Data data;

  factory AcceptanceResponse.fromJson(Map<String, dynamic> json) =>
      AcceptanceResponse(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.presignedAcceptance,
  });

  PresignedAcceptance presignedAcceptance;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        presignedAcceptance:
            PresignedAcceptance.fromJson(json["presigned_acceptance"]),
      );

  Map<String, dynamic> toJson() => {
        "presigned_acceptance": presignedAcceptance.toJson(),
      };
}

class PresignedAcceptance {
  PresignedAcceptance({
    required this.acceptanceToken,
    required this.permalink,
    required this.type,
  });

  String acceptanceToken;
  String permalink;
  String type;

  factory PresignedAcceptance.fromJson(Map<String, dynamic> json) =>
      PresignedAcceptance(
        acceptanceToken: json["acceptance_token"],
        permalink: json["permalink"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "acceptance_token": acceptanceToken,
        "permalink": permalink,
        "type": type,
      };
}
