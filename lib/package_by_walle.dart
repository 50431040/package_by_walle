
import 'dart:async';

import 'package:flutter/services.dart';

class PackageByWalle {
  static const MethodChannel _channel = MethodChannel('package_by_walle');

  static Future<String?> get getPackingChannel async {
    final String? version = await _channel.invokeMethod('getPackingChannel');
    return version;
  }
}
