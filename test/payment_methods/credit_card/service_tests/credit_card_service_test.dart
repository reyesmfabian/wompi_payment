import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:wompi_payment_colombia/wompi_payment_colombia.dart';

import '../../../utils/test_utils.dart';

void main() {
  group(
    "Credit Card Payments Checks",
    () {
      test('Test Payment Approved', () async {
        final acceptance = await WompiService.getAcceptance(
            wompiClient: TestUtils.wompiClient);
        final acceptanceToken =
            acceptance.data.presignedAcceptance.acceptanceToken;

        PaymentRequestData paymentRequestData = PaymentRequestData(
          email: TestUtils.customerEmail,
          phone: TestUtils.customerPhone,
          name: TestUtils.customerName,
          acceptanceToken: acceptanceToken,
          reference: (Random().nextInt(900000) + 100000).toString(),
          document: TestUtils.customerDocument,
        );

        CreditCard creditCard = CreditCard(
          cardNumber: "4242424242424242",
          cvcCode: "123",
          expYear: "24",
          expMonth: "12",
          amount: TestUtils.amountToPay,
          quotas: 12,
          cardHolder: TestUtils.customerName,
        );

        CreditCardPay creditCardPay = CreditCardPay(
            creditCard: creditCard,
            paymentRequest: paymentRequestData,
            wompiClient: TestUtils.wompiClient);

        final CardPaymentResponse cardPayment =
            await WompiService.pay(paymentProcessor: creditCardPay);

        await Future.delayed(const Duration(seconds: 10));

        final CardCheckModel cardCheck = await WompiService.checkPayment(
            paymentChecker: CreditCardCheck(
                transactionId: cardPayment.data.id,
                wompiClient: TestUtils.wompiClient));

        expect(cardCheck.data.status, "APPROVED");
      });

      test('Test Payment Declined', () async {
        final acceptance = await WompiService.getAcceptance(
            wompiClient: TestUtils.wompiClient);
        final acceptanceToken =
            acceptance.data.presignedAcceptance.acceptanceToken;

        PaymentRequestData paymentRequestData = PaymentRequestData(
          email: TestUtils.customerEmail,
          phone: TestUtils.customerPhone,
          name: TestUtils.customerName,
          acceptanceToken: acceptanceToken,
          reference: (Random().nextInt(900000) + 100000).toString(),
          document: TestUtils.customerDocument,
        );

        CreditCard creditCard = CreditCard(
          cardNumber: "4111111111111111",
          cvcCode: "123",
          expYear: "24",
          expMonth: "12",
          amount: TestUtils.amountToPay,
          quotas: 12,
          cardHolder: TestUtils.customerName,
        );

        CreditCardPay creditCardPay = CreditCardPay(
          creditCard: creditCard,
          paymentRequest: paymentRequestData,
          wompiClient: TestUtils.wompiClient,
        );

        final CardPaymentResponse cardPayment =
            await WompiService.pay(paymentProcessor: creditCardPay);

        await Future.delayed(const Duration(seconds: 10));

        final CardCheckModel cardCheck = await WompiService.checkPayment(
          paymentChecker: CreditCardCheck(
              transactionId: cardPayment.data.id,
              wompiClient: TestUtils.wompiClient),
        );

        expect(cardCheck.data.status, "DECLINED");
      });
    },
    skip: true,
  );
}
