
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class PackageByWalle {
  static const MethodChannel _channel = MethodChannel('package_by_walle');

  static Future<String?> get getPackingChannel async {
    final String? channel = await _channel.invokeMethod('getPackingChannel');
    return channel;
  }

  static Future<Map<dynamic, dynamic>?> get getPackingInfo async {
    if (Platform.isAndroid) {
      final Map<dynamic, dynamic>? info = await _channel.invokeMethod('getPackingInfo');
      return info;
    } else {
      return null;
    }
  }
}
