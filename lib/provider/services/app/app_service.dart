import 'package:app/base/api/models/base_response.dart';

abstract class AppService {
  Future<BaseResponse?>? fetchContactsData({Map<String, dynamic>? params});
  Future<BaseResponse?>? updateContactsData({Map<String, dynamic>? params});
  Future<BaseResponse?>? deleteContactsData({Map<String, dynamic>? params});
  Future<BaseResponse?>? updateUserTTALData({Map<String, dynamic>? params});
}
