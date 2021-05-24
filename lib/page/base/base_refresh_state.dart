import 'package:app/base/common/lang.dart';
import 'package:app/provider/base_view_models.dart';
import 'package:flutter/material.dart';
import 'base_provider_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BaseRefreshState<T extends StatefulWidget,
    M extends BaseProviderModel> extends BaseProviderState<T, M> {
  RefreshController refreshController = RefreshController();
  bool _isLoading = false;

  Future<void> onLoadMore() async {
    if (isEmpty(providerModel.lastId)) {
      refreshController.loadNoData();
      return;
    }
    if (_isLoading) return;
    _isLoading = true;
    refreshController.loadComplete();
    await providerModel.loadData(
        lastId: providerModel.lastId, params: getRequestParams());
    _isLoading = false;
    if (providerModel.loadError) {
      refreshController.loadFailed();
      return;
    }
    isEmpty(providerModel.lastId)
        ? refreshController.loadNoData()
        : refreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    refreshController.resetNoData();
    await onFetchData(showLoadingUI: false);
    refreshController.refreshCompleted();
  }
}
