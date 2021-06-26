import 'package:app/base/api/net/http_status2.dart';

///需要登录的异常
class NeedLogin extends BaseEasyNetError {
  NeedLogin({int code: HttpStatus2.login_error, String message: '请先登录'})
      : super(code, message);
}

///需要授权的异常
class NeedAuth extends BaseEasyNetError {
  NeedAuth(String message, {int code: HttpStatus2.auth_error, dynamic data})
      : super(code, message, data: data);
}

///网络异常统一格式类
class BaseEasyNetError implements Exception {
  final int? code;
  final String? message;
  final dynamic data;

  BaseEasyNetError(this.code, this.message, {this.data});
}
