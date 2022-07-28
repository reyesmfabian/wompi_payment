// ignore: constant_identifier_names
enum Ambiente { TEST, PRODUCTION }

class WompiClient {
  late final String llavePublica;
  late final Ambiente ambiente;
  late final String prefijoComercio;
  String moneda;

  static String sandBoxUrl = "https://sandbox.wompi.co";
  static String productionUrl = "https://production.wompi.co";

  WompiClient(
      {required this.llavePublica,
      required this.ambiente,
      required this.prefijoComercio,
      this.moneda = 'COP'});

  String get wompiUrl =>
      ambiente == Ambiente.PRODUCTION ? productionUrl : sandBoxUrl;
}
