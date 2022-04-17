package net.niuxiaoer.package_by_walle;

import android.content.Context;

import androidx.annotation.NonNull;

import com.meituan.android.walle.ChannelInfo;
import com.meituan.android.walle.WalleChannelReader;

import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;


/** PackageByWallePlugin */
public class PackageByWallePlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context applicationContext;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    this.applicationContext = flutterPluginBinding.getApplicationContext();
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "package_by_walle");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPackingChannel")) {
      try {
        String channel = WalleChannelReader.getChannel(this.applicationContext);
        result.success(channel);
      } catch(Exception e) {
        result.success("unknown");
      }
    } else if (call.method.equals("getPackingInfo")) {
      ChannelInfo channelInfo= WalleChannelReader.getChannelInfo(this.applicationContext);
      if (channelInfo != null) {
        Map<String, String> extraInfo = channelInfo.getExtraInfo();
        result.success(extraInfo);
      } else {
        result.success(null);
      }
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
