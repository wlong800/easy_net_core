import 'package:app/base/api/http/easy_net_global.dart';
import 'package:app/base/common/logger.dart';

enum EasyHttpMethod { GET, POST, DELETE }

///基础请求
/// 请求方式、authority、path、header、requestParams需要对外暴露
abstract class EasyBaseRequest {
  String getBaseUrl() {
    return EasyNetGlobal.defaultBaseUrl;
  }

  //请求方式
  EasyHttpMethod getHttpMethod();

  String getPath();

  Future<Map<String, dynamic>> getRequestHeaders();

  Future<Map<String, dynamic>>? getRequestParams();

  ///完整的url
  String getUrl() {
    String url;
    url = getBaseUrl() + getPath();
    logger('url:$url');
    return url;
  }

  //是否启用代理
  String? getProxy() => null;

  //是否需要登录
  // bool needLogin() => true;
//
// ///请求参数
// Map<String, dynamic> requestParams = Map();
//
// ///添加参数
// EasyBaseRequest addRequestParam(String k, dynamic v) {
//   requestParams[k] = v;
//   return this;
// }
//
// EasyBaseRequest addRequestParams(Map<String, dynamic>? params) {
//   requestParams.clear();
//   if (params != null) {
//     requestParams.addAll(params);
//   }
//   return this;
// }
//
// Map<String, dynamic> headers = Map();
//
// ///添加header
// EasyBaseRequest addHeader(String k, dynamic v) {
//   headers[k] = v;
//   return this;
// }
//
// EasyBaseRequest addHeaders(Map<String, dynamic> headersMap) {
//   headers.clear();
//   headers.addAll(headersMap);
//   return this;
// }
}
