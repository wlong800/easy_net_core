import 'package:app/base/api/http/request/base_request.dart';
import 'package:app/base/common/lang.dart';
import 'package:app/base/common/logger.dart';
import 'package:dio/dio.dart';

import 'easy_error.dart';
import 'easy_net_adapter.dart';

///Dio适配器
class EasyDioAdapter extends EasyNetAdapter {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: 30000, //单位毫秒  超时时间 30秒
    receiveTimeout: 30000, //单位毫秒  超时时间 30秒
  ));

  @override
  Future<EasyNetResponse<T>> send<T>(BaseRequest request) async {
    rich(request);
    var response;
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await _dio.get(request.getPath(),
            queryParameters: request.requestParams);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await _dio.post(request.getPath(), data: request.requestParams);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response =
            await _dio.delete(request.url(), data: request.requestParams);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      ///抛出HiNetError
      throw BaseEasyNetError(response?.code ?? -1, error.toString(),
          data: buildRes(response, request));
    }
    return buildRes(response, request);
  }

  ///构建HiNetResponse
  Future<EasyNetResponse<T>> buildRes<T>(
      Response response, BaseRequest request) {
    return Future.value(EasyNetResponse(
        data: response.data,
        request: request,
        code: response.statusCode,
        msg: response.statusMessage,
        extra: response));
  }

  @override
  rich(BaseRequest request) {
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.baseUrl = request.baseUrl();
    if (isNotEmpty(request.headers)) {
      _dio.options.headers = Map<String, dynamic>.from(request.headers);
      logger("header : ${_dio.options.headers.toString()}");
    }
  }
}
