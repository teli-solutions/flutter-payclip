import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_payclip/flutter_payclip.dart';
import 'package:flutter_payclip/flutter_payclip_platform_interface.dart';
import 'package:flutter_payclip/flutter_payclip_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterPayclipPlatform
    with MockPlatformInterfaceMixin
    implements FlutterPayclipPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterPayclipPlatform initialPlatform = FlutterPayclipPlatform.instance;

  test('$MethodChannelFlutterPayclip is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPayclip>());
  });

  test('getPlatformVersion', () async {
    FlutterPayclip flutterPayclipPlugin = FlutterPayclip();
    MockFlutterPayclipPlatform fakePlatform = MockFlutterPayclipPlatform();
    FlutterPayclipPlatform.instance = fakePlatform;

    expect(await flutterPayclipPlugin.getPlatformVersion(), '42');
  });
}
