import 'package:app/base/common/resource.dart';
import 'package:app/base/widget/custom_refresh_kit.dart';
import 'package:app/page/home/view_model/community_view_model.dart';
import 'package:app/provider/base_refresh_state.dart';
import 'package:flutter/material.dart';

import 'cell/community_cell.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState
    extends BaseRefreshState<MainHomePage, CommunityViewModel> {
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
            if (model.isMultiImages()) {
              return Container(
                  height: 25.0, child: Text("我是9宫格样式 ${index + 1}"));
            } else if (model.isSingleImage()) {
              return Container(
                  height: 25.0, child: Text("我是一张图样式 ${index + 1}"));
            } else if (model.isVideo()) {
              return Container(
                  height: 25.0, child: Text("我是视频样式 ${index + 1}"));
            } else if (model.isContent()) {
              return CommunityCell(model: model);
            }
            return Container(height: 40.0, child: Text("xxxx ${index + 1}"));
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
}
