import 'dart:convert';

import 'package:flutter/material.dart';

/// A model class for transactions.
@immutable
class TransactionModel {
  /// A model class for pine lab transactions.
  /// [transactionType] is the transaction type which is consumed as long
  /// value by the device.
  /// [billingRefNo] is the billing reference number.
  /// [paymentAmount] is the payment amount which is consumed as long value.
  /// [mobileNumberForEChargeSlip] is the mobile number for eChargeSlip.
  const TransactionModel({
    required this.transactionType,
    this.billingRefNo,
    this.paymentAmount,
    this.mobileNumberForEChargeSlip,
  });

  /// get [TransactionModel] from map.
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      transactionType: map['transactionType'] ?? '',
      billingRefNo: map['billingRefNo'],
      paymentAmount: map['paymentAmount'],
      mobileNumberForEChargeSlip: map['mobileNumberForEChargeSlip'],
    );
  }

  /// create [TransactionModel] from json.
  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));

  /// [transactionType] is the transaction type which is consumed as long
  /// value by the device.
  final String transactionType;

  /// [billingRefNo] is the billing reference number.
  final String? billingRefNo;

  /// [paymentAmount] is the payment amount which is consumed as long value.
  final String? paymentAmount;

  /// [mobileNumberForEChargeSlip] is the mobile number for eChargeSlip.
  final String? mobileNumberForEChargeSlip;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionModel &&
        other.transactionType == transactionType &&
        other.billingRefNo == billingRefNo &&
        other.paymentAmount == paymentAmount &&
        other.mobileNumberForEChargeSlip == mobileNumberForEChargeSlip;
  }

  @override
  int get hashCode {
    return transactionType.hashCode ^
        billingRefNo.hashCode ^
        paymentAmount.hashCode ^
        mobileNumberForEChargeSlip.hashCode;
  }

  /// copy and create new instance of [TransactionModel]
  TransactionModel copyWith({
    String? transactionType,
    String? billingRefNo,
    String? paymentAmount,
    String? mobileNumberForEChargeSlip,
  }) {
    return TransactionModel(
      transactionType: transactionType ?? this.transactionType,
      billingRefNo: billingRefNo ?? this.billingRefNo,
      paymentAmount: paymentAmount ?? this.paymentAmount,
      mobileNumberForEChargeSlip:
          mobileNumberForEChargeSlip ?? this.mobileNumberForEChargeSlip,
    );
  }

  /// convert [TransactionModel] to map.
  Map<String, dynamic> toMap() {
    return {
      'transactionType': transactionType,
      'billingRefNo': billingRefNo,
      'paymentAmount': paymentAmount,
      'mobileNumberForEChargeSlip': mobileNumberForEChargeSlip,
    };
  }

  /// convert [TransactionModel] to json.
  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return '''TransactionModel(transactionType: $transactionType, billingRefNo: $billingRefNo, paymentAmount: $paymentAmount, mobileNumberForEChargeSlip: $mobileNumberForEChargeSlip)''';
  }
}
