import 'package:app/base/api/models/base_response.dart';
import 'package:app/service_url.dart';
import 'package:app/services/api/api.dart';
import 'package:app/services/request/base/app_get_request.dart';
import 'package:app/services/request/base/app_post_request.dart';

import '../../service_locator.dart';
import '../app_service.dart';

class AppServiceImpl implements AppService {
  Api _api = serviceLocator<Api>();

  @override
  Future<BaseResponse>? updateUserTTALData(
      {Map<String, dynamic>? requestParams}) {
    return _api.fetchDataByNet(
        AppPostRequest(AppServicePath.updateUserTTAL, requestParams));
  }

  @override
  Future<BaseResponse>? fetchContactsData(
      {Map<String, dynamic>? requestParams}) {
    return _api.fetchDataByNet(
        AppGetRequest(AppServicePath.getContacts, requestParams));
  }

  @override
  Future<BaseResponse>? deleteContactsData(
      {Map<String, dynamic>? requestParams}) {
    return _api.fetchDataByNet(AppPostRequest(
        AppServicePath.deleteContacts + "/${requestParams!["cid"]}",
        requestParams));
  }

  @override
  Future<BaseResponse>? updateContactsData(
      {Map<String, dynamic>? requestParams}) {
    return _api.fetchDataByNet(
        AppPostRequest(AppServicePath.updateContacts, requestParams));
  }

  @override
  Future<BaseResponse>? fetchUserInfoData({Map<String, dynamic>? requestParams}) {
    return _api.fetchDataByNet(
        AppGetRequest(AppServicePath.getUserInfo, requestParams));
  }
}
