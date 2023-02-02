import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_payclip/flutter_payclip.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion = 'Failed to get platform version.';
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    bool res = await FlutterPayClip.init();

    if(res){
      platformVersion = await FlutterPayClip.payment(
        amount: 133.28, 
        enableContactless: true, 
        enableTips: true, 
        roundTips: true, 
        enablePayWithPoints: false, 
        customTransactionId: "123123"
      );
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('RES: $_platformVersion\n'),
        ),
      ),
    );
  }
}
