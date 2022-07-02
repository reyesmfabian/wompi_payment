// To parse this JSON data, do
//
//     final modeloAceptacion = modeloAceptacionFromJson(jsonString);

import 'dart:convert';

ModeloAceptacion modeloAceptacionFromJson(String str) =>
    ModeloAceptacion.fromJson(json.decode(str));

String modeloAceptacionToJson(ModeloAceptacion data) =>
    json.encode(data.toJson());

class ModeloAceptacion {
  ModeloAceptacion({
    required this.data,
  });

  Data data;

  factory ModeloAceptacion.fromJson(Map<String, dynamic> json) =>
      ModeloAceptacion(
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
