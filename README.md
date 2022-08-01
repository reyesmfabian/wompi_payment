<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# Wompi Payment SDK - Colombia

## Features

[x] Credit Card Payments 
[x] Nequi Payments
[x] PSE Payments

## Usage



```dart
import 'package:wompi_payment_colombia/src/src_exports.dart';

void main() async {
  // *# Create a new instance of the WompiClient*

  WompiClient wompiClient = WompiClient(
    publicKey: 'BusinessPublicKey', // Business Public Key
    environment:
        Environment.PRODUCTION, // or Environment.TEST for testing purposes,
    businessPrefix: 'FR-', // Business Prefix
    currency: 'COP', // Currency for the payments
  );

  // First you need to GET the acceptance token from the server, this is the token that will be used to make the payment.
  // The user must be explicitly accepted the terms and conditions of the payment.
  final acceptance = await WompiService.getAcceptance(wompiClient: wompiClient);

  ///Get the link to the PDF file with the terms. The user must be explicitly accepted the terms and conditions of the payment.
  final pdfTermsLink = acceptance.data.presignedAcceptance.permalink;

  // Get the token from the server and use it to make the payment.
  final acceptanceToken = acceptance.data.presignedAcceptance.acceptanceToken;

  // For every method you need to create an instance of the PaymentRequestData
  PaymentRequestData paymentRequestData = PaymentRequestData(
      email:
          "test@mail.com", // The email of the user who will make the payment.
      phone: "1111111111", // The phone of the user who will make the payment.
      name: "Customer Name", // The name of the user who will make the payment.
      acceptanceToken:
          acceptanceToken, // The token that will be used to make the payment.
      reference: "payment_reference", // The reference of the payment.
      document:
          "customer_identification" // The document of the user who will make the payment.

      );

  // *------------------ # MAKE A CREDIT CARD PAYMENT ------------------ *
  
  CreditCard creditCard = CreditCard(
      cardNumber: "1111111111111111", // Credit card number
      cvcCode: "123", // CVC code
      expYear: "24", // Expiration year
      expMonth: "12", // Expiration month
      amount: 20000, // Amount to pay as integer
      quotas: 12, // Quotas to pay as integer
      cardHolder: "Customer Name" // Card holder name
      );

  // Create instance fot Payment
  CreditCardPay creditCardPay = CreditCardPay(
      creditCard: creditCard, // Credit card information
      paymentRequest: paymentRequestData, // Payment request data
      wompiClient: wompiClient // Wompi client
      );

  // Make the payment with the credit card information.
  final CardPaymentResponse cardPayment =
      await WompiService.pay(paymentProcessor: creditCardPay);

  // Check the response of the payment.
  final CardCheckModel cardCheck = await WompiService.checkPayment(
      paymentChecker: CreditCardCheck(
          transactionId: cardPayment.data.id, wompiClient: wompiClient));

  print(cardCheck.data.status);

  // *------------------ # MAKE A NEQUI PAYMENT ------------------ *
  
  NequiPay nequiPay = NequiPay(
      paymentRequest: paymentRequestData, // Payment request data
      wompiClient: wompiClient, // Wompi client
      amount: 25000, // Amount to pay as integer
      phoneNumberToPay: "1111111111" // Phone number to pay
      );

  /// Make the payment with the Nequi information.
  final NequiPaymentResponse nequiPayment =
      await WompiService.pay(paymentProcessor: nequiPay);

  // Check the response of the payment.
  final NequiCheckModel nequiCheck = await WompiService.checkPayment(
      paymentChecker: NequiCheck(
          transactionId: nequiPayment.data.id, wompiClient: wompiClient));
  print(nequiCheck.data.status);

  /// *------------------ # MAKE A PSE PAYMENT ------------------ *
  
  
  // First you need to get the List of banks to allow the user to choose one.
  final banks = await WompiService.getBanks(wompiClient: wompiClient);
  final selectedBank =
      banks.first; // In this case the user select the first Bank.

  // Create instance for the PSE Request
  final pseRequest = PseRequest(
      personType: PersonType.natural, // Person type
      documentType: "CC", // Document type
      amount: 30000, // Amount to pay as integer
      bankCode: selectedBank.financialInstitutionCode, // Bank code
      paymentDescription: "Test Payment" // Payment description
      );

  // Create the payment with the PSE information.
  final psePay = PsePay(
      pseRequest: pseRequest, // PSE request data
      paymentRequest: paymentRequestData, // Payment request data
      wompiClient: wompiClient // Wompi client
      );

  // Make the payment with the PSE information.
  final PsePaymentResponse payment =
      await WompiService.pay(paymentProcessor: psePay);

// You need to redirect the user to the URL provided by the Wompi Service.
  final paymentURL = payment.data.paymentMethod.extra!.asyncPaymentUrl;

// Then you need to check the PSE payment status.
  final PsePaymentResponse response = await WompiService.checkPayment(
      paymentChecker:
          PseCheck(transactionId: payment.data.id, wompiClient: wompiClient));

  print(response.data.status);
}
```
