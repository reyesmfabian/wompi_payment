// ignore: constant_identifier_names
enum Environment { TEST, PRODUCTION }

/// WompiClient is a client for the Wompi API that allows interacting with different API endpoints.
///
/// It holds configuration data such as the merchant's public key, the environment to which the client
/// is connected (test or production), the business prefix, and the currency used for transactions.
class WompiClient {
  /// The public key of the merchant used for authentication with the Wompi API.
  late final String publicKey;
  
  /// The integrity secret key of the merchant used for generate an integrity signature.
  late final String integrityKey;

  /// The environment of the Wompi API to determine the base URL for API requests.
  late final Environment environment;

  /// The Business Prefix of the merchant, used as a unique identifier for the business.
  late final String businessPrefix;

  /// The Currency code (e.g., 'COP' for Colombian Peso) used for transactions.
  String currency;

  /// The Wompi Sandbox URL used for testing and development purposes.
  static const String sandBoxUrl = "https://sandbox.wompi.co/v1";

  /// The Wompi Production URL used for real transactions in a production environment.
  static const String productionUrl = "https://production.wompi.co/v1";

  /// Constructs a [WompiClient] with the necessary configuration parameters.
  ///
  /// Args:
  ///   publicKey (String): The merchant's public key provided by Wompi.
  ///   environment (Environment): The environment (test or production) to be used by the client.
  ///   businessPrefix (String): The unique business prefix identifier.
  ///   currency (String, optional): The currency code for transactions, defaulting to 'COP'.
  WompiClient({
    required this.publicKey,
    required this.environment,
    required this.businessPrefix,
    required this.integrityKey,
    this.currency = 'COP',
  });

  /// Returns the Wompi API base URL depending on the current environment setting.
  ///
  /// Returns:
  ///   String: The base URL for the Wompi API corresponding to the configured [Environment].
  String get wompiUrl =>
      environment == Environment.PRODUCTION ? productionUrl : sandBoxUrl;
}
