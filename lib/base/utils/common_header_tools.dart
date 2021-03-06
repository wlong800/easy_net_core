import 'package:app/base/common/lang.dart';
import 'package:app/base/logger/logger.dart';
import 'package:all_future_plugin/all_future_plugin.dart';
import 'package:app/tools/channel_tools.dart';
class HeaderTools {
  static Future<Map<String, dynamic>> getHeaders(String url,
      {String? method = "get",
      String? contentType = "json",
      Map<String, dynamic>? params}) async {
    try {
      var platformHeaders;
      if (isIOS()) {
        platformHeaders = await platform.invokeMethod("getPlatformHeaders", {
          "url": url,
          "method": method,
          "contentType": contentType,
          "requestBody": params
        });
      } else {
        platformHeaders = await AllFuturePlugin.platformHeaders({
          "url": url,
          "method": method,
          "contentType": contentType,
          "requestBody": params
        });
      }
      platformHeaders = Map<String, dynamic>.from(platformHeaders);
      logger("platformHeaders : $platformHeaders");
      return platformHeaders;
    } catch (e) {
      logger(e);
    }
    return {};
  }
}
