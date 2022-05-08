import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:package_by_walle/package_by_walle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _channel = 'Unknown';
  Map<dynamic, dynamic>? _info;

  @override
  void initState() {
    super.initState();
    initChannel();
  }

  /// 初始化
  Future<void> initChannel() async {
    String channel;
    Map<dynamic, dynamic>? info;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      // 获取渠道号
      channel =
          await PackageByWalle.getPackingChannel ?? 'test';
      // 获取打包配置（configFile文件中配置）
      info = await PackageByWalle.getPackingInfo;
    } on PlatformException {
      channel = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _channel = channel;
      _info = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Text('channel is: $_channel'),
            Text('info is: ${_info ?? ""}')
          ],
        ),
      ),
    );
  }
}
