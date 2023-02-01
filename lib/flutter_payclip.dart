
import 'flutter_payclip_platform_interface.dart';

class FlutterPayclip {
  Future<String?> getPlatformVersion() {
    return FlutterPayclipPlatform.instance.getPlatformVersion();
  }
}
