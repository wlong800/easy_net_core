import 'dart:async';

import 'package:app/base/api/http/core/easy_error.dart';
import 'package:app/base/api/http/core/easy_net_adapter.dart';
import 'package:app/base/api/http/core/easy_net_api.dart';
import 'package:app/base/api/http/request/easy_base_request.dart';
import 'package:app/base/api/models/base_response.dart';
import 'package:app/base/logger/logger.dart';
import 'package:app/services/api/api.dart';

class ApiImpl implements Api {
  @override
  Future<BaseResponse> fetchDataByNet(EasyBaseRequest request) async {
    EasyBaseResponse response;
    try {
      response = await EasyNetApi.getInstance().fire(request);
    } on BaseEasyNetError catch (e) {
      logger(e);
      return BaseResponse(code: e.code, msg: e.message);
    }
    var data = (response.data != null && response.data is Map)
        ? response.data["data"]
        : null;
    return BaseResponse(code: response.code, msg: response.msg, data: data);
  }

// @override
// Future<BaseResponse?> fetchDataByNative(String method,
//     {Map<String, dynamic>? params}) async {
//   final Completer<void> completer = Completer<void>();
//   var baseResponse;
//   await platform
//       .invokeMethod(method, params)
//       .then((value) {
//         logger('value >> is $value');
//         baseResponse = BaseResponse(code: HttpStatus2.ok, data: value);
//       })
//       .whenComplete(() => {completer.complete, logger("什么情况 complete")})
//       .catchError((dynamic error) {
//         logger("什么情况error $error");
//         baseResponse = BaseResponse(
//             code: HttpStatus2.status_90088, msg: error.toString());
//       });
//   return baseResponse;
// }
}
