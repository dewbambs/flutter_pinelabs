import 'dart:convert';

import 'package:flutter/material.dart';

/// model class for headers in the request.
@immutable
class HeaderModel {
  /// A model class for pine lab headers.
  /// [applicationId] assigned by pinelabs to your application.
  /// this application id is linked to your package id.
  /// [userId] is the user id of the user which is logged-in.
  /// [methodId] is the method id of the method which is called.
  /// [versionNo] for pinelabs.
  const HeaderModel({
    required this.applicationId,
    this.userId,
    required this.methodId,
    required this.versionNo,
  });

  /// get [HeaderModel] from [map].
  factory HeaderModel.fromMap(Map<String, dynamic> map) {
    return HeaderModel(
      applicationId: map['ApplicationId'] ?? '',
      userId: map['UserId'],
      methodId: map['MethodId'] ?? '',
      versionNo: map['VersionNo'] ?? '',
    );
  }

  /// get [HeaderModel] from [json] string.
  factory HeaderModel.fromJson(String source) =>
      HeaderModel.fromMap(json.decode(source));

  /// [applicationId] assigned by pinelabs to your application.
  /// this application id is linked to your package id.
  final String applicationId;

  /// [userId] is the user id of the user which is logged-in.
  final String? userId;

  /// [methodId] is the method id of the method which is called.
  final String methodId;

  /// [versionNo] for pinelabs.
  final String versionNo;

  /// copy new instance of [HeaderModel].
  HeaderModel copyWith({
    String? applicationId,
    String? userId,
    String? methodId,
    String? versionNo,
  }) {
    return HeaderModel(
      applicationId: applicationId ?? this.applicationId,
      userId: userId ?? this.userId,
      methodId: methodId ?? this.methodId,
      versionNo: versionNo ?? this.versionNo,
    );
  }

  /// create [HeaderModel] to map.
  Map<String, dynamic> toMap() {
    return {
      'ApplicationId': applicationId,
      'UserId': userId,
      'MethodId': methodId,
      'VersionNo': versionNo,
    };
  }

  /// create [HeaderModel] to json string.
  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return '''HeaderModel(ApplicationId: $applicationId, UserId: $userId, MethodId: $methodId, VersionNo: $versionNo)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HeaderModel &&
        other.applicationId == applicationId &&
        other.userId == userId &&
        other.methodId == methodId &&
        other.versionNo == versionNo;
  }

  @override
  int get hashCode {
    return applicationId.hashCode ^
        userId.hashCode ^
        methodId.hashCode ^
        versionNo.hashCode;
  }
}
