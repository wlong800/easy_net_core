
import 'package:app/base/api/control/base_control.dart';
import 'package:app/base/api/net/services/net_state_enum.dart';

/// 控制界面应该展示什么
class CommonModelControl<T> implements BaseModelControl<T> {
  @override
  NetState? connectionState;

  @override
  T? mData;

  @override
  String? mLastId;

  @override
  int? mRefreshLoadMoreState;

  @override
  void onShowLoading() {}

  @override
  void onHideLoading() {}

  @override
  void onDismissDialogLoading() {}

  @override
  void onShowDialogLoading() {}

  @override
  void onError(int? code, String? msg, int requestCode) {}

  @override
  void onSuccess(T response, String? lastId, int requestCode) {}

  @override
  void onEmpty() {}
}
