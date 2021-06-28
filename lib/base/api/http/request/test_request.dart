import 'easy_base_request.dart';

class TestRequest extends EasyBaseRequest {
  @override
  EasyHttpMethod getHttpMethod() {
    // TODO: implement getHttpMethod
    throw UnimplementedError();
  }

  @override
  String getPath() {
    // TODO: implement getPath
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getRequestHeaders() {
    // TODO: implement getRequestHeaders
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>>? getRequestParams() {
    // TODO: implement getRequestParams
    throw UnimplementedError();
  }

}
