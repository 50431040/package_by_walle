import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_by_walle/package_by_walle.dart';

void main() {
  const MethodChannel channel = MethodChannel('package_by_walle');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await PackageByWalle.platformVersion, '42');
  });
}
