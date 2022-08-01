// ignore: constant_identifier_names
enum Environment { TEST, PRODUCTION }

/// WompiClient is a client for the Wompi API.
///

class WompiClient {
  /// The public key of the merchant.
  ///
  late final String publicKey;

  /// The environment of the Wompi API.
  ///
  late final Environment environment;

  /// The Business Prefix of the merchant.
  ///
  late final String businessPrefix;

  /// The Currency of the merchant.
  ///
  String currency;

  /// The Wompi Sandbox URL.
  static String sandBoxUrl = "https://sandbox.wompi.co";

  /// The Wompi Production URL.
  ///
  static String productionUrl = "https://production.wompi.co";

  WompiClient(
      {required this.publicKey,
      required this.environment,
      required this.businessPrefix,
      this.currency = 'COP'});

  /// Get the WompiURL based on the environment.
  ///
  String get wompiUrl =>
      environment == Environment.PRODUCTION ? productionUrl : sandBoxUrl;
}
