import 'package:app/base/common/lang.dart';
import 'package:app/base/logger/logger.dart';
import 'package:app/navigator/router_path.dart';
import 'package:app/page/search_page.dart';
import 'package:app/page/setting_page.dart';
import 'package:app/page/topics_page.dart';
import 'package:app/page/user_center_page.dart';
import 'package:app/test/test2_page.dart';
import 'package:app/test/widget_page.dart';
import 'package:flutter/material.dart';

import 'bottom_navigator.dart';
import 'easy_navigator.dart';

class MyRouteDelegate extends RouterDelegate<MyRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  RouteStatus _routeStatus = RouteStatus.home;
  Map<String, dynamic>? _params;
  List<MaterialPage> pages = [];

  ///为Navigator设置一个key，必要的时候可以通过navigatorKey.currentState来获取到NavigatorState对象
  MyRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    logger("init... , GlobalKey<NavigatorState>....", tag: "MyRouteDelegate");
    //实现路由跳转逻辑
    EasyNavigator.getInstance().registerRouteJump(RouteJumpListener(
        onJumpTo: (RouteStatus routeStatus, {Map<String, dynamic>? args}) {
      logger("push args :: $args");
      _routeStatus = routeStatus;
      _params = args;
      notifyListeners();
    }));
  }

  @override
  Widget build(BuildContext context) {
    logger("build....", tag: "MyRouteDelegate");
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      //要打开的页面在栈中已存在，则将该页面和它上面的所有页面进行出栈
      //tips 具体规则可以根据需要进行调整，这里要求栈中只允许有一个同样的页面的实例
      tempPages = tempPages.sublist(0, index);
    }

    /// (5)
    var page;
    if (routeStatus == RouteStatus.home) {
      ///跳转首页时将栈中其它页面进行出栈，因为首页不可回退
      pages.clear();
      page = pageWrap(BottomNavigator());
    } else if (routeStatus == RouteStatus.center) {
      page = pageWrap(UserCenterPage());
    } else if (routeStatus == RouteStatus.setting) {
      page = pageWrap(SettingPage());
    } else if (routeStatus == RouteStatus.topics) {
      page = pageWrap(TopicsPage(id: toString2(params!["id"])));
    } else if (routeStatus == RouteStatus.test2) {
      page = pageWrap(TextAreaPage());
    } else if (routeStatus == RouteStatus.test1) {
      page = pageWrap(WidgetTestPage());
    } else if (routeStatus == RouteStatus.search) {
      page = pageWrap(SearchPage());
    }
    //重新创建一个数组，否则pages因引用没有改变路由不会生效
    tempPages = [...tempPages, page];
    //通知路由发生变化
    EasyNavigator.getInstance().notify(tempPages, pages);
    pages = tempPages;
    return WillPopScope(
      //fix Android物理返回键，无法返回上一页问题@https://github.com/flutter/flutter/issues/66349
      onWillPop: () async =>
          await navigatorKey.currentState?.maybePop() == false,
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (route, result) {
          //执行返回操作
          if (!route.didPop(result)) {
            return false;
          }
          var tempPages = [...pages];
          pages.removeLast();
          //通知路由发生变化
          EasyNavigator.getInstance().notify(pages, tempPages);
          return true;
        },
      ),
    );
  }

  RouteStatus get routeStatus {
    //todo:可以做一些拦截
    return _routeStatus;
  }

  Map<String, dynamic>? get params => _params;

  @override
  Future<void> setNewRoutePath(MyRoutePath path) async {
    logger("setNewRoutePath ${path.location}");
    // _routeStatus = RouteStatus.topics;
    // _params = path.params;
  }
}
