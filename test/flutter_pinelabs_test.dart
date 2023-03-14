import 'package:flutter_pinelabs/flutter_pinelabs.dart';
import 'package:flutter_pinelabs/flutter_pinelabs_method_channel.dart';
import 'package:flutter_pinelabs/flutter_pinelabs_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterPinelabsPlatform
    with MockPlatformInterfaceMixin
    implements FlutterPinelabsPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> sendRequest({required String request}) {
    return Future.value({'message': 'pinelab working'}.toString());
  }
}

void main() {
  final initialPlatform = FlutterPinelabsPlatform.instance;

  test('$MethodChannelFlutterPinelabs is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPinelabs>());
  });

  test('getPlatformVersion', () async {
    const flutterPinelabsPlugin = FlutterPinelabs();
    final fakePlatform = MockFlutterPinelabsPlatform();
    FlutterPinelabsPlatform.instance = fakePlatform;

    expect(await flutterPinelabsPlugin.getPlatformVersion(), '42');
  });

  group('sendRequest', () {
    test('calls sendRequest on platform.', () async {
      const flutterPinelabsPlugin = FlutterPinelabs();
      final fakePlatform = MockFlutterPinelabsPlatform();
      FlutterPinelabsPlatform.instance = fakePlatform;

      final result =
          await flutterPinelabsPlugin.sendRequest(request: 'request1');
      PlatformInterface.verify(
        FlutterPinelabsPlatform.instance,
        fakePlatform.sendRequest(request: 'request'),
      );
      expect(result, {'message': 'pinelab working'}.toString());
    });
  });
}
