import 'package:app/base/api/models/base_response.dart';

/// 目前支持get post,后期需要扩展
abstract class Api {
  Future<BaseResponse?> fetchDataByGet(String url,
      {Map<String, dynamic>? params});

  Future<BaseResponse?> fetchDataByPost(String url,
      {Map<String, dynamic>? params});

  Future<BaseResponse?> fetchDataByNative(String method,
      {Map<String, dynamic>? params});
}
