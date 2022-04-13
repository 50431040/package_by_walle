#import "PackageByWallePlugin.h"

@implementation PackageByWallePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"package_by_walle"
            binaryMessenger:[registrar messenger]];
  PackageByWallePlugin* instance = [[PackageByWallePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPackingChannel" isEqualToString:call.method]) {
    result(@"AppStore");
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
