import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io';

class DeviceUtils {
  DeviceUtils._();

  static Future<Map<String, dynamic>> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return {
        'platform': 'Android',
        'model': info.model,
        'brand': info.brand,
        'version': info.version.release,
        'sdkInt': info.version.sdkInt,
        'id': info.id,
      };
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return {
        'platform': 'iOS',
        'model': info.model,
        'name': info.name,
        'version': info.systemVersion,
        'id': info.identifierForVendor,
      };
    }
    return {};
  }

  static Future<Map<String, String>> getAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    return {
      'appName': info.appName,
      'packageName': info.packageName,
      'version': info.version,
      'buildNumber': info.buildNumber,
    };
  }

  static bool get isAndroid => Platform.isAndroid;
  static bool get isIOS => Platform.isIOS;
}
