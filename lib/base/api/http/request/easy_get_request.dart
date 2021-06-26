import 'package:app/base/api/http/request/base_request.dart';

class EasyGetRequest extends BaseRequest {
  final String path;

  EasyGetRequest(this.path);
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  String getPath() {
    return path;
  }


}