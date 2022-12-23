// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter_pinelabs/models/print_row_model.dart';

/// A model class for printing data
@immutable
class PrintModel {
  /// A model class for printing data
  const PrintModel({
    required this.printRefNo,
    required this.savePrintData,
    required this.data,
  });

  /// from json
  factory PrintModel.fromJson(String source) =>
      PrintModel.fromMap(json.decode(source));

  /// to map
  factory PrintModel.fromMap(Map<String, dynamic> map) {
    return PrintModel(
      printRefNo: map['PrintRefNo'] ?? '',
      savePrintData: map['SavePrintData'] ?? true,
      data: List<PrintRowModel>.from(
        map['Data']?.map(PrintRowModel.fromMap),
      ),
    );
  }

  /// Unique reference number from Billing App
  final String printRefNo;

  /// Set this parameter to save the Print Data at
  /// Plutus Smart Device. Default value is TRUE
  final bool savePrintData;

  /// Array of print lines
  final List<PrintRowModel> data;

  ///
  PrintModel copyWith({
    String? printRefNo,
    bool? savePrintData,
    List<PrintRowModel>? data,
  }) {
    return PrintModel(
      printRefNo: printRefNo ?? this.printRefNo,
      savePrintData: savePrintData ?? this.savePrintData,
      data: data ?? this.data,
    );
  }

  /// to map
  Map<String, dynamic> toMap() {
    return {
      'PrintRefNo': printRefNo,
      'SavePrintData': savePrintData,
      'Data': data.map((x) => x.toMap()).toList(),
    };
  }

  /// to json
  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      '''PrintModel(printRefNo: $printRefNo, savePrintData: $savePrintData, data: $data)''';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PrintModel &&
        other.printRefNo == printRefNo &&
        other.savePrintData == savePrintData &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode =>
      printRefNo.hashCode ^ savePrintData.hashCode ^ data.hashCode;
}
