///网络请求基础封装
import 'dart:convert';
import 'dart:io';

import 'package:app/base/api/models/base_response.dart';
import 'package:app/base/common/channel_tools.dart';
import 'package:app/base/common/lang.dart';
import 'package:app/base/common/logger.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/hold/hold.dart';
import 'package:app/base/utils/common_header_tools.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../HttpStatus2.dart';

final Dio _dio = Dio(BaseOptions(
  connectTimeout: 30000, //单位毫秒  超时时间 30秒
  receiveTimeout: 30000, //单位毫秒  超时时间 30秒
));

Dio _defaultDio(Map<dynamic, dynamic>? headers) {
  _dio.options.contentType = Headers.jsonContentType;
  if (isNotEmpty(headers)) {
    _dio.options.headers = Map<String, dynamic>.from(headers!);
    logger("header : ${_dio.options.headers.toString()}");
  }
  _addProxy(_dio);
  return _dio;
}

Future doRequest(url,
    {Map<dynamic, dynamic>? headers,
    Map<String, dynamic>? params,
    String method = "post"}) async {
  try {
    logger("url : $url");
    Dio dio = _defaultDio(headers);
    if (params != null) {
      logger("params : ${params.toString()}");
    }
    Response response;
    if (params == null) {
      response = method == "get" ? await dio.get(url) : await dio.post(url);
    } else {
      response = method == "get"
          ? await dio.get(url, queryParameters: params)
          : await dio.post(url, data: params);
    }
    return _handleResponse(response);
  } catch (e) {
    return _handleResponseError(e);
  }
}

BaseResponse _handleResponse(Response response) {
  if (response.statusCode == HttpStatus.ok) {
    if (isEmpty(response.data)) {
      return BaseResponse(code: HttpStatus2.ok);
    }
    var result = BaseResponse.fromJson(response.data);
    return result;
  } else if (response.statusCode == HttpStatus.unauthorized) {
    return BaseResponse(
        code: response.statusCode, msg: "Login timeout, please log in again");
  } else {
    logger("net error, statusCode ${response.statusCode}");
    return BaseResponse(code: response.statusCode, msg: "net error");
  }
}

BaseResponse _handleResponseError(e) {
  if (e is DioError) {
    _formatError(e);
    logger("error2 ${json.encode(e.response?.data)}");
    _formatError(e);
    if (e.response?.statusCode == HttpStatus.unauthorized) {
      return BaseResponse(
          code: e.response?.statusCode,
          msg: "Login timeout, please log in again");
    }
    return BaseResponse(
        code: HttpStatus2.error_code,
        msg: isNotEmpty(e.response?.data)
            ? json.encode(e.response?.data)
            : String2.error);
  }
  return BaseResponse(code: HttpStatus2.error_code, msg: e.toString());
}

/// 获取header数据
Future getHeader(String url,
    {String? method, String? contentType, Map<String, dynamic>? params}) async {
  Map<dynamic, dynamic>? header;
  try {
    header = await HeaderTools.getHeaders(url,
        method: method, contentType: contentType, params: params);
    var nativeHeaders  = await Channel.getNativeHeaders();
    header?.addAll(nativeHeaders);
  } on Exception catch (e) {
    logger(e.toString());
    return null;
  }
  return header;
}

void _addProxy(Dio dio) {
  String proxy = /*Hold.getString("proxy_setting")*/"10.6.12.169:8888";
  logger("proxy setting >>> $proxy");
  if (isEmpty(proxy)) return;
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    client.findProxy = (uri) {
      return "PROXY $proxy";
    };
  };
}

/*
   * error统一处理
   */
void _formatError(DioError e) {
  if (e.type == DioErrorType.connectTimeout) {
    // It occurs when url is opened timeout.
    logger("连接超时");
  } else if (e.type == DioErrorType.sendTimeout) {
    // It occurs when url is sent timeout.
    logger("请求超时");
  } else if (e.type == DioErrorType.receiveTimeout) {
    //It occurs when receiving timeout
    logger("响应超时");
  } else if (e.type == DioErrorType.response) {
    // When the server response, but with a incorrect status, such as 404, 503...
    logger("出现异常");
  } else if (e.type == DioErrorType.cancel) {
    // When the request is cancelled, dio will throw a error with this type.
    logger("请求取消");
  } else {
    //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
    logger("未知错误");
    logger(e.message);
  }
}
