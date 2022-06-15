import 'package:flutter_pinelabs/flutter_pinelabs_platform_interface.dart';
import 'package:flutter_pinelabs/models/header_model.dart';
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
    if (overrideHeader == null && this.header == null) {
      throw Exception(
        '''
Header is required, add header during initialization or pass header as parameter
in override header.''',
      );
    }

    final detail = TransactionModel(
      transactionType: transactionType.code,
      billingRefNo: billingRefNo,
      paymentAmount: paymentAmount.toString(),
      mobileNumberForEChargeSlip: mobileNumberForEChargeSlip,
    );
    final header = overrideHeader ?? this.header;
    final requestBody =
        {'Header': header?.toJson(), 'Detail': detail.toJson()}.toString();

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
