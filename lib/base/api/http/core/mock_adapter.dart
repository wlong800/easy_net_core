import 'package:app/base/api/http/request/base_request.dart';

import 'easy_net_adapter.dart';

///测试适配器，mock数据
class MockAdapter extends EasyNetAdapter {
  @override
  Future<EasyNetResponse<T>> send<T>(BaseRequest request) {
    return Future<EasyNetResponse<T>>.delayed(Duration(milliseconds: 1000), () {
      return EasyNetResponse<T>(data: null, code: 403);
    });
  }

  @override
  rich(BaseRequest request) {}
}
