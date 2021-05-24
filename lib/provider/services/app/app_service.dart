import 'package:app/base/api/models/base_response.dart';

abstract class AppService {
  Future<BaseResponse?>? fetchContactsData({Map<String, dynamic>? params});
}
