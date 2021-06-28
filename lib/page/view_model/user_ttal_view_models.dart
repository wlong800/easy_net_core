import 'package:app/base/common/common_callback.dart';
import 'package:app/page/models/user_model.dart';
import 'package:app/provider/base_view_models.dart';

class UserInfoViewModel extends BaseProviderModel<UserInfoModel> {
  @override
  Future<Null> loadData(
      {String? lastId,
      Map<String, dynamic>? params,
      Callback? responseBack}) async {
    Map<String, dynamic> requestParams = handleRequestParams(lastId, params);
    var response =
        await appService.fetchContactsData(requestParams: requestParams);
    if (!onResponseSuccess(response)) return;
    setData = UserInfoModel.fromJson(response?.data);
    notifyDataSetChanged();
  }
}
