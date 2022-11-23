// To parse this JSON data, do
//
//     final AcceptanceResponse = AcceptanceResponseFromJson(jsonString);

import 'dart:convert';

AcceptanceResponse acceptanceResponseFromJson(String str) =>
    AcceptanceResponse.fromJson(json.decode(str));

String acceptanceResponseToJson(AcceptanceResponse data) =>
    json.encode(data.toJson());

/// A class that is used to parse the response from the server.
class AcceptanceResponse {
  AcceptanceResponse({
    required this.data,
  });

  Data data;

  /// A factory constructor that creates an instance of the class from a JSON object.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON object that you want to parse.
  factory AcceptanceResponse.fromJson(Map<String, dynamic> json) =>
      AcceptanceResponse(
        data: Data.fromJson(json["data"]),
      );

  /// It converts the object to a JSON object.
  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

/// A class that is used to parse the response from the server.
class Data {
  Data({
    required this.presignedAcceptance,
  });

  PresignedAcceptance presignedAcceptance;

  /// It creates a Data object from a json object.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON object that you want to parse.
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        presignedAcceptance:
            PresignedAcceptance.fromJson(json["presigned_acceptance"]),
      );

  /// It converts the object to a JSON object.
  Map<String, dynamic> toJson() => {
        "presigned_acceptance": presignedAcceptance.toJson(),
      };
}

/// `PresignedAcceptance` is a class that represents a presigned acceptance
class PresignedAcceptance {
  PresignedAcceptance({
    required this.acceptanceToken,
    required this.permalink,
    required this.type,
  });

  String acceptanceToken;
  String permalink;
  String type;

  /// It creates a new instance of the PresignedAcceptance class from a JSON object.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON object that you want to convert to a PresignedAcceptance
  /// object.
  factory PresignedAcceptance.fromJson(Map<String, dynamic> json) =>
      PresignedAcceptance(
        acceptanceToken: json["acceptance_token"],
        permalink: json["permalink"],
        type: json["type"],
      );

  /// It converts the object to a map.
  Map<String, dynamic> toJson() => {
        "acceptance_token": acceptanceToken,
        "permalink": permalink,
        "type": type,
      };
}
