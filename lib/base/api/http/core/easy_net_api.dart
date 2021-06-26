import 'package:app/base/api/net/http_status2.dart';
import 'package:app/base/common/logger.dart';

import '../request/base_request.dart';
import 'easy_dio_adapter.dart';
import 'easy_error.dart';
import 'easy_net_adapter.dart';

///1.支持网络库插拔设计，且不干扰业务层
///2.基于配置请求请求，简洁易用
///3.Adapter设计，扩展性强
///4.统一异常和返回处理
class EasyNetApi {
  EasyNetApi._();

  static EasyNetApi? _instance;

  static EasyNetApi getInstance() {
    if (_instance == null) {
      _instance = EasyNetApi._();
    }
    return _instance!;
  }

  Future fire(BaseRequest request) async {
    EasyNetResponse? response;
    var error;
    try {
      response = await send(request);
    } on BaseEasyNetError catch (e) {
      error = e;
      response = e.data;
      logger(e.message);
    } catch (e) {
      //其它异常
      error = e;
      logger(e);
    }
    if (response == null) {
      logger(error);
    }
    var result = response?.data;
    logger(result);
    var status = response?.code;
    switch (status) {
      case HttpStatus2.ok:
        return result;
      case HttpStatus2.login_error:
        throw NeedLogin();
      case HttpStatus2.auth_error:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw BaseEasyNetError(status, result.toString(), data: result);
    }
  }

  Future<EasyNetResponse<T>> send<T>(BaseRequest request) async {
    ///使用Dio发送请求，拓展性体现，可以插拔
    EasyNetAdapter adapter = EasyDioAdapter();
    return adapter.send(request);
  }
}
