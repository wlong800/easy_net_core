import 'dart:convert';

import 'package:app/base/api/http/request/easy_base_request.dart';

///网络请求适配器抽象类,添加适配器的目的是方便扩展，会有多个适配器....
abstract class EasyNetAdapter {
  Future<EasyBaseResponse> send(EasyBaseRequest request);

  ///丰富options
}

/// 统一网络层返回格式
class EasyBaseResponse {
  EasyBaseResponse({
    this.data,
    this.request,
    this.code,
    this.msg,
    this.extra,
  });

  /// Response body. may have been transformed, please refer to [ResponseType].
  dynamic data;

  /// The corresponding request info.
  EasyBaseRequest? request;

  /// Http status code.
  int? code;

  /// Returns the reason phrase associated with the status code.
  /// The reason phrase must be set before the body is written
  /// to. Setting the reason phrase after writing to the body.
  String? msg;

  /// Custom field that you can retrieve it later in `then`.
  dynamic extra;

  /// We are more concerned about `data` field.
  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
