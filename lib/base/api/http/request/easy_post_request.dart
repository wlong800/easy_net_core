import 'package:app/base/api/http/request/easy_base_request.dart';

abstract class EasyPostRequest extends EasyBaseRequest {
  @override
  EasyHttpMethod getHttpMethod() {
    return EasyHttpMethod.POST;
  }
}
