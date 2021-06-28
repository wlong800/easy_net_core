import 'package:app/base/api/models/base_response.dart';

abstract class AppService {
  Future<BaseResponse>? fetchContactsData({Map<String, dynamic>? requestParams});
  Future<BaseResponse>? updateContactsData({Map<String, dynamic>? requestParams});
  Future<BaseResponse>? deleteContactsData({Map<String, dynamic>? requestParams});
  Future<BaseResponse>? updateUserTTALData({Map<String, dynamic>? requestParams});
  ///获取用户信息
  Future<BaseResponse>? fetchUserInfoData({Map<String, dynamic>? requestParams});
}
