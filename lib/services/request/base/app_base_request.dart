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
    var nativeHeaders = await AHChannel.getNativeHeaders();
    logger("getRequestHeaders start...");
    var methodEnumStr = EasyHttpMethod.values[getHttpMethod().index].toString();
    logger("getRequestHeaders methodEnumStr...<$methodEnumStr>");
    var header = await HeaderTools.getHeaders(getUrl(),
        method: methodEnumStr
            .substring(methodEnumStr.indexOf(".") + 1)
            .toLowerCase(),
        params: await getRequestParams());
    if (nativeHeaders.length > 0) {
      header.addAll(nativeHeaders);
    }
    return header;
  }

  @override
  Future<Map<String, dynamic>>? getRequestParams() {
    List<String>? keys = requestParams?.keys.toList();
    keys?.sort((a, b) {
      List<int> al = a.codeUnits;
      List<int> bl = b.codeUnits;
      for (int i = 0; i < al.length; i++) {
        if (bl.length <= i) return 1;
        if (al[i] > bl[i]) {
          return 1;
        } else if (al[i] < bl[i]) return -1;
      }
      return 0;
    });
    var treeMap = Map<String, dynamic>();
    keys?.forEach((element) {
      treeMap[element] = requestParams![element];
    });
    return Future.value(treeMap);
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
