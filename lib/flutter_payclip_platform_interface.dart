import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_payclip_method_channel.dart';

abstract class FlutterPayclipPlatform extends PlatformInterface {
  /// Constructs a FlutterPayclipPlatform.
  FlutterPayclipPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPayclipPlatform _instance = MethodChannelFlutterPayclip();

  /// The default instance of [FlutterPayclipPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPayclip].
  static FlutterPayclipPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPayclipPlatform] when
  /// they register themselves.
  static set instance(FlutterPayclipPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
