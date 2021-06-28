import 'package:app/base/api/http/request/easy_base_request.dart';
import 'package:app/base/api/models/base_response.dart';

abstract class Api {

  Future<BaseResponse?> fetchDataByNet(EasyBaseRequest request);

  // Future<BaseResponse?> fetchDataByNative(String method,
  //     {Map<String, dynamic>? params});
}
