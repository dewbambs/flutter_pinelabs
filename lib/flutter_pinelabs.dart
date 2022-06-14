import 'package:flutter_pinelabs/flutter_pinelabs_platform_interface.dart';
import 'package:flutter_pinelabs/models/header_model.dart';
import 'package:flutter_pinelabs/models/response_model.dart';
import 'package:flutter_pinelabs/models/transaction_model.dart';

/// An implementation of Pinelabs Platform Interface that uses method channels.
/// docs for pinelabs: https://developer.pinelabs.com/plutus-smart/docs
class FlutterPinelabs {
  /// An implementation of Pinelabs Platform Interface that uses method channels
  /// docs for pinelabs: https://developer.pinelabs.com/plutus-smart/docs
  /// [applicationId] assigned by pinelabs to your application.
  /// this application id is linked to your package id.
  /// [userId] is the user id of the user which is logged-in.
  /// [methodId] is the method id of the method which is called.
  /// default to 1001 that is do transaction.
  /// [versionNo] by default 1.0.
  const FlutterPinelabs({
    required this.applicationId,
    this.userId,
    this.methodId = '1001',
    this.versionNo = '1.0',
  });

  /// [applicationId] assigned by pinelabs to your application.
  /// this application id is linked to your package id.
  final String applicationId;

  /// [userId] is the user id of the user which is logged-in.
  final String? userId;

  /// [methodId] is the method id of the method which is called.
  /// default to 1001 that is do transaction.
  final String methodId;

  /// [versionNo] by default 1.0.
  final String versionNo;

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

  /// do transaction for pinelabs device.
  /// calls pinelab device with MethodId 1001.
  ///
  /// [transactionType] is the transaction type from [TransactionType] enum.
  /// [billingRefNo] is the billing reference number.
  /// [paymentAmount] is the payment amount.
  /// [mobileNumberForEChargeSlip] is the mobile number for eChargeSlip.
  Future<ResponseModel?> doTransaction({
    required TransactionType transactionType,
    String? billingRefNo,
    int? paymentAmount,
    String? mobileNumberForEChargeSlip,
    HeaderModel? overrideHeader,
  }) async {
    final detail = TransactionModel(
      transactionType: transactionType.code,
      billingRefNo: billingRefNo,
      paymentAmount: paymentAmount.toString(),
      mobileNumberForEChargeSlip: mobileNumberForEChargeSlip,
    );
    final header = overrideHeader ??
        HeaderModel(
          applicationId: applicationId,
          userId: userId,
          methodId: methodId,
          versionNo: versionNo,
        );
    final requestBody =
        {'Header': header.toJson(), 'Detail': detail.toJson()}.toString();

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
