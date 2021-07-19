import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/navigator/easy_navigator.dart';
import 'package:app/navigator/router_path.dart';
import 'package:app/page/map_page.dart';
import 'package:app/test/anim/hero_page.dart';
import 'package:app/test/anim/logo_app.dart';
import 'package:app/test/anim/stagger_page.dart';
import 'package:app/test/anim/switch_page.dart';
import 'package:app/test/app.dart';
import 'package:app/test/collapsing_page.dart';
import 'package:app/test/web_view_page.dart';
import 'package:flutter/material.dart';
import 'package:all_future_plugin/native_view_example.dart';

class MainSecondPage extends StatefulWidget {
  const MainSecondPage({Key? key}) : super(key: key);

  @override
  _MainSecondPageState createState() => _MainSecondPageState();
}

class _MainSecondPageState extends State<MainSecondPage>
    with TickerProviderStateMixin {
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
                    EasyNavigator.getInstance()
                        .onJumpTo(MyRoutePath.SUBJECT_PATH);
                  }),
              ElevatedButton(
                  child: Text("跳转到原生视图托管页"),
                  onPressed: () {
                    push(context, NativeViewExample());
                  }),
              ElevatedButton(
                  child: Text("跳转到高德地图"),
                  onPressed: () {
                    push(context, MapPage());
                  }),
              ElevatedButton(
                  child: Text("跳转到视频"),
                  onPressed: () {
                    push(context, ChewieDemo());
                  }),
              ElevatedButton(
                  child: Text("跳转到动画"),
                  onPressed: () {
                    push(context, LogoPage());
                  }),
              ElevatedButton(
                  child: Text("跳转到Hero动画"),
                  onPressed: () {
                    push(
                        context,
                        Material(
                          child: SafeArea(
                            child: HeroAnimationRoute(),
                          ),
                        ));
                  }),
              ElevatedButton(
                  child: Text("跳转到Stagger动画"),
                  onPressed: () {
                    push(
                        context,
                        Material(
                          child: SafeArea(
                            child: StaggerRoute(),
                          ),
                        ));
                  }),
              ElevatedButton(
                  child: Text("跳转到Switch动画"),
                  onPressed: () {
                    push(
                        context,
                        Material(
                          child: SafeArea(
                            child: AnimatedSwitcherCounterRoute(),
                          ),
                        ));
                  }),
              ElevatedButton(
                  child: Text("跳转到WebView"),
                  onPressed: () {
                    push(
                        context,
                        Material(
                          child: SafeArea(
                            child: WebViewExample(),
                          ),
                        ));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  bool get wantKeepAlive => true;
}
