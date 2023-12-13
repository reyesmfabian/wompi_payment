import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:wompi_payment_colombia/wompi_payment_colombia.dart';

import '../../../utils/test_utils.dart';

void main() {
  group(
    "PSE Payments Checks",
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

        final banks =
            await WompiService.getBanks(wompiClient: TestUtils.wompiClient);
        final selectedBank = banks[0];

        final pseRequest = PseRequest(
          personType: PersonType.natural,
          documentType: "CC",
          amount: TestUtils.amountToPay,
          bankCode: selectedBank.financialInstitutionCode,
          paymentDescription: "Test Payment",
        );

        final psePay = PsePay(
          pseRequest: pseRequest,
          paymentRequest: paymentRequestData,
          wompiClient: TestUtils.wompiClient,
        );

        final PsePaymentResponse payment =
            await WompiService.pay(paymentProcessor: psePay);

        final PsePaymentResponse psePaymentCheck =
            await WompiService.checkPayment(
          paymentChecker: PseCheck(
              transactionId: payment.data.id,
              wompiClient: TestUtils.wompiClient),
        );

        expect(psePaymentCheck.data.status, "APPROVED");
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

        final banks =
            await WompiService.getBanks(wompiClient: TestUtils.wompiClient);
        final selectedBank = banks[1];

        final pseRequest = PseRequest(
          personType: PersonType.natural,
          documentType: "CC",
          amount: TestUtils.amountToPay,
          bankCode: selectedBank.financialInstitutionCode,
          paymentDescription: "Test Payment",
        );

        final psePay = PsePay(
          pseRequest: pseRequest,
          paymentRequest: paymentRequestData,
          wompiClient: TestUtils.wompiClient,
        );

        final PsePaymentResponse payment =
            await WompiService.pay(paymentProcessor: psePay);

        final PsePaymentResponse psePaymentCheck =
            await WompiService.checkPayment(
          paymentChecker: PseCheck(
              transactionId: payment.data.id,
              wompiClient: TestUtils.wompiClient),
        );

        expect(psePaymentCheck.data.status, "DECLINED");
      });
    },
    skip: true,
  );
}
