import 'package:app/base/api/models/base_response.dart';
import 'package:app/base/api/net/http_status2.dart';
import 'package:app/base/api/net/services/net_state_enum.dart';
import 'package:app/base/common/common_callback.dart';
import 'package:app/base/common/lang.dart';
import 'package:app/base/logger/logger.dart';
import 'package:app/base/model/base_feed_model.dart';
import 'package:app/services/app/app_service.dart';
import 'package:app/services/service_locator.dart';
import 'package:flutter/foundation.dart';

import '../global.dart';

typedef S ItemCreator<S>();

abstract class BaseProviderModel<T> extends ChangeNotifier {
  AppService appService = serviceLocator<AppService>();

  NetState _connectionState = NetState.waiting;

  String? _lastId;

  NetState get connectionState => _connectionState;

  ItemCreator<T>? creator;

  BaseProviderModel({this.creator});

  T? _data;

  T get data {
    if (_data == null) {
      _data = creator!();
    }
    return _data!;
  }

  // @Deprecated("instead with creator()")
  set setData(T data) {
    _data = data;
    notifyDataSetChanged();
  }

  bool _loadError = false;

  bool get loadError => _loadError;

  set setLoadError(bool loadError) {
    _loadError = loadError;
  }

  set setConnectionState(NetState connectionState) {
    _connectionState = connectionState;
  }

  String? get lastId => _lastId;

  set setLastId(String? lastId) {
    _lastId = lastId;
  }

  void onError(int? code, String? msg) {
    _connectionState = NetState.error;
    notifyListeners();
  }

  void onEmpty() {
    _connectionState = NetState.empty;
    notifyListeners();
  }

  void onLoading() {
    _connectionState = NetState.waiting;
    notifyListeners();
  }

  void notifyDataSetChanged() {
    fetchLastId();
    _connectionState = NetState.done;
    notifyListeners();
  }

  void notifyDataSetChanged2() {
    _connectionState = NetState.done;
    notifyListeners();
  }

  void fetchLastId() {}

  bool onResponseSuccess(BaseResponse? response) {
    bool responseSuccess = false;
    setLoadError = false;
    switch (response?.code) {
      case HttpStatus2.ok:
        if (isEmpty(response?.data)) {
          /// 没有返回数据的情况
          if (isNotEmpty(lastId)) {
            /// 翻页的动作
            setLastId = null;
          } else {
            /// 刷新动作
            if (connectionState == NetState.waiting) {
              onEmpty();
            }
          }
        } else {
          /// 有数据返回
          responseSuccess = true;
          // if (response?.data is List && isEmpty(lastId)) (data as List).clear();
        }
        return responseSuccess;
      default:

        ///网络错误了
        if (isNotEmpty(lastId)) {
          setLoadError = true;
        } else {
          if (connectionState == NetState.waiting) {
            onError(response?.code, response?.msg);
          } else {
            //todo: 翻页的时候网络错误
            // showNativeToast(msg: response?.msg);
          }
        }
        return responseSuccess;
    }
  }

  bool onDataResponseSuccess(BaseDataResponse? response) {
    bool responseSuccess = false;
    if (isEmpty(response?.content)) {
      setLastId = null;

      ///没有数据了
      if (isEmpty(lastId)) {
        /// 下拉刷新
        onEmpty();
      } else {
        //todo:翻页
      }
      return responseSuccess;
    }
    responseSuccess = true;
    if (data is List && toInt(lastId) <= 1) (data as List).clear();
    if (response?.page == response?.totalPages) {
      ///最后一页了
      setLastId = null;
    } else {
      setLastId = toString2(toInt(response?.page) + 1);
    }
    return responseSuccess;
  }

  Future<Null> loadData(
      {String? lastId, Map<String, dynamic>? params, Callback? responseBack});

  Map<String, dynamic> handleRequestParams(
      String? lastId, Map<String, dynamic>? params) {
    if (params == null) params = {};
    if (isNotEmpty(lastId)) params["page"] = toInt(lastId);
    params["size"] = Global.limit;
    return params;
  }

  @override
  void dispose() {
    super.dispose();
    logger("base provider model dispose..");
  }
}
