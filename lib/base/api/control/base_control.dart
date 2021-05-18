import 'package:app/base/api/net/services/net_state_enum.dart';
import 'package:app/base/widget/common_ui_kit.dart';
import 'package:flutter/material.dart';

abstract class BaseModelControl<T> {
  NetState? connectionState;

  T? mData;

  int? mRefreshLoadMoreState = LoadingMoreKit.STATE_LOADING;

  String? mLastId;

  void onShowLoading() {
    connectionState = NetState.waiting;
  }

  void onHideLoading() {}

  void onShowDialogLoading();

  void onDismissDialogLoading();

  void onSuccess(T data, String? lastId, int requestCode);

  void onError(int? code, String? msg, int requestCode);

  void onEmpty();
}

abstract class BaseViewControl {
  Widget? build2(BuildContext context, NetState connectionState);

  Widget? showBodyWidget(BuildContext context);

  Widget? showEmptyWidget();

  Widget showLoadingWidget();

  Widget? showErrorWidget();

  showDialogKt(BuildContext context);

  hideDialogKt(BuildContext context);
}
