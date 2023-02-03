import 'dart:async';
import 'package:flutter/services.dart';

class FlutterPayClip {
  static const MethodChannel _channel = MethodChannel('flutter_payclip');

  Future<bool> init() async {
    return await _channel.invokeMethod('init');
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    return await _channel.invokeMethod('login', {
      "email": email,
      "password": password
    });
  }

  Future<bool> logout() async {
    return await _channel.invokeMethod('logout');
  }

  Future<bool> settings({
    required bool loginEnabled,
    required bool logoutEnabled,
  }) async {
    return await _channel.invokeMethod('settings', {
      "loginEnabled": loginEnabled,
      "logoutEnabled": logoutEnabled
    });
  }

  Future<int> payment({
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
