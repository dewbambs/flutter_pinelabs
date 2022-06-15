import 'dart:convert';

import 'package:flutter_pinelabs/models/header_model.dart';
import 'package:flutter_pinelabs/models/response_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tJsonResponse =
      '''
{
	"Header": {
		"ApplicationId": "abcdefgh",
		"UserId": "user1234",
		"MethodId": "1001",
		"VersionNo": "1.0"
	},
	"Response": {
		"ResponseCode": "00",
		"ResponseMsg": "Success"
	},
	"Detail": {
		"Payments": [{
			"BillingRefNo": "105",
			"ApprovalCode": "7261A9",
			"HostResponse": "APPROVED",
			"CardNumber": "438624*******2802",
			"ExpiryDate": "0406",
			"CardholderName": "AMITMOHAN",
			"CardType": "VISA",
			"InvoiceNumber": 11,
			"BatchNumber": 2,
			"TerminalId": "30000001",
			"LoyaltyPointsAwarded": 1,
			"Remark": "PROCESSED",
			"AcquirerName": "Acquiring Bank 1",
			"MerchantId": "000100090015607",
			"RetrievalReferenceNumber": "624615343002",
			"CardEntryMode": 1,
			"PrintCardholderName": 1,
			"MerchantName": "HPCL Area 18",
			"MerchantAddress": "Kamala Mills",
			"MerchantCity": "Noida",
			"PlutusVersion": "1.51 ICICI BANK",
			"AquiringBankCode": 2,
			"TransactionDate": "02012011",
			"TransactionTime": "210403",
			"PineLabsClientId": 12345,
			"PineLabsBatchId": 9002,
			"PineLabsRoc": 105
		}]
	}
}
''';

  const tResponse = ResponseModel(
    header: HeaderModel(
      applicationId: 'abcdefgh',
      userId: 'user1234',
      methodId: '1001',
      versionNo: '1.0',
    ),
    responseCode: 0,
    responseMsg: 'Success',
    rawResponse: tJsonResponse,
  );

  test('should support value comparison.', () {
    expect(
      ResponseModel.fromJson(tJsonResponse),
      ResponseModel.fromJson(tJsonResponse),
    );
  });

  test('from map return expected ResponseModel.', () {
    expect(
      ResponseModel.fromMap(json.decode(tJsonResponse)),
      const ResponseModel(
        header: HeaderModel(
          applicationId: 'abcdefgh',
          userId: 'user1234',
          methodId: '1001',
          versionNo: '1.0',
        ),
        responseCode: 0,
        responseMsg: 'Success',
        rawResponse: tJsonResponse,
      ),
    );
  });

  test('from json return expected ResponseModel.', () {
    expect(
      ResponseModel.fromJson(tJsonResponse),
      const ResponseModel(
        header: HeaderModel(
          applicationId: 'abcdefgh',
          userId: 'user1234',
          methodId: '1001',
          versionNo: '1.0',
        ),
        responseCode: 0,
        responseMsg: 'Success',
        rawResponse: tJsonResponse,
      ),
    );
  });

  test('copyWith return expected ResponseModel.', () {
    expect(
      tResponse.copyWith(
        header: tResponse.header.copyWith(
          applicationId: 'abcdefgh',
          userId: 'user1234',
          methodId: '1001',
          versionNo: '1.0',
        ),
        responseCode: 0,
        responseMsg: 'Success',
        rawResponse: json.decode(tJsonResponse).toString(),
      ),
      ResponseModel(
        header: const HeaderModel(
          applicationId: 'abcdefgh',
          userId: 'user1234',
          methodId: '1001',
          versionNo: '1.0',
        ),
        responseCode: 0,
        responseMsg: 'Success',
        rawResponse: json.decode(tJsonResponse).toString(),
      ),
    );
  });

  test('toJson return expected ResponseModel.', () {
    expect(
      tResponse.toJson(),
      equalsIgnoringWhitespace(json.encode(json.decode(tJsonResponse))),
    );
  });

  test('toMap return expected ResponseModel.', () {
    expect(
      tResponse.toMap(),
      json.decode(tJsonResponse),
    );
  });

  test('fromMap returns expected reponsemodel when response code is int.', () {
    const map = {
      'Header': {
        'ApplicationId': 'something',
        'MethodId': '1001',
        'VersionNo': '1.0'
      },
      'Response': {'ResponseCode': 0, 'ResponseMsg': 'Success'},
    };

    expect(
      ResponseModel.fromMap(map),
      ResponseModel(
        header: const HeaderModel(
          applicationId: 'something',
          methodId: '1001',
          versionNo: '1.0',
        ),
        responseCode: 0,
        responseMsg: 'Success',
        rawResponse: json.encode(map),
      ),
    );
  });

  test('toString return expected ResponseModel.', () {
    final tResponse = ResponseModel.fromJson(tJsonResponse);
    expect(
      tResponse.toString(),
      equalsIgnoringWhitespace(
        '''ResponseModel(header: ${tResponse.header.toString()}, responseCode: 0, responseMsg: Success, rawResponse: ${json.encode(json.decode(tJsonResponse))})''',
      ),
    );
  });
}
