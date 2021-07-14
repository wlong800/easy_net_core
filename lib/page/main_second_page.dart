import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/navigator/easy_navigator.dart';
import 'package:app/navigator/router_path.dart';
import 'package:app/test/collapsing_page.dart';
import 'package:flutter/material.dart';

class MainSecondPage extends StatefulWidget {
  const MainSecondPage({Key? key}) : super(key: key);

  @override
  _MainSecondPageState createState() => _MainSecondPageState();
}

class _MainSecondPageState extends State<MainSecondPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: DefaultTextStyle(
          style:
              TextStyle(color: R.color_font_1, fontSize: sp(Sp.font_middle2)),
          child: Column(
            children: [
              ElevatedButton(
                  child: Text("跳转到话题聚合页，带参数"),
                  onPressed: () {
                    EasyNavigator.getInstance()
                        .onJumpTo(MyRoutePath.TOPICS_PATH, args: {"id": 1});
                  }),
              ElevatedButton(
                  child: Text("跳转到用户中心"),
                  onPressed: () {
                    EasyNavigator.getInstance()
                        .onJumpTo(MyRoutePath.CENTER_PATH, args: {"id": 1});
                  }),
              ElevatedButton(
                  child: Text("跳转到设置"),
                  onPressed: () {
                    EasyNavigator.getInstance()
                        .onJumpTo(MyRoutePath.SETTING_PATH, args: {"id": 1});
                  }),
              ElevatedButton(
                  child: Text("跳转到测试控件"),
                  onPressed: () {
                    EasyNavigator.getInstance()
                        .onJumpTo(MyRoutePath.TEST2_PATH, args: {"id": 1});
                  }),
              ElevatedButton(
                  child: Text("跳转到CollapsingToolbarLayout1"),
                  onPressed: () {
                    push(context, MainCollapsingToolbar());
                  }),
              ElevatedButton(
                  child: Text("跳转到专题页"),
                  onPressed: () {
                    EasyNavigator.getInstance().onJumpTo(MyRoutePath.SUBJECT_PATH);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  bool get wantKeepAlive => true;
}
