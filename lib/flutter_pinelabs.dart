import 'flutter_pinelabs_platform_interface.dart';

class FlutterPinelabs {
  Future<String?> getPlatformVersion() {
    return FlutterPinelabsPlatform.instance.getPlatformVersion();
  }

  Future<String?> doTransaction({required String request}) {
    return FlutterPinelabsPlatform.instance.doTransaction(request: request);
  }
}
