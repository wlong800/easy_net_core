import 'package:app/base/api/http/request/easy_base_request.dart';

abstract class EasyGetRequest extends EasyBaseRequest {
  @override
  EasyHttpMethod getHttpMethod() {
    return EasyHttpMethod.GET;
  }
}
