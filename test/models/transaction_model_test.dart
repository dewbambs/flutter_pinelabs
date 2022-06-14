// ignore_for_file: prefer_const_constructors

import 'package:flutter_pinelabs/models/transaction_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should support value comparison', () {
    expect(
      TransactionModel(
        transactionType: 'a',
        billingRefNo: 'u',
        paymentAmount: 'm',
        mobileNumberForEChargeSlip: 'v',
      ),
      TransactionModel(
        transactionType: 'a',
        billingRefNo: 'u',
        paymentAmount: 'm',
        mobileNumberForEChargeSlip: 'v',
      ),
    );
  });

  group('fromMap', () {
    test('returns a TransactionModel', () {
      expect(
        TransactionModel.fromMap(const {
          'TransactionType': 'a',
          'BillingRefNo': 'u',
          'PaymentAmount': 'm',
          'MobileNumberForEChargeSlip': 'v',
        }),
        TransactionModel(
          transactionType: 'a',
          billingRefNo: 'u',
          paymentAmount: 'm',
          mobileNumberForEChargeSlip: 'v',
        ),
      );
    });
  });

  group('fromJson', () {
    test('returns a TransactionModel', () {
      expect(
        TransactionModel.fromJson(
          '''
{"TransactionType":"a","BillingRefNo":"u","PaymentAmount":"m","MobileNumberForEChargeSlip":"v"}''',
        ),
        TransactionModel(
          transactionType: 'a',
          billingRefNo: 'u',
          paymentAmount: 'm',
          mobileNumberForEChargeSlip: 'v',
        ),
      );
    });
  });

  group('copyWith', () {
    const tTransaction = TransactionModel(
      transactionType: 'a',
      billingRefNo: 'u',
      paymentAmount: 'm',
      mobileNumberForEChargeSlip: 'v',
    );

    test('returns a TransactionModel', () {
      expect(
        tTransaction.copyWith(
          transactionType: 'b',
          billingRefNo: 'w',
          paymentAmount: 'x',
          mobileNumberForEChargeSlip: 'y',
        ),
        TransactionModel(
          transactionType: 'b',
          billingRefNo: 'w',
          paymentAmount: 'x',
          mobileNumberForEChargeSlip: 'y',
        ),
      );
    });
  });

  group('toJson', () {
    test('returns a TransactionModel', () {
      expect(
        TransactionModel(
          transactionType: 'a',
          billingRefNo: 'u',
          paymentAmount: 'm',
          mobileNumberForEChargeSlip: 'v',
        ).toJson(),
        '{"TransactionType":"a","BillingRefNo":"u","PaymentAmount":"m","MobileNumberForEChargeSlip":"v"}',
      );
    });
  });

  test('toString returns correct string', () {
    expect(
      TransactionModel(
        transactionType: 'a',
        billingRefNo: 'u',
        paymentAmount: 'm',
        mobileNumberForEChargeSlip: 'v',
      ).toString(),
      '''
TransactionModel(TransactionType: a, BillingRefNo: u, PaymentAmount: m, MobileNumberForEChargeSlip: v)''',
    );
  });
}
