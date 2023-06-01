// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter_pinelabs/models/header_model.dart';
import 'package:flutter_pinelabs/models/scan_product_model.dart';

/// converts pinelabs response to dart object
@immutable
class ScanModel {
  /// converts pinelabs response to dart object
  /// [header] is the header of the response. Which
  /// is same as the [header] passed in request.
  /// [responseCode] is the response code of the response.
  /// [responseMsg] is the response message of the response.
  /// [rawResponse] is the string response received from pinelabs.
  /// [scannedProducts] is the list of details of scanned products
  /// i.ee gives the list of [ScanProductModel] carrying itemCount & itemDetails
  const ScanModel({
    required this.header,
    required this.responseCode,
    required this.responseMsg,
    this.rawResponse = '',
    required this.scannedProducts,
  });

  /// get [ScanModel] from [map].
  factory ScanModel.fromMap(Map<String, dynamic> map) {
    final code = map['Response']['ResponseCode'];
    final productCode = map['Detail']['ScannedData'];
    // final List<Map<String, dynamic>> scannedProducts =
    //     List<Map<String, dynamic>>.from(map['Detail']['ScannedData']);

    return ScanModel(
      header: HeaderModel.fromMap(map['Header']),
      responseCode: code is int ? code : int.tryParse(code) ?? 0,
      responseMsg: map['Response']['ResponseMsg'] ?? '',
      rawResponse: json.encode(map),
      scannedProducts: [
        ScanProductModel(
          itemCount: 1,
          itemValue: productCode.toString(),
        ),
      ],
    );
  }

  /// get [ScanModel] from [json] string.
  factory ScanModel.fromJson(String source) =>
      ScanModel.fromMap(json.decode(source));

  /// [header] is the header of the response. Which
  /// is same as the [header] passed in request.
  final HeaderModel header;

  /// [responseCode] is the response code of the response.
  final int responseCode;

  /// [responseMsg] is the response message of the response.
  final String responseMsg;

  /// [rawResponse] is the string response received from pinelabs.
  final String rawResponse;

  /// [scannedProducts] is the List of scanned items response,
  /// received from pinelabs.
  final List<ScanProductModel> scannedProducts;

  /// get map from [ScanModel].
  Map<String, dynamic> toMap() {
    return json.decode(rawResponse);
  }

  /// get json string from [ScanModel].
  String toJson() => json.encode(toMap());

  /// copy new instance of [ScanModel].
  ScanModel copyWith({
    HeaderModel? header,
    int? responseCode,
    String? responseMsg,
    String? rawResponse,
    List<ScanProductModel>? scannedProducts,
  }) {
    return ScanModel(
      header: header ?? this.header,
      responseCode: responseCode ?? this.responseCode,
      responseMsg: responseMsg ?? this.responseMsg,
      rawResponse: rawResponse ?? this.rawResponse,
      scannedProducts: scannedProducts ?? this.scannedProducts,
    );
  }

  @override
  String toString() {
    return '''ScanModel(header: $header, responseCode: $responseCode, responseMsg: $responseMsg, rawResponse: $rawResponse, scanProducts: $scannedProducts)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScanModel &&
        other.header == header &&
        other.responseCode == responseCode &&
        other.responseMsg == responseMsg &&
        // remove all whitespace from rawResponse
        other.rawResponse.replaceAll(RegExp(r'\s+'), '') ==
            rawResponse.replaceAll(RegExp(r'\s+'), '');
  }

  @override
  int get hashCode {
    return header.hashCode ^
        responseCode.hashCode ^
        responseMsg.hashCode ^
        rawResponse.hashCode ^
        scannedProducts.hashCode;
  }
}
