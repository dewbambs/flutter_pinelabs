import 'dart:convert';

import 'package:flutter_pinelabs/flutter_pinelabs_platform_interface.dart';
import 'package:flutter_pinelabs/models/header_model.dart';
import 'package:flutter_pinelabs/models/print_model.dart';
import 'package:flutter_pinelabs/models/response_model.dart';
import 'package:flutter_pinelabs/models/transaction_model.dart';

/// An implementation of Pinelabs Platform Interface that uses method channels.
/// docs for pinelabs: https://developer.pinelabs.com/plutus-smart/docs
class FlutterPinelabs {
  /// An implementation of Pinelabs Platform Interface that uses method channels
  /// docs for pinelabs: https://developer.pinelabs.com/plutus-smart/docs
  const FlutterPinelabs({this.header});

  /// [header] is the header of the request.
  final HeaderModel? header;

  /// get the platform version
  Future<String?> getPlatformVersion() {
    return FlutterPinelabsPlatform.instance.getPlatformVersion();
  }

  /// send request for pinelabs device using [request]
  /// [request] is a json string which can take any supported data
  /// While using request it is expeced by user to enter headers manually as
  /// well.
  /// e.g.
  /// ```
  /// {
  /// 	"Header": {
  /// 		"ApplicationId": "abcdefgh",
  /// 		"UserId": "user1234",
  /// 		"MethodId": "1001",
  /// 		"VersionNo": "1.0"
  /// 	},
  /// 	"Detail": {
  /// 		"TransactionType": "4001",
  /// 		"BillingRefNo": "TXN12345678",
  /// 		"PaymentAmount": "9999000",
  /// 		"MobileNumberForEChargeSlip": "9876543210",
  /// 		"AdditionalInfo": {
  /// 			"Split1": "99991",
  /// 			"Split2": "99992",
  /// 			"Split3": "99993"
  /// 		}
  /// 	}
  /// }
  /// ```
  Future<String?> sendRequest({required String request}) {
    return FlutterPinelabsPlatform.instance.sendRequest(request: request);
  }

  ///Establish a Bluetooth connection by making
  ///a request to the master app (Home App)
  /// [baseSerialNumber] same as the unique serial number at base.
  Future<ResponseModel?> setBluetooth({
    required String baseSerialNumber,
    HeaderModel? overrideHeader,
  }) async {
    if (overrideHeader == null && this.header == null) {
      throw Exception(
        '''Header is required, add header during initialization or pass header as parameter in override header.''',
      );
    }

    final detail = {
      'BaseSerialNumber': baseSerialNumber,
    };

    final header = overrideHeader?.copyWith(methodId: '1005') ??
        this.header?.copyWith(
              methodId: '1005',
            );
    final requestBody =
        {'Header': header?.toJson(), 'Detail': json.encode(detail)}.toString();
    final response = await FlutterPinelabsPlatform.instance
        .sendRequest(request: requestBody);
    return response != null ? ResponseModel.fromJson(response) : null;
  }

  /// Start Scan after successfull bluetooth connection
  /// a request to the master app (Home App)
  /// [baseSerialNumber] same as the unique serial number at base.
  Future<ResponseModel?> startScan({
    required String baseSerialNumber,
    HeaderModel? overrideHeader,
  }) async {
    if (overrideHeader == null && this.header == null) {
      throw Exception(
        '''Header is required, add header during initialization or pass header as parameter in override header.''',
      );
    }

    final detail = {
      'BaseSerialNumber': baseSerialNumber,
    };

    final header = overrideHeader?.copyWith(methodId: '1007') ??
        this.header?.copyWith(
              methodId: '1007',
            );
    final requestBody = {
      'Header': header?.toJson(),
      'Detail': json.encode(detail),
    }.toString();

    final response = await FlutterPinelabsPlatform.instance
        .sendRequest(request: requestBody);
    return response != null ? ResponseModel.fromJson(response) : null;
  }

  /// Stop Scan after Scann has been Started
  /// a request to the master app (Home App)
  /// [baseSerialNumber] same as the unique serial number at base.
  Future<ResponseModel?> stopScan({
    required String baseSerialNumber,
    HeaderModel? overrideHeader,
  }) async {
    if (overrideHeader == null && this.header == null) {
      throw Exception(
        '''Header is required, add header during initialization or pass header as parameter in override header.''',
      );
    }

    final detail = {
      'BaseSerialNumber': baseSerialNumber,
    };

    final header = overrideHeader?.copyWith(methodId: '1012') ??
        this.header?.copyWith(
              methodId: '1012',
            );
    final requestBody = {
      'Header': header?.toJson(),
      'Detail': json.encode(detail),
    }.toString();
    final response = await FlutterPinelabsPlatform.instance
        .sendRequest(request: requestBody);
    return response != null ? ResponseModel.fromJson(response) : null;
  }

  /// get UPI status
  /// [paymentAmount] same as the upi payment amount.
  /// [billingRefNo] same as the upi payment whose status needs to be checked.
  Future<ResponseModel?> getUpiStatus({
    required double paymentAmount,
    String? billingRefNo,
    HeaderModel? overrideHeader,
  }) async {
    if (overrideHeader == null && this.header == null) {
      throw Exception(
        '''
Header is required, add header during initialization or pass header as parameter
in override header.''',
      );
    }

    // only double with two decimal places is allowed.
    // and remove the dot in decimal.
    final paymentAmountStr =
        paymentAmount.toStringAsFixed(2).replaceAll('.', '');

    final detail = TransactionModel(
      transactionType: '5122',
      billingRefNo: billingRefNo,
      paymentAmount: paymentAmountStr,
    );
    final header = overrideHeader?.copyWith(methodId: '1001') ??
        this.header?.copyWith(methodId: '1001');
    final requestBody =
        {'Header': header?.toJson(), 'Detail': detail.toJson()}.toString();

    final response = await FlutterPinelabsPlatform.instance
        .sendRequest(request: requestBody);
    return response != null ? ResponseModel.fromJson(response) : null;
  }

  /// do transaction for pinelabs device.
  /// calls pinelab device with MethodId 1001.
  ///
  /// [transactionType] is the transaction type from [TransactionType] enum.
  /// [billingRefNo] is the billing reference number.
  /// [paymentAmount] is the payment amount only two decimal places are allowed.
  /// if more than two decimal places are added then it will be rounded
  /// off using toStringAsFixed(2).
  /// [mobileNumberForEChargeSlip] is the mobile number for eChargeSlip.
  Future<ResponseModel?> doTransaction({
    required TransactionType transactionType,
    required double paymentAmount,
    String? billingRefNo,
    String? mobileNumberForEChargeSlip,
    HeaderModel? overrideHeader,
  }) async {
    if (overrideHeader == null && this.header == null) {
      throw Exception(
        '''
Header is required, add header during initialization or pass header as parameter
in override header.''',
      );
    }

    // only double with two decimal places is allowed.
    // and remove the dot in decimal.
    final paymentAmountStr =
        paymentAmount.toStringAsFixed(2).replaceAll('.', '');

    final detail = TransactionModel(
      transactionType: transactionType.code,
      billingRefNo: billingRefNo,
      paymentAmount: paymentAmountStr,
      mobileNumberForEChargeSlip: mobileNumberForEChargeSlip,
    );
    final header = overrideHeader?.copyWith(methodId: '1001') ??
        this.header?.copyWith(methodId: '1001');
    final requestBody =
        {'Header': header?.toJson(), 'Detail': detail.toJson()}.toString();
    final response = await FlutterPinelabsPlatform.instance
        .sendRequest(request: requestBody);
    return response != null ? ResponseModel.fromJson(response) : null;
  }

  /// Print paper-receipt on Plutus Smart Device using request
  /// request is a json string which can take any supported data as per
  /// pinelab documentation.
  ///
  /// e.g.
  /// ```
  /// {
  ///    "Header": {
  ///      "ApplicationId": "abcdefgh",
  ///      "UserId": "user1234",
  ///      "MethodId": "1002",
  ///      "VersionNo": "1.0"
  ///    },
  ///    "Detail": {
  ///      "PrintRefNo": "123456789",
  ///      "SavePrintData": true,
  ///      "Data": [
  ///        {
  ///          "PrintDataType": "0",
  ///          "PrinterWidth": 24,
  ///          "IsCenterAligned": true,
  ///          "DataToPrint": "String Data",
  ///          "ImagePath": "0",
  ///          "ImageData": "0"
  ///        },
  ///      ],
  ///    }
  /// }```
  Future<ResponseModel?> printData({
    required PrintModel printRequest,
    HeaderModel? overrideHeader,
  }) async {
    if (overrideHeader == null && this.header == null) {
      throw Exception(
        '''
Header is required, add header during initialization or pass header as parameter
in override header.''',
      );
    }

    final header = overrideHeader?.copyWith(methodId: '1002') ??
        this.header?.copyWith(methodId: '1002');
    final requestBody = {
      'Header': header?.toJson(),
      'Detail': printRequest.toJson()
    }.toString();

    final response = await FlutterPinelabsPlatform.instance
        .sendRequest(request: requestBody);
    return response != null ? ResponseModel.fromJson(response) : null;
  }
}

/// The available transaction types.
enum TransactionType {
  /// Transaction type for Credit/ Debit Card.
  card,

  /// Transaction type for COD Sale / Cash.
  cash,

  /// Transaction type for UPI.
  upi,

  /// Transaction type for Bharat QR Sale.
  bharatQrSale,
}

/// The available transaction types extension which
/// can be used to get the transaction type code.
extension TransactionValue on TransactionType {
  /// Get the transaction type code.
  String get code {
    switch (this) {
      case TransactionType.card:
        return '4001';
      case TransactionType.cash:
        return '4507';
      case TransactionType.upi:
        return '5120';
      case TransactionType.bharatQrSale:
        return '5123';
    }
  }
}
