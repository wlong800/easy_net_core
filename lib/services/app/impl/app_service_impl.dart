import 'package:app/base/api/http/core/easy_net_adapter.dart';
import 'package:app/service_url.dart';
import 'package:app/services/api/api.dart';
import 'package:app/services/request/base/app_get_request.dart';
import 'package:app/services/request/base/app_post_request.dart';

import '../../service_locator.dart';
import '../app_service.dart';

class AppServiceImpl implements AppService {
  Api _api = serviceLocator<Api>();

  @override
  Future<EasyBaseResponse?>? updateUserTTALData(
      {Map<String, dynamic>? requestParams}) {
    return _api.fetchDataByNet(
        AppPostRequest(AppServicePath.getContacts, requestParams));
  }

  @override
  Future<EasyBaseResponse?>? fetchContactsData(
      {Map<String, dynamic>? requestParams}) {
    return _api.fetchDataByNet(
        AppGetRequest(AppServicePath.getContacts, requestParams));
  }

  @override
  Future<EasyBaseResponse?>? deleteContactsData(
      {Map<String, dynamic>? requestParams}) {
    return _api.fetchDataByNet(AppGetRequest(
        AppServicePath.deleteContacts + "/${requestParams!["cid"]}",
        requestParams));
  }

  @override
  Future<EasyBaseResponse?>? updateContactsData(
      {Map<String, dynamic>? requestParams}) {
    return _api.fetchDataByNet(
        AppPostRequest(AppServicePath.updateContacts, requestParams));
  }
}
