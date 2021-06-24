import 'dart:async';

import 'net_request.dart';
import 'package:flutter/services.dart';

/// 业务层暴露
Future getRequest(String url, {Map<String, dynamic>? params}) async {
  var header = await getHeader(url, params: params);
  try {
    return await doRequest(url, params: params, headers: header, method: "get");
  } on PlatformException catch (e) {
    return e.details;
  }
}

/// 业务层暴露
Future postRequest(String url, {Map<String, dynamic>? params}) async {
  var header = await getHeader(url, params: params, method: "post");
  try {
    return await doRequest(url, params: params, headers: header);
  } on PlatformException catch (e) {
    return e.details;
  } catch (e) {
    // 非具体类型
    return e;
  }
}
