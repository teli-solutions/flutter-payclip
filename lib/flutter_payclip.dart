import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPayclip {
  static const MethodChannel _channel = MethodChannel('flutter_payclip');

  static Future<String> getPlatformVersion() async {
    return await _channel.invokeMethod('getPlatformVersion');
  }

  static Future<bool> init() async {
    return await _channel.invokeMethod('init');
  }

  static Future<bool> settings() async {
    return await _channel.invokeMethod('settings');
  }

  static Future<String> payment({
    required double amount,
    required bool enableContactless,
    required bool enableTips,
    required bool roundTips,
    required bool enablePayWithPoints,
    required String customTransactionId
  }) async {
    return await _channel.invokeMethod('payment', {
      "amount": amount,
      "enableContactless": enableContactless,
      "enableTips": enableTips,
      "roundTips": roundTips,
      "enablePayWithPoints": enablePayWithPoints,
      "customTransactionId": customTransactionId
    });
  }
}
