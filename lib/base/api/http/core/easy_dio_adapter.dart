import 'dart:io';

import 'package:app/base/api/http/request/easy_base_request.dart';
import 'package:app/base/common/lang.dart';
import 'package:app/base/common/logger.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'easy_net_adapter.dart';

///Dio适配器
class EasyDioAdapter extends EasyNetAdapter {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: 30000, //单位毫秒  超时时间 30秒
    receiveTimeout: 30000, //单位毫秒  超时时间 30秒
  ));

  @override
  Future<EasyBaseResponse> send(EasyBaseRequest request) async {
    await _richRequest(request);
    var response;
    var error;
    try {
      switch (request.getHttpMethod()) {
        case EasyHttpMethod.GET:
          response = await _dio.get(request.getPath(),
              queryParameters: await request.getRequestParams());
          break;
        case EasyHttpMethod.POST:
          response = await _dio.post(request.getPath());
          break;
        case EasyHttpMethod.DELETE:
          response = await _dio.delete(request.getUrl(),
              data: await request.getRequestParams());
          break;
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    // if (error != null) {
    //
    //   ///抛出HiNetError
    //   throw BaseEasyNetError(response?.statusCode ?? -1, error.toString(),
    //       data: buildRes(response, request));
    // }
    return buildRes(response, request);
  }

  ///构建HiNetResponse
  Future<EasyBaseResponse> buildRes(
      Response response, EasyBaseRequest request) {
    return Future.value(EasyBaseResponse(
        data: response.data,
        request: request,
        code: response.statusCode ?? -1,
        msg: response.statusMessage,
        extra: response));
  }

  _richRequest(EasyBaseRequest request) async {
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.baseUrl = request.getBaseUrl();
    var headers = await request.getRequestHeaders();
    if (isNotEmpty(headers)) {
      _dio.options.headers =
          Map<String, dynamic>.from(headers);
      logger("header : ${_dio.options.headers.toString()}");
    }
    _findProxy(request);
  }

  void _findProxy(EasyBaseRequest request) {
    String? proxy = request.getProxy();
    logger("proxy setting >>> $proxy");
    if (isEmpty(proxy)) return;
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      client.findProxy = (uri) {
        return "PROXY $proxy";
      };
    };
  }
}
