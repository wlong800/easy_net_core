import 'package:app/base/api/http/request/easy_base_request.dart';
import 'package:app/base/config/config_manager.dart';
import 'package:app/tools/channel_tools.dart';
import 'package:app/base/utils/common_header_tools.dart';

abstract class AppBaseRequest extends EasyBaseRequest {
  final String path;
  final Map<String, dynamic>? requestParams;

  AppBaseRequest(this.path, this.requestParams);

  @override
  Future<Map<String, dynamic>> getRequestHeaders() async {
    var nativeHeaders = await Channel.getNativeHeaders();
    var methodEnumStr = EasyHttpMethod.values[getHttpMethod().index].toString();
    var header = await HeaderTools.getHeaders(getUrl(),
        method: methodEnumStr.substring(methodEnumStr.indexOf(".") + 1).toLowerCase(),
        params: await getRequestParams());
    if (nativeHeaders.length > 0) {
      header.addAll(nativeHeaders);
    }
    return header;
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
