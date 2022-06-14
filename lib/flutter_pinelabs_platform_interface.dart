import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_pinelabs_method_channel.dart';

abstract class FlutterPinelabsPlatform extends PlatformInterface {
  /// Constructs a FlutterPinelabsPlatform.
  FlutterPinelabsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPinelabsPlatform _instance = MethodChannelFlutterPinelabs();

  /// The default instance of [FlutterPinelabsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPinelabs].
  static FlutterPinelabsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPinelabsPlatform] when
  /// they register themselves.
  static set instance(FlutterPinelabsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> doTransaction({required String request}) {
    throw UnimplementedError('doTransaction() has not been implemented.');
  }
}
