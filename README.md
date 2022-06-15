# flutter_pinelabs

A new Flutter plugin project.

## Pinelabs Request and Response

Request to the device:
```json
{
  "Header": {
    "ApplicationId": "something",
    "UserId": "1",
    "MethodId": "1001",
    "VersionNo": "1.0"
  },
  "Detail": {
    "TransactionType": "4001",
    "BillingRefNo": "TXN12345678",
    "PaymentAmount": "9999000",
    "MobileNumberForEChargeSlip": "9876543210",
    "AdditionalInfo": {
      "Split1": "99991",
      "Split2": "99992",
      "Split3": "99993"
    }
  }
}
```

Failure Response from the device when timedout:
```json
{
  "Header": {
    "ApplicationId": "something",
    "MethodId": "1001",
    "UserId": "1",
    "VersionNo": "1.0"
  },
  "Response": {
    "AppVersion": "638",
    "ParameterJson": "parameter",
    "ResponseCode": 7,
    "ResponseMsg": "Something went wrong!"
  }
}
```

Failer Response from the device when back pressed:
```json
{
  "Header": {
    "ApplicationId": "something",
    "MethodId": "1001",
    "UserId": "1",
    "VersionNo": "1.0"
  },
  "Response": {
    "AppVersion": "638",
    "ParameterJson": "parameter",
    "ResponseCode": 7,
    "ResponseMsg": "Card reading Error"
  }
}
```

Success Reponse from the device:
```json
{
  "Detail": {
    "AcquirerName": "ICICI BANK",
    "AcquiringBankCode": "02",
    "ApprovalCode": "00",
    "AuthAmoutPaise": "9999000",
    "BatchNumber": 4,
    "BillingRefNo": "TXN12345678",
    "CardEntryMode": "CARD_CHIP",
    "CardNumber": "************abcd",
    "CardType": "VISA",
    "CardholderName": "Some Person",
    "ExpiryDate": "XXXX",
    "HostResponse": "APPROVED",
    "InvoiceNumber": 1,
    "LoyaltyPointsAwarded": 0,
    "MerchantAddress": "JANAKPURI",
    "MerchantCity": "NEW DELHI    DEL       ",
    "MerchantId": "               ",
    "MerchantName": "LOVE COMMUNICATION",
    "PlutusTransactionLogID": "4295187240",
    "PlutusVersion": "Plutus v2.12 MT ICICI BANK",
    "PosEntryMode": 2,
    "PrintCardholderName": 1,
    "Remark": "PROCESSED",
    "RetrievalReferenceNumber": "000000000020",
    "TerminalId": "30365626",
    "TransactionDate": "06132022",
    "TransactionTime": "150726",
    "TransactionType": 4001
  },
  "Header": {
    "ApplicationId": "something",
    "MethodId": "1001",
    "UserId": "1",
    "VersionNo": "1.0"
  },
  "Response": {
    "AppVersion": "638",
    "ParameterJson": "parameter",
    "ResponseCode": 0,
    "ResponseMsg": "APPROVED"
  }
}
```


