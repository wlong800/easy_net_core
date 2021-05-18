
import 'package:app/base/common/lang.dart';
import 'package:app/base/common/logger.dart';
import 'package:flutter/services.dart';

var _nativeHeaders = <String, dynamic>{};

class HeaderTools {
  static Future getHeader(Map<String, dynamic>? params) async {
    Map<String, dynamic> headerData;
    try {
      headerData = await _readBuildHeaders(params);
    } on PlatformException {
      headerData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    return headerData;
  }

  static Future<Map<String, dynamic>> _readBuildHeaders(
      Map<String, dynamic>? params) async {
    Map<String, dynamic> nativeHeaders = await getNativeHeaders();
    logger("nativeHeaders :  $nativeHeaders");
    return nativeHeaders;
  }

  static void buildNativeHeader() async {
    try {
      var map = await platform.invokeMethod("getNativeRequestHeader");
      map.forEach((key, value) {
        _nativeHeaders[key] = value;
      });
    } on Exception catch (e) {
      print(e);
    } catch (e) {
      logger(e.toString());
    }
  }

  static Future<Map<String, dynamic>> getNativeHeaders() async {
    var nativeHeaders = <String, dynamic>{};
    try {
      var map = await platform.invokeMethod("getNativeRequestHeader");
      map.forEach((key, value) {
        nativeHeaders[key] = value;
      });
    } on Exception catch (e) {
      print(e);
    } catch (e) {
      logger(e.toString());
    }
    return nativeHeaders;
  }

}
