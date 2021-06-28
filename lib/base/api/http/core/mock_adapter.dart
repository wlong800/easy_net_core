import 'package:app/base/api/http/request/easy_base_request.dart';

import 'easy_net_adapter.dart';

///测试适配器，mock数据
class MockAdapter extends EasyNetAdapter {
  @override
  Future<EasyBaseResponse> send(EasyBaseRequest request) {
    return Future<EasyBaseResponse>.delayed(Duration(milliseconds: 1000), () {
      return EasyBaseResponse(data: {}, code: 403);
    });
  }

  @override
  rich(EasyBaseRequest request) {}
}
