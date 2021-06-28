import 'package:app/base/api/http/request/easy_base_request.dart';

abstract class EasyDeleteRequest extends EasyBaseRequest {
  @override
  EasyHttpMethod getHttpMethod() {
    return EasyHttpMethod.DELETE;
  }
}
