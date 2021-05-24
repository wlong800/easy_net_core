import 'dart:async';

import 'package:app/base/api/models/base_response.dart';
import 'package:app/base/api/net/HttpStatus2.dart';
import 'package:app/base/api/net/services/business_request.dart';
import 'package:app/base/common/channel_tools.dart';
import 'package:app/base/common/logger.dart';
import 'package:app/provider/services/api/api.dart';

class ApiImpl implements Api {
  @override
  Future<BaseResponse?> fetchDataByGet(String url,
      {Map<String, dynamic>? params}) async {
    return await getRequest(url, params: params);
  }

  @override
  Future<BaseResponse?> fetchDataByPost(String url,
      {Map<String, dynamic>? params}) async {
    return await postRequest(url, params: params);
  }

  @override
  Future<BaseResponse?> fetchDataByNative(String method,
      {Map<String, dynamic>? params}) async {
    final Completer<void> completer = Completer<void>();
    var baseResponse;
    await platform
        .invokeMethod(method, params)
        .then((value) {
          logger('value >> is $value');
          baseResponse = BaseResponse(code: HttpStatus2.ok, data: value);
        })
        .whenComplete(() => {completer.complete, logger("什么情况 complete")})
        .catchError((dynamic error) {
          logger("什么情况error $error");
          baseResponse = BaseResponse(
              code: HttpStatus2.status_90088, msg: error.toString());
        });
    return baseResponse;
  }
}
