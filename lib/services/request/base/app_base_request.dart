import 'package:app/base/api/http/request/easy_base_request.dart';
import 'package:app/base/config/config_manager.dart';
import 'package:app/base/logger/logger.dart';
import 'package:app/tools/channel_tools.dart';
import 'package:app/base/utils/common_header_tools.dart';

abstract class AppBaseRequest extends EasyBaseRequest {
  final String path;
  final Map<String, dynamic>? requestParams;

  AppBaseRequest(this.path, this.requestParams);

  @override
  Future<Map<String, dynamic>> getRequestHeaders() async {
    return {
      "Cookie":
          "sid=4724338c913dd604f96431bc176f6219; bearer=eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiLog5bkuY7kuY4iLCJjcmVhdGVkIjoxNjI1NTY4OTE4NTA2LCJleHAiOjE2MjgxNjA5MTgsInVzZXJpZCI6NTc5MDI0fQ.O260gcb7oqXaIGDERbT-ATjVnqAERg0UDSPfl0yRmb5sgK1qBFU4E7Ce4hAsXG4WOef1Tlx-g97-4BzvVdhtSg"
    };
    // var nativeHeaders = await Channel.getNativeHeaders();
    // logger("getRequestHeaders start...<nativeHeaders>");
    // var methodEnumStr = EasyHttpMethod.values[getHttpMethod().index].toString();
    // logger("getRequestHeaders methodEnumStr...<$methodEnumStr>");
    // var header = await HeaderTools.getHeaders(getUrl(),
    //     method: methodEnumStr.substring(methodEnumStr.indexOf(".") + 1).toLowerCase(),
    //     params: await getRequestParams());
    // if (nativeHeaders.length > 0) {
    //   header.addAll(nativeHeaders);
    // }
    // return header;
  }

  @override
  Future<Map<String, dynamic>>? getRequestParams() {
    return Future.value(requestParams);
  }

  @override
  String getPath() {
    return path;
  }

  @override
  String? getProxy() {
    return ConfigManager.getInstance().getProxy();
  }
}
