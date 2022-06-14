import 'package:flutter/services.dart';
import 'package:flutter_pinelabs/flutter_pinelabs_method_channel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final MethodChannelFlutterPinelabs platform = MethodChannelFlutterPinelabs();
  const MethodChannel channel = MethodChannel('flutter_pinelabs');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'getPlatformVersion':
          return '42';
        case 'doTransaction':
          return {'message': 'pinelab working'}.toString();
        default:
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });

  test('sendRequest', () async {
    final result = await platform.sendRequest(request: 'request');

    channel.checkMockMethodCallHandler((MethodCall methodCall) {
      expect(methodCall.method, 'doTransaction');
      expect(methodCall.arguments, {'request': 'request'});
    });
    expect(result, {'message': 'pinelab working'}.toString());
  });
}
