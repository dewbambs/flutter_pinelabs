import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter_pinelabs/flutter_pinelabs_platform_interface.dart';

/// An implementation of [FlutterPinelabsPlatform] that uses method channels.
class MethodChannelFlutterPinelabs extends FlutterPinelabsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_pinelabs');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> sendRequest({required String request}) async {
    final version = await methodChannel
        .invokeMethod<String>('doTransaction', {'request': request});
    return version;
  }
}
