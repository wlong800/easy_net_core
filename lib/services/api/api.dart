import 'package:app/base/api/http/core/easy_net_adapter.dart';
import 'package:app/base/api/http/request/easy_base_request.dart';

abstract class Api {

  Future<EasyBaseResponse?> fetchDataByNet(EasyBaseRequest request);

  // Future<BaseResponse?> fetchDataByNative(String method,
  //     {Map<String, dynamic>? params});
}
