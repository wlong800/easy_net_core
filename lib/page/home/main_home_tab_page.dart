import 'package:app/base/widget/custom_refresh_kit.dart';
import 'package:app/page/home/view_model/community_view_model.dart';
import 'package:app/provider/base_refresh_state.dart';
import 'package:flutter/material.dart';

import 'cell/community_image_cell.dart';
import 'cell/community_text_cell.dart';
import 'cell/community_video_cell.dart';

class MainHomeTabPage extends StatefulWidget {
  const MainHomeTabPage({Key? key}) : super(key: key);

  @override
  _MainHomeTabPageState createState() => _MainHomeTabPageState();
}

class _MainHomeTabPageState
    extends BaseRefreshState<MainHomeTabPage, CommunityViewModel> {
  @override
  Widget buildBody(BuildContext context, CommunityViewModel model) {
    var list = model.data;
    return AHRefresher(
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
    );
  }

  @override
  Widget buildFullScreen(BuildContext context, CommunityViewModel model) {
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
