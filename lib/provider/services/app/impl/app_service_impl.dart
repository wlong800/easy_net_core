import 'package:app/base/api/models/base_response.dart';
import 'package:app/provider/services/api/api.dart';

import '../../../../service_url.dart';
import '../../service_locator.dart';
import '../app_service.dart';

class AppServiceImpl implements AppService {
  Api _api = serviceLocator<Api>();

  @override
  Future<BaseResponse?> fetchContactsData({Map<String, dynamic>? params}) =>
      _api.fetchDataByGet(ServicePath.getContacts, params: params);

  @override
  Future<BaseResponse?>? updateContactsData({Map<String, dynamic>? params}) =>
      _api.fetchDataByPost(ServicePath.updateContacts, params: params);

  @override
  Future<BaseResponse?>? deleteContactsData({Map<String, dynamic>? params})  =>
      _api.fetchDataByPost(ServicePath.deleteContacts, params: params);
}
