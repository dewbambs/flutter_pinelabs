import 'dart:convert';

import 'package:flutter/foundation.dart';

/// This class holds the scanned product details:
/// 1. scanned product count i.e. itemCount
/// 2. scanned product value i.e itemValue
/// Note : Should be used in multi Scan flow only
@immutable
class ScanProductModel {
  /// converts pinelabs response to dart object
  /// [itemCount] is the count of item scanned in multi scann.
  /// [itemValue] is the value of the scanned item.
  const ScanProductModel({
    required this.itemCount,
    required this.itemValue,
  });

  /// get [ScanProductModel] from [json].
  factory ScanProductModel.fromJson(String source) =>
      ScanProductModel.fromMap(json.decode(source));

  /// get [ScanProductModel] from [map].
  factory ScanProductModel.fromMap(Map<String, dynamic> map) {
    return ScanProductModel(
      itemCount: map['itemCount'] ?? '',
      itemValue: map['itemValue'] ?? '',
    );
  }

  /// get map from [ScanProductModel].
  Map<String, dynamic> toMap() {
    return {
      'itemCount': itemCount,
      'itemValue': itemValue,
    };
  }

  /// get json from [ScanProductModel]
  String toJson() => json.encode(toMap());

  /// copy new instance of [ScanProductModel].
  ScanProductModel copyWith({
    int? itemCount,
    String? itemValue,
  }) {
    return ScanProductModel(
      itemCount: itemCount ?? this.itemCount,
      itemValue: itemValue ?? this.itemValue,
    );
  }

  /// ItemCount of the scanned product
  final int itemCount;

  /// Item value of the scanned product
  final String itemValue;

  @override
  String toString() {
    return '''ScanProductModel(itemCount: $itemCount, itemValue: $itemValue)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScanProductModel &&
        other.itemCount == itemCount &&
        other.itemValue == itemValue;
  }

  @override
  int get hashCode {
    return itemCount.hashCode ^ itemValue.hashCode;
  }
}
