import 'dart:convert';

PseRequest pseRequestFromJson(String str) =>
    PseRequest.fromJson(json.decode(str));

String pseRequestToJson(PseRequest data) => json.encode(data.toJson());

enum TipoPersona { natural, juridica }

class PseRequest {
  PseRequest({
    required this.tipoPersona,
    required this.tipoDocumento,
    required this.amount,
    required this.bankCode,
    required this.descripcionPago,
  });

  TipoPersona tipoPersona;
  String tipoDocumento;
  int amount;
  String bankCode;
  String descripcionPago;

  factory PseRequest.fromJson(Map<String, dynamic> json) => PseRequest(
        tipoPersona: json["tipoPersona"],
        tipoDocumento: json["tipoDocumento"],
        amount: json["amount"],
        bankCode: json["bankCode"],
        descripcionPago: json["descripcionPago"],
      );

  Map<String, dynamic> toJson() => {
        "tipoPersona": tipoPersona,
        "tipoDocumento": tipoDocumento,
        "amount": amount,
        "bankCode": bankCode,
        "descripcionPago": descripcionPago,
      };
}
