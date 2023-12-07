import 'package:wompi_payment_colombia/src/src_exports.dart';

/// An abstract base class for processing payments through Wompi API.
///
/// This class should be inherited by specific payment method processors
/// that implement the `pay` method to execute the payment transaction
/// using the WompiClient.
abstract class PaymentProcessor {
  /// The Wompi client instance used for making API requests.
  final WompiClient wompiClient;

  /// The data required to make a payment request.
  final PaymentRequestData paymentRequest;

  /// Constructs a [PaymentProcessor] requiring [paymentRequest] data
  /// and a [wompiClient] instance for API interactions.
  PaymentProcessor({required this.paymentRequest, required this.wompiClient});

  /// Abstract method `pay` to initiate the payment process.
  ///
  /// Implementing classes should override this method to define the
  /// payment process for the specific payment method.
  pay();
}
