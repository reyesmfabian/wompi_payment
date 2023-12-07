import 'package:wompi_payment_colombia/src/src_exports.dart';

/// An abstract class that defines the structure and required functionalities
/// for a payment status checker.
///
/// Implementing classes should provide concrete implementations for the
/// `checkPayment` method to interact with different payment methods and
/// services to verify the status of a transaction.
abstract class PaymentChecker {
  /// Unique identifier for the transaction.
  final String transactionId;

  /// The client used to make HTTP requests to the Wompi API.
  final WompiClient wompiClient;

  /// Constructor for the payment checker that requires a transaction ID and
  /// a Wompi client instance.
  PaymentChecker({required this.transactionId, required this.wompiClient});

  /// Abstract method that should be overridden to check the payment status
  /// of a transaction.
  ///
  /// Implementations should return information about the transaction status
  /// after performing the necessary API calls to the Wompi service.
  checkPayment();
}
