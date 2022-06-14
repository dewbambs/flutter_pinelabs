import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_pinelabs_platform_interface.dart';

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
  Future<String?> doTransaction({required String request}) async {
    final version = await methodChannel.invokeMethod<String>(
        'doTransaction', <String, dynamic>{'request': request});
    return version;
  }
}
