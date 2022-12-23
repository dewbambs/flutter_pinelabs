// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:flutter/foundation.dart';

/// print row data for each row of printed bill.
@immutable
class PrintRowModel {
  /// PrintRowModel is each row within the
  const PrintRowModel({
    required this.printDataType,
    required this.printerWidth,
    this.isCenterAligned = true,
    this.dataToPrint,
    this.imagePath = '0',
    this.imageData = '0',
  });

  /// convert to json
  factory PrintRowModel.fromJson(String source) =>
      PrintRowModel.fromMap(json.decode(source));

  /// create [PrintRowModel] from map
  factory PrintRowModel.fromMap(Map<String, dynamic> map) {
    return PrintRowModel(
      printDataType: map['printDataType'] ?? '0',
      printerWidth: map['printerWidth']?.toInt() ?? 0,
      isCenterAligned: map['isCenterAligned'] ?? false,
      dataToPrint: map['dataToPrint'],
      imagePath: map['imagePath'],
      imageData: map['imageData'],
    );
  }

  /// Data Type will be as following
  /// Integer
  /// Yes
  /// PrintText =0
  /// PrintImageByPath =1
  /// PrintImageDump =2
  /// PrintBarcode=3
  /// PrintQRCode=4
  final String printDataType;

  /// Line Width of Printer, Possible values: 24,32,48
  final int printerWidth;

  /// It will contain true or false for data to be printed in center-aligned
  /// or not
  final bool isCenterAligned;

  /// It contains data to print in form of String.
  final String? dataToPrint;

  /// It contains image path from Device external storage
  final String imagePath;

  /// It contains image data in form of encoded string
  final String imageData;

  /// convert [PrintRowModel] to Map
  Map<String, dynamic> toMap() {
    return {
      'PrintDataType': printDataType,
      'PrinterWidth': printerWidth,
      'IsCenterAligned': isCenterAligned,
      'DataToPrint': dataToPrint,
      'ImagePath': imagePath,
      'ImageData': imageData,
    };
  }

  /// convert [PrintRowModel] json
  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return '''
PrintRowModel(printDataType: $printDataType, printerWidth: $printerWidth, isCenterAligned: $isCenterAligned, dataToPrint: $dataToPrint, imagePath: $imagePath, imageData: $imageData)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PrintRowModel &&
        other.printDataType == printDataType &&
        other.printerWidth == printerWidth &&
        other.isCenterAligned == isCenterAligned &&
        other.dataToPrint == dataToPrint &&
        other.imagePath == imagePath &&
        other.imageData == imageData;
  }

  @override
  int get hashCode {
    return printDataType.hashCode ^
        printerWidth.hashCode ^
        isCenterAligned.hashCode ^
        dataToPrint.hashCode ^
        imagePath.hashCode ^
        imageData.hashCode;
  }
}
