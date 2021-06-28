import 'package:app/base/api/http/request/easy_base_request.dart';
import 'package:app/services/request/base/app_base_request.dart';

class AppGetRequest extends AppBaseRequest {
  AppGetRequest(String path, Map<String, dynamic>? requestParams)
      : super(path, requestParams);

  @override
  EasyHttpMethod getHttpMethod() {
    return EasyHttpMethod.GET;
  }
}
