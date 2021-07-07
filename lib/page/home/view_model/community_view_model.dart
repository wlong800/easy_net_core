import 'package:app/base/common/common_callback.dart';
import 'package:app/base/logger/logger.dart';
import 'package:app/base/model/base_feed_model.dart';
import 'package:app/page/models/community_model.dart';
import 'package:app/provider/base_view_models.dart';

class CommunityViewModel extends BaseProviderModel<List<CommunityFeedModel>> {
  CommunityViewModel() : super(creator: () => []);

  @override
  Future<Null> loadData(
      {String? lastId,
      Map<String, dynamic>? params,
      Callback? responseBack}) async {
    Map<String, dynamic> requestParams = handleRequestParams(lastId, params);
    var response =
        await appService.fetchCommunityData(requestParams: requestParams);
    if (!onResponseSuccess(response)) return;
    var responseData = BaseDataResponse.fromJson(response?.data);
    if (!onDataResponseSuccess(responseData)) return;
    (responseData.content as List).forEach((element) {
      try {
        data.add(CommunityFeedModel.fromJson(element));
      } catch (e) {
        logger(e);
      }
    });
    notifyDataSetChanged();
  }
}
