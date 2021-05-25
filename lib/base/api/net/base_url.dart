import 'package:app/base/common/global.dart';
import 'package:app/base/common/lang.dart';
import 'package:app/base/common/logger.dart';

const serviceUrl = 'https://api.lumiclass.com/';

const serviceUrlBate = 'https://api.lumiclass.com/';

const serviceUrlTest = 'https://dev-api.lumiclass.com/';

String? baseUrl;

String getServiceUrl() {
  // if (isNotEmpty(baseUrl)) {
  //   if (!baseUrl!.endsWith("/")) baseUrl = baseUrl! + "/";
  //   return baseUrl;
  // }
  // logger("base url   ${Global.type}");
  // switch (Global.type) {
  //   case 0:
  //     return serviceUrl;
  //   case 1:
  //     return serviceUrlTest;
  //   case 2:
  //     return serviceUrlBate;
  //   default:
  //     return serviceUrl;
  // }
  return "http://10.4.40.54/";
}
