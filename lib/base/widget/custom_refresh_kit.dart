import 'package:app/base/widget/refresh_header.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../global.dart';
import 'common_ui_kit.dart';

class CustomLoadMoreFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildLoadMoreFooter();
  }

  CustomFooter buildLoadMoreFooter() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text("pull up load");
        } else if (mode == LoadStatus.loading) {
          body = Text("Loading");
        } else if (mode == LoadStatus.failed) {
          body = Text("Load Failed!Click retry!");
        } else if (mode == LoadStatus.canLoading) {
          body = Text("release to load more");
        } else {
          body = Text("No more Data");
        }
        return Container(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}

class CustomRefreshHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildRefreshHeader();
  }

  WaterDropHeader buildRefreshHeader() => WaterDropHeader();
}

//child为复合组件，比如Stack
class OnlyRefresher extends StatelessWidget {
  final VoidCallback? onRefresh;
  final VoidCallback? onLoadMore;
  final RefreshController? controller;
  final bool enablePullDown;
  final Widget? child;
  final Widget? footer; //页脚--如果有页脚,则强制不能上拉加载

  const OnlyRefresher(
      {Key? key,
      this.onRefresh,
      this.onLoadMore,
      this.controller,
      this.enablePullDown = true,
      this.child,
      this.footer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshConfiguration(
      headerTriggerDistance: Global.refreshHeight,
      child: SmartRefresher.builder(
          enablePullDown: enablePullDown,
          enablePullUp: false,
          onRefresh: onRefresh,
          controller: controller!,
          builder: (context, physic) {
            return CustomScrollView(
              slivers: [
                RefreshHeader(),
                SliverToBoxAdapter(
                  child: child,
                ),
                (footer != null)
                    ? SliverFillRemaining(
                        hasScrollBody: false,
                        fillOverscroll: true,
                        child: footer,
                      )
                    : SliverToBoxAdapter()
              ],
            );
          }),
    );
  }
}

//child为可滑动组件
class AHRefresher extends StatelessWidget {
  final VoidCallback? onRefresh;
  final VoidCallback? onLoadMore;
  final VoidCallback? onLoadMoreErrorCallback;
  final RefreshController? controller;
  final bool enablePullDown;
  final bool enablePullUp;
  final Widget? child;

  const AHRefresher(
      {Key? key,
      this.onRefresh,
      this.onLoadMore,
      this.controller,
      this.enablePullDown = true,
      this.enablePullUp = true,
      this.child,
      this.onLoadMoreErrorCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
        headerTriggerDistance: Global.refreshHeight,
        child: SmartRefresher(
          enablePullDown: enablePullDown,
          enablePullUp: enablePullUp,
          header: RefreshHeader(),
          footer: CustomLoadingMoreKit(
            onLoadMoreErrorCallback: onLoadMoreErrorCallback,
          ),
          controller: controller!,
          onRefresh: onRefresh,
          onLoading: onLoadMore,
          child: child,
        ));
  }
}
