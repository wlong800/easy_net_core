import 'package:app/base/common/resource.dart';
import 'package:app/base/logger/logger.dart';
import 'package:app/base/widget/custom_refresh_kit.dart';
import 'package:app/navigator/easy_navigator.dart';
import 'package:app/page/home/view_model/community_view_model.dart';
import 'package:app/provider/base_refresh_state.dart';
import 'package:flutter/material.dart';

import 'cell/community_image_cell.dart';
import 'cell/community_text_cell.dart';
import 'cell/community_video_cell.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState
    extends BaseRefreshState<MainHomePage, CommunityViewModel> {
  var listener;

  @override
  void initState() {
    super.initState();
    EasyNavigator.getInstance().addListener(this.listener = (current, pre) {
      logger('home:current:${current.page}');
      logger('home:pre:${pre.page}');
      if (widget == current.page || current.page is MainHomePage) {
        logger('打开了首页:onResume');
      } else if (widget == pre?.page || pre?.page is MainHomePage) {
        logger('首页:onPause');
      }
    });
  }

  @override
  void dispose() {
    EasyNavigator.getInstance().removeListener(this.listener);
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context, CommunityViewModel model) {
    var list = model.data;
    return SafeArea(
      child: AHRefresher(
        controller: refreshController,
        onLoadMoreErrorCallback: onLoadMore,
        onRefresh: onRefresh,
        onLoadMore: onLoadMore,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            var model = list[index];
            if (model.isImages()) {
              return CommunityImageCell(model: model);
            } else if (model.isVideo()) {
              return CommunityVideoCell(model: model);
            } else if (model.isContent()) {
              return CommunityTextCell(model: model);
            }
            return Container(
                height: 40.0,
                color: Colors.red,
                child: Center(child: Text("样式暂未支持 ${index + 1}")));
          },
          itemCount: list.length,
        ),
      ),
    );
  }

  @override
  Widget buildFullScreen(BuildContext context, CommunityViewModel model) {
    initScreenUtil(context);
    return Material(
      child: build2(context, model),
    );
  }

  @override
  Map<String, dynamic>? getRequestParams() {
    return {"feedType": "NEW"};
  }

  bool get wantKeepAlive => true;
}
