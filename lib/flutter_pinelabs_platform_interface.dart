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

  /// Gets the platform version.
  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// send request for pinelabs device using [request]
  /// [request] is a json string which can take any supported data
  /// e.g.
  /// ```
  /// {
  /// 	"Header": {
  /// 		"ApplicationId": "abcdefgh",
  /// 		"UserId": "user1234",
  /// 		"MethodId": "1001",
  /// 		"VersionNo": "1.0"
  /// 	},
  /// 	"Detail": {
  /// 		"TransactionType": "4001",
  /// 		"BillingRefNo": "TXN12345678",
  /// 		"PaymentAmount": "9999000",
  /// 		"MobileNumberForEChargeSlip": "9876543210",
  /// 		"AdditionalInfo": {
  /// 			"Split1": "99991",
  /// 			"Split2": "99992",
  /// 			"Split3": "99993"
  /// 		}
  /// 	}
  /// }
  /// ```
  Future<String?> sendRequest({required String request}) {
    throw UnimplementedError('doTransaction() has not been implemented.');
  }
}
