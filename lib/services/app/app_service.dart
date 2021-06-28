import 'package:app/base/api/http/core/easy_net_adapter.dart';

abstract class AppService {
  Future<EasyBaseResponse?>? fetchContactsData({Map<String, dynamic>? requestParams});
  Future<EasyBaseResponse?>? updateContactsData({Map<String, dynamic>? requestParams});
  Future<EasyBaseResponse?>? deleteContactsData({Map<String, dynamic>? requestParams});
  Future<EasyBaseResponse?>? updateUserTTALData({Map<String, dynamic>? requestParams});
}
