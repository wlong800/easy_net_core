import 'package:app/base/api/http/easy_net_global.dart';
import 'package:app/base/common/lang.dart';

String? baseUrl;

String getBaseUrl() {
  if (isEmpty(baseUrl)) return EasyNetGlobal.defaultBaseUrl;
  if (isNotEmpty(baseUrl)) {
    if (baseUrl?.endsWith("/") == false) baseUrl = toString2(baseUrl) + "/";
    return toString2(baseUrl);
  }
  return toString2(baseUrl);
}
