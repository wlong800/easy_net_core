import 'dart:ui';

import 'package:app/base/api/models/base_response.dart';
import 'package:app/base/api/net/services/business_request.dart';
import 'package:app/base/common/common_callback.dart';
import 'package:app/base/common/lang.dart';

import 'HttpStatus2.dart';


class Api {
  static Future<Null> get(String? url,
      {Map<String, String>? params,
      Callback? success,
      Callback3? error,
      VoidCallback? complete}) async {
    var response = await getRequest(url, params: params);
    if (complete != null) complete();
    BaseResponse baseResponse = response;
    if (toInt(baseResponse.code) == HttpStatus2.ok) {
      if (success != null) success(baseResponse.data);
    } else {
      if (error != null)
        error(baseResponse.code, baseResponse.msg, baseResponse.data);
    }
    return null;
  }

  static Future<Null> post(String? url,
      {Map<String, dynamic>? params,
      Callback? success,
      Callback3? error,
      VoidCallback? complete}) async {
    var response = await postRequest(url, params: params);
    if (complete != null) complete();
    BaseResponse baseResponse = response;
    if (baseResponse.code == HttpStatus2.ok) {
      if (success != null) success(baseResponse.data);
    } else {
      if (error != null)
        error(baseResponse.code, baseResponse.msg, baseResponse.data);
    }
    return null;
  }

}
