import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pinelabs/flutter_pinelabs_method_channel.dart';

void main() {
  MethodChannelFlutterPinelabs platform = MethodChannelFlutterPinelabs();
  const MethodChannel channel = MethodChannel('flutter_pinelabs');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
