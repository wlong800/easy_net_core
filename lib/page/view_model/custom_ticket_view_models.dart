import 'package:app/base/common/common_callback.dart';
import 'package:app/page/models/contacts_model.dart';
import 'package:app/provider/base_view_models.dart';

class CustomTicketViewModel extends BaseProviderModel<List<ContactsModel>> {
  CustomTicketViewModel() : super(creator: () => []);

  @override
  Future<Null> loadData(
      {String? lastId,
      Map<String, dynamic>? params,
      Callback? responseBack}) async {
    Map<String, dynamic> requestParams = handleRequestParams(lastId, params);
    var response = await appService.fetchContactsData(params: requestParams);
    if (!onResponseSuccess(response)) return;
    (response!.data as List).forEach((element) {
      data.add(ContactsModel.fromJson(element));
    });
    notifyDataSetChanged();
  }
}
