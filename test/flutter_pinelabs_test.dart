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
  Future<String?> doTransaction({required String request}) {
    // TODO: implement doTransaction
    throw UnimplementedError();
  }

  @override
  Future<String?> sendRequest({required String request}) {
    // TODO: implement sendRequest
    throw UnimplementedError();
  }
}

void main() {
  final FlutterPinelabsPlatform initialPlatform =
      FlutterPinelabsPlatform.instance;

  test('$MethodChannelFlutterPinelabs is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPinelabs>());
  });

  test('getPlatformVersion', () async {
    const flutterPinelabsPlugin = FlutterPinelabs(applicationId: 'abcdefgh');
    final fakePlatform = MockFlutterPinelabsPlatform();
    FlutterPinelabsPlatform.instance = fakePlatform;

    expect(await flutterPinelabsPlugin.getPlatformVersion(), '42');
  });
}
