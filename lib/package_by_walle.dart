import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

/// class
class PackageByWalle {
  /// methodChannel
  static const MethodChannel _channel = MethodChannel('package_by_walle');

  /// 获取渠道号，iOS端默认为AppStore
  static Future<String?> get getPackingChannel async {
    final String? channel = await _channel.invokeMethod('getPackingChannel');
    return channel;
  }

  /// 获取打包相关配置
  static Future<Map<dynamic, dynamic>?> get getPackingInfo async {
    if (Platform.isAndroid) {
      final Map<dynamic, dynamic>? info =
          await _channel.invokeMethod('getPackingInfo');
      return info;
    } else {
      return null;
    }
  }
}
