// ignore_for_file: prefer_const_constructors

import 'package:flutter_pinelabs/models/header_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('supports value comparison', () {
    expect(
      HeaderModel(
        applicationId: 'a',
        userId: 'u',
        methodId: 'm',
        versionNo: 'v',
      ),
      HeaderModel(
        applicationId: 'a',
        userId: 'u',
        methodId: 'm',
        versionNo: 'v',
      ),
    );
  });

  group('fromMap', () {
    test('returns a HeaderModel', () {
      expect(
        HeaderModel.fromMap(const {
          'ApplicationId': 'a',
          'UserId': 'u',
          'MethodId': 'm',
          'VersionNo': 'v',
        }),
        HeaderModel(
          applicationId: 'a',
          userId: 'u',
          methodId: 'm',
          versionNo: 'v',
        ),
      );
    });
  });

  group('fromJson', () {
    test('returns a HeaderModel', () {
      expect(
        HeaderModel.fromJson(
          '{"ApplicationId":"a","UserId":"u","MethodId":"m","VersionNo":"v"}',
        ),
        HeaderModel(
          applicationId: 'a',
          userId: 'u',
          methodId: 'm',
          versionNo: 'v',
        ),
      );
    });
  });

  group('copyWith', () {
    const tHeader = HeaderModel(
      applicationId: 'a',
      userId: 'u',
      methodId: 'm',
      versionNo: 'v',
    );

    test('returns updates applicationId', () {
      expect(
        tHeader.copyWith(applicationId: 'b'),
        HeaderModel(
          applicationId: 'b',
          userId: 'u',
          methodId: 'm',
          versionNo: 'v',
        ),
      );
    });

    test('returns updates userId', () {
      expect(
        tHeader.copyWith(userId: 'b'),
        HeaderModel(
          applicationId: 'a',
          userId: 'b',
          methodId: 'm',
          versionNo: 'v',
        ),
      );
    });

    test('returns updates methodId', () {
      expect(
        tHeader.copyWith(methodId: 'b'),
        HeaderModel(
          applicationId: 'a',
          userId: 'u',
          methodId: 'b',
          versionNo: 'v',
        ),
      );
    });

    test('returns updates versionNo', () {
      expect(
        tHeader.copyWith(versionNo: 'b'),
        HeaderModel(
          applicationId: 'a',
          userId: 'u',
          methodId: 'm',
          versionNo: 'b',
        ),
      );
    });
  });

  group('toMap', () {
    test('returns a map', () {
      expect(
        HeaderModel(
          applicationId: 'a',
          userId: 'u',
          methodId: 'm',
          versionNo: 'v',
        ).toMap(),
        {
          'ApplicationId': 'a',
          'UserId': 'u',
          'MethodId': 'm',
          'VersionNo': 'v',
        },
      );
    });

    test('returns a map with null userId when userId is null', () {
      expect(
        HeaderModel(
          applicationId: 'a',
          methodId: 'm',
          versionNo: 'v',
        ).toMap(),
        {
          'ApplicationId': 'a',
          'UserId': null,
          'MethodId': 'm',
          'VersionNo': 'v',
        },
      );
    });
  });

  group('toJson', () {
    test('returns a json string', () {
      expect(
        HeaderModel(
          applicationId: 'a',
          userId: 'u',
          methodId: 'm',
          versionNo: 'v',
        ).toJson(),
        '{"ApplicationId":"a","UserId":"u","MethodId":"m","VersionNo":"v"}',
      );
    });

    test('returns a json string with null userId when userId is null', () {
      expect(
        HeaderModel(
          applicationId: 'a',
          methodId: 'm',
          versionNo: 'v',
        ).toJson(),
        '{"ApplicationId":"a","UserId":null,"MethodId":"m","VersionNo":"v"}',
      );
    });
  });

  test('toString return correct string', () {
    expect(
      HeaderModel(
        applicationId: 'a',
        userId: 'u',
        methodId: 'm',
        versionNo: 'v',
      ).toString(),
      'HeaderModel(ApplicationId: a, UserId: u, MethodId: m, VersionNo: v)',
    );
  });
}
