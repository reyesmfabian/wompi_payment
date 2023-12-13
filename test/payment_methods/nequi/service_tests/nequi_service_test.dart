import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:wompi_payment_colombia/wompi_payment_colombia.dart';

import '../../../utils/test_utils.dart';

void main() {
  test(
    'Test Acceptance Response',
    () async {
      final acceptance =
          await WompiService.getAcceptance(wompiClient: TestUtils.wompiClient);
      final acceptanceToken =
          acceptance.data.presignedAcceptance.acceptanceToken;
      final pdfTermsLink = acceptance.data.presignedAcceptance.permalink;
      expect(acceptanceToken, isNotNull);
      expect(pdfTermsLink, isNotNull);
    },
    skip: true,
  );

  group(
    "Nequi Payments Checks",
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
        NequiPay nequiPay = NequiPay(
          paymentRequest: paymentRequestData,
          wompiClient: TestUtils.wompiClient,
          amount: TestUtils.amountToPay,
          phoneNumberToPay: TestUtils.nequiNumberToPayApproved,
        );

        final NequiPaymentResponse nequiPayment =
            await WompiService.pay(paymentProcessor: nequiPay);

        final NequiCheckModel nequiCheck = await WompiService.checkPayment(
          paymentChecker: NequiCheck(
              transactionId: nequiPayment.data.id,
              wompiClient: TestUtils.wompiClient),
        );

        expect(nequiCheck.data.status, "APPROVED");
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
        NequiPay nequiPay = NequiPay(
          paymentRequest: paymentRequestData,
          wompiClient: TestUtils.wompiClient,
          amount: TestUtils.amountToPay,
          phoneNumberToPay: TestUtils.nequiNumberToPayDeclined,
        );

        final NequiPaymentResponse nequiPayment =
            await WompiService.pay(paymentProcessor: nequiPay);

        final NequiCheckModel nequiCheck = await WompiService.checkPayment(
          paymentChecker: NequiCheck(
              transactionId: nequiPayment.data.id,
              wompiClient: TestUtils.wompiClient),
        );

        expect(nequiCheck.data.status, "DECLINED");
      });
    },
    skip: true,
  );
}
