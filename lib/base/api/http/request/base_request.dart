import 'package:app/base/api/http/easy_net_global.dart';
import 'package:app/base/api/net/base_url.dart';
import 'package:app/base/common/logger.dart';

enum HttpMethod { GET, POST, DELETE }

///基础请求
/// 请求方式、authority、path、header、requestParams需要对外暴露
abstract class BaseRequest {
  String baseUrl() {
    return EasyNetGlobal.defaultBaseUrl;
  }

  //请求方式
  HttpMethod httpMethod();

  String getPath();

  ///完整的url，带参数 xx?xx=xx
  String url() {
    String url;
    url = getBaseUrl() + getPath();
    logger('url:$url');
    return url;
  }

  //是否需要登录
  bool needLogin() => true;

  ///请求参数
  Map<String, dynamic> requestParams = Map();

  ///添加参数
  BaseRequest addRequestParam(String k, dynamic v) {
    requestParams[k] = v;
    return this;
  }

  BaseRequest addRequestParams(Map<String, dynamic>? params) {
    requestParams.clear();
    if (params != null) {
      requestParams.addAll(params);
    }
    return this;
  }

  Map<String, dynamic> headers = Map();

  ///添加header
  BaseRequest addHeader(String k, dynamic v) {
    headers[k] = v;
    return this;
  }

  BaseRequest addHeaders(Map<String, dynamic> headersMap) {
    headers.clear();
    headers.addAll(headersMap);
    return this;
  }
}
