import 'package:app/base/common/lang.dart';
import 'package:app/base/logger/logger.dart';
import 'package:app/global.dart';
import 'package:app/navigator/router_path.dart';
import 'package:app/page/home/subject_feed_page.dart';
import 'package:app/page/search_page.dart';
import 'package:app/page/setting_page.dart';
import 'package:app/page/topics_page.dart';
import 'package:app/page/user_center_page.dart';
import 'package:app/test/test2_page.dart';
import 'package:app/test/widget_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../router.dart';
import 'bottom_navigator.dart';
import 'easy_navigator.dart';

class MyRouteDelegate extends RouterDelegate<MyRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  final String? router;
  String _routeStatus = MyRoutePath.MAIN_PATH;
  Map<String, dynamic>? _params;
  List<CupertinoPage> pages = [];
  bool _mainStackEmpty = true;

  ///为Navigator设置一个key，必要的时候可以通过navigatorKey.currentState来获取到NavigatorState对象
  MyRouteDelegate({this.router}) : navigatorKey = GlobalKey<NavigatorState>() {
    logger("init RouteDelegate... && router: , $router");
    _initRouter();

    ///实现路由跳转逻辑
    EasyNavigator.getInstance().registerRouteJump(RouteJumpListener(
        onJumpTo: (String routeStatus, {Map<String, dynamic>? args}) {
      logger("push args :: $args");
      if (routeStatus.startsWith(Global.SCHEME)) {
        Uri uri = Uri.parse(routeStatus);
        _routeStatus = uri.host;
        _params = uri.queryParameters;
      } else {
        _routeStatus = routeStatus;
        _params = args;
      }
      notifyListeners();
    }));
  }

  @override
  Widget build(BuildContext context) {
    logger("build....", tag: "MyRouteDelegate");
    var index = getPageIndex(pages, routeStatus);
    List<CupertinoPage> tempPages = pages;
    if (index != -1) {
      //要打开的页面在栈中已存在，则将该页面和它上面的所有页面进行出栈
      //tips 具体规则可以根据需要进行调整，这里要求栈中只允许有一个同样的页面的实例
      tempPages = tempPages.sublist(0, index);
    }

    var page = _getPageByRouteStatus();
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

  String get routeStatus {
    //todo:可以做一些拦截
    var mainIndex = getPageIndex(pages, MyRoutePath.MAIN_PATH);
    if (mainIndex < 0) {
      if (router != MyRoutePath.MAIN_PATH) {
        _mainStackEmpty = true;
      } else {
        _mainStackEmpty = false;
      }
      return MyRoutePath.MAIN_PATH;
    }
    _mainStackEmpty = false;
    return _routeStatus;
  }

  Map<String, dynamic>? get params => _params;

  @override
  Future<void> setNewRoutePath(MyRoutePath path) async {
    logger("setNewRoutePath 。。。");
  }

  void _initRouter() {
    if (router == "/") {
      _routeStatus = MyRoutePath.MAIN_PATH;
      return;
    }
    final uri = Uri.parse(toString2(router));
    String host = uri.host;
    String scheme = uri.scheme;
    _params = uri.queryParameters;
    logger("scheme: $scheme , host: $host");
    if (!inWhiteList(scheme)) {
      _routeStatus = MyRoutePath.UNKNOWN_PATH;
    } else {
      _routeStatus = host;
    }
  }

  /// ---->（2）<----
  _getPageByRouteStatus() {
    var page;
    switch (routeStatus) {
      case MyRoutePath.MAIN_PATH:

        ///跳转首页时将栈中其它页面进行出栈，因为首页不可回退
        pages.clear();
        page = pageWrap(BottomNavigator(router: _mainStackEmpty ? router : null,));
        break;
      case MyRoutePath.CENTER_PATH:
        page = pageWrap(UserCenterPage());
        break;
      case MyRoutePath.SETTING_PATH:
        page = pageWrap(SettingPage());
        break;
      case MyRoutePath.SEARCH_PATH:
        page = pageWrap(SearchPage());
        break;
      case MyRoutePath.TOPICS_PATH:
        page = pageWrap(TopicsPage(id: toString2(params!["id"])));
        break;
      case MyRoutePath.SUBJECT_PATH:
        page = pageWrap(SubjectPage());
        break;
      case MyRoutePath.TEST1_PATH:
        page = pageWrap(TextAreaPage());
        break;
      case MyRoutePath.TEST2_PATH:
        page = pageWrap(WidgetTestPage());
        break;
    }
    return page;
  }
}
