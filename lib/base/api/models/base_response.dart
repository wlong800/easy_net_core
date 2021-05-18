
import 'package:app/base/api/net/HttpStatus2.dart';
import 'package:app/base/common/resource.dart';


class BaseResponse {
  int? code;
  String? msg;
  dynamic data;

  BaseResponse({this.code, this.msg, this.data});

  BaseResponse.fromJson(Map<String, dynamic>? jsonData) {
    code = jsonData!['ret'];
    msg = code == HttpStatus2.ok
        ? (jsonData['msg'] ?? String2.success)
        : (jsonData['msg'] ?? String2.error);
    var d = jsonData["result"];
    data = d;
  }
}
