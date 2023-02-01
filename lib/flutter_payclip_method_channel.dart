import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_payclip_platform_interface.dart';

/// An implementation of [FlutterPayclipPlatform] that uses method channels.
class MethodChannelFlutterPayclip extends FlutterPayclipPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_payclip');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
