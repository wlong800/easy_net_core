import 'package:app/base/api/net/base_url.dart';
import 'package:app/base/common/logger.dart';
import 'package:all_future_plugin/all_future_plugin.dart';

class HeaderTools {
  static Future<Map<dynamic, dynamic>?> getHeaders(String url,
      {String? method = "get",
      String? contentType = "json",
      Map<String, dynamic>? params}) async {
    try {
      var platformHeaders = await AllFuturePlugin.platformHeaders({
        "url": url,
        "method": method,
        "contentType": contentType,
        "requestBody": params
      });
      if (platformHeaders.containsKey("base_url")) {
        baseUrl = platformHeaders["base_url"] + "/";
        platformHeaders.remove("base_url");
      }
      logger("platformHeaders : $platformHeaders");
      return platformHeaders;
    } catch (e) {
      logger(e.toString());
    }
    return null;
  }
}
