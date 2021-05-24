import 'package:app/base/api/net/services/net_state_enum.dart';
import 'package:app/base/common/logger.dart';
import 'package:app/base/widget/common_ui_kit.dart';
import 'package:app/provider/base_view_models.dart';
import 'package:app/provider/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseProviderState<T extends StatefulWidget,
        M extends BaseProviderModel> extends State<T>
    with AutomaticKeepAliveClientMixin {
  M providerModel = serviceLocator<M>();
  bool _onOneTimeLoadSuccess = false;

  @override
  bool get wantKeepAlive => false;

  bool get initFetchData => true;

  @override
  void initState() {
    super.initState();
    if (initFetchData) onFetchData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return changeNotifierProvider(context);
  }

  Widget changeNotifierProvider(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: providerModel,
      builder: (BuildContext context, Widget? child) {
        return Consumer<M>(
          builder: (context, model, child) {
            return buildFullScreen(context, model);
          },
        );
      },
    );
  }

  void successCallback(value) {}

  Widget build2(BuildContext context, M model) {
    var connectionState = model.connectionState;
    logger(
        "build2 _onOneTimeLoadSuccess : $_onOneTimeLoadSuccess ,connectionState: $connectionState");
    if (!_onOneTimeLoadSuccess && connectionState != NetState.waiting) {
      onOneTimeLoadComplete(connectionState);
    }
    if (connectionState == NetState.waiting) {
      return buildLoadingWidget();
    } else if (connectionState == NetState.done) {
      _onOneTimeLoadSuccess = true;
      return buildBody(context, model);
    } else if (connectionState == NetState.error) {
      _onOneTimeLoadSuccess = true;
      return buildErrorWidget();
    } else if (connectionState == NetState.empty) {
      _onOneTimeLoadSuccess = true;
      return buildEmptyWidget();
    }
    return buildLoadingWidget();
  }

  Widget buildBody(BuildContext context, M model);

  /// 代替build(BuildContext context)
  Widget buildFullScreen(BuildContext context, M model);

  Widget buildEmptyWidget() {
    return EmptyWidget();
  }

  Widget buildErrorWidget() {
    return Error2Widget(
      func: () {
        onFetchData();
      },
    );
  }

  Widget buildLoadingWidget() {
    return LoadingKit();
  }

  /// 打点用到，页面加载完成调用,只调用一次，就够
  onOneTimeLoadComplete(NetState state) {
    logger("onOneTimeLoadComplete : ${state.index}");
  }

  onFetchData({bool showLoadingUI = true, bool loadMore = false}) async {
    if (!loadMore) providerModel.setLastId = null;
    if (showLoadingUI) providerModel.onLoading();
    return await providerModel.loadData(
        lastId: providerModel.lastId,
        params: getRequestParams(),
        responseBack: successCallback);
  }

  Map<String, dynamic>? getRequestParams() {
    return null;
  }
}
