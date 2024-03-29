// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter_pinelabs/models/header_model.dart';

/// converts pinelabs response to dart object
@immutable
class ResponseModel {
  /// converts pinelabs response to dart object
  /// [header] is the header of the response. Which
  /// is same as the [header] passed in request.
  /// [responseCode] is the response code of the response.
  /// [responseMsg] is the response message of the response.
  /// [rawResponse] is the string response received from pinelabs.
  const ResponseModel({
    required this.header,
    required this.responseCode,
    required this.responseMsg,
    this.rawResponse = '',
    this.scannedData = '',
  });

  /// get [ResponseModel] from [map].
  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    final code = map['Response']['ResponseCode'];

    return ResponseModel(
      header: HeaderModel.fromMap(map['Header']),
      responseCode: code is int ? code : int.tryParse(code) ?? 0,
      responseMsg: map['Response']['ResponseMsg'] ?? '',
      scannedData: map['Detail']?['ScannedData'] ?? '',
      rawResponse: json.encode(map),
    );
  }

  /// get [ResponseModel] from [json] string.
  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source));

  /// [header] is the header of the response. Which
  /// is same as the [header] passed in request.
  final HeaderModel header;

  /// [responseCode] is the response code of the response.
  final int responseCode;

  /// [responseMsg] is the response message of the response.
  final String responseMsg;

  /// [rawResponse] is the string response received from pinelabs.
  final String rawResponse;

  /// [scannedData] is the String response received from the scanner methods.
  final String scannedData;

  /// get map from [ResponseModel].
  Map<String, dynamic> toMap() {
    return json.decode(rawResponse);
  }

  /// get json string from [ResponseModel].
  String toJson() => json.encode(toMap());

  /// copy new instance of [ResponseModel].
  ResponseModel copyWith({
    HeaderModel? header,
    int? responseCode,
    String? responseMsg,
    String? rawResponse,
    String? scannedData,
  }) {
    return ResponseModel(
      header: header ?? this.header,
      responseCode: responseCode ?? this.responseCode,
      responseMsg: responseMsg ?? this.responseMsg,
      rawResponse: rawResponse ?? this.rawResponse,
      scannedData: scannedData ?? this.scannedData,
    );
  }

  @override
  String toString() {
    return '''ResponseModel(header: $header, responseCode: $responseCode, responseMsg: $responseMsg, rawResponse: $rawResponse, scannedData: $scannedData)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResponseModel &&
        other.header == header &&
        other.responseCode == responseCode &&
        other.responseMsg == responseMsg &&
        other.scannedData == scannedData &&
        // remove all whitespace from rawResponse
        other.rawResponse.replaceAll(RegExp(r'\s+'), '') ==
            rawResponse.replaceAll(RegExp(r'\s+'), '');
  }

  @override
  int get hashCode {
    return header.hashCode ^
        responseCode.hashCode ^
        responseMsg.hashCode ^
        scannedData.hashCode ^
        rawResponse.hashCode;
  }
}
