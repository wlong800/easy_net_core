import 'package:app/base/api/net/HttpStatus2.dart';
import 'package:app/base/common/resource.dart';

class BaseResponse {
  int? code;
  String? msg;
  dynamic data;

  BaseResponse({this.code, this.msg, this.data});

  BaseResponse.fromJson(Map<String, dynamic>? jsonData) {
    if (jsonData == null) return;
    code = jsonData['code'];
    msg = code == HttpStatus2.ok
        ? (jsonData['message'] ?? String2.success)
        : (jsonData['message'] ?? String2.error);
    data = jsonData["data"];
  }
}
