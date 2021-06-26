import 'dart:async';

import 'package:app/base/api/http/core/easy_error.dart';
import 'package:app/base/api/http/core/easy_net_api.dart';
import 'package:app/base/api/http/request/easy_get_request.dart';
import 'package:app/base/api/models/base_response.dart';
import 'package:app/base/api/net/http_status2.dart';
import 'package:app/base/api/net/services/business_request.dart';
import 'package:app/base/common/channel_tools.dart';
import 'package:app/base/common/logger.dart';
import 'package:app/services/api/api.dart';

class ApiImpl implements Api {
  @override
  Future<BaseResponse?> fetchDataByGet(String url,
      {Map<String, dynamic>? params}) async {
    // var request = EasyGetRequest(url).addRequestParams(params);
    // try {
    //   try {
    //     var result = EasyNetApi.getInstance().fire(request);
    //     print(result);
    //   } on NeedAuth catch (e) {
    //     print(e);
    //   } on NeedLogin catch (e) {
    //     print(e);
    //   } on BaseEasyNetError catch (e) {
    //     print(e);
    //   }
    // } catch (e) {
    //   print(e);
    // }
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
