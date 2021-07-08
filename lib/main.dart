import 'dart:ui';

import 'package:app/base/common/lang.dart';
import 'package:app/global.dart';
import 'package:app/page/setting_page.dart';
import 'package:app/page/topics_page.dart';
import 'package:app/page/user_center_page.dart';
import 'package:app/services/service_locator.dart';
import 'package:app/test/test2_page.dart';
import 'package:app/test/widget_page.dart';
import 'package:flutter/material.dart';

import 'base/widget/common_ui_kit.dart';
import 'base/logger/logger.dart';
import 'base/common/resource.dart';
import 'navigator/bottom_navigator.dart';
import 'navigator/easy_navigator.dart';

GlobalKey<NavigatorState> navigatorState = GlobalKey();

main() async {
  setupServiceLocator();
  runApp(MyApp(
    router: window.defaultRouteName,
  ));
}

class MyApp extends StatefulWidget {
  final String? router;

  const MyApp({Key? key, this.router}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late MyRouteDelegate _routeDelegate = MyRouteDelegate();
  MyRouteInformationParser _routeInformationParser = MyRouteInformationParser();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    logger("router: ${widget.router}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorState,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: R.color_background,
      ),
      home: FutureBuilder(
        future: _initData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Router(
              routerDelegate: _routeDelegate,
              routeInformationParser: _routeInformationParser,
              routeInformationProvider: PlatformRouteInformationProvider(
                  initialRouteInformation:
                      RouteInformation(location: "/"/*"wmactivity://topics?id=123"*/)),
            );
          }
          return Material(
            child: LoadingKit(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  _initData() async {
    await Global.init();
  }
}

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

  // @override
  // Future<void> setInitialRoutePath(MyRoutePath configuration) {
  //   logger(
  //       "setInitialRoutePath....: location: ${configuration.location}, params : ${configuration.params}");
  //   _routeStatus = routeStatus;
  //   _params = configuration.params;
  //   return super.setInitialRoutePath(configuration);
  // }

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

class MyRouteInformationParser extends RouteInformationParser<MyRoutePath> {
  @override
  Future<MyRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(toString2(routeInformation.location));
    String host = uri.host;
    String scheme = uri.scheme;
    logger("scheme: $scheme , host: $host");
    if (!inWhiteList(scheme)) {
      return MyRoutePath.unknown();
    }

    /// (4)
    switch (host) {
      case MyRoutePath.MAIN_PATH:
        return MyRoutePath.main();
      case MyRoutePath.SETTING_PATH:
        return MyRoutePath.setting();
      case MyRoutePath.DETAIL_PATH:
        return MyRoutePath.detail();
      case MyRoutePath.CENTER_PATH:
        return MyRoutePath.center();
      case MyRoutePath.TOPICS_PATH:
        return MyRoutePath.topics(params: uri.queryParameters);
      case MyRoutePath.TEST1_PATH:
        return MyRoutePath.test1();
      case MyRoutePath.TEST2_PATH:
        return MyRoutePath.test2();
    }
    return MyRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(MyRoutePath path) {
    logger("restoreRouteInformation 不知道啥时候进这个方法，restore？: ${path.location}");
    return RouteInformation(location: '/');
  }
}

///定义路由数据，path & params（3）
class MyRoutePath {
  static const MAIN_PATH = "/";
  static const DETAIL_PATH = "detail";
  static const CENTER_PATH = "center";
  static const TOPICS_PATH = "topics";
  static const SETTING_PATH = "setting";
  static const TEST1_PATH = "test1";
  static const TEST2_PATH = "test2";
  static const UNKNOWN_PATH = "unknown";

  final String location;
  final Map<String, dynamic>? params;

  ///主页面
  MyRoutePath.main({this.params}) : location = MAIN_PATH;

  ///详情页
  MyRoutePath.detail({this.params}) : location = DETAIL_PATH;

  ///个人中心页
  MyRoutePath.center({this.params}) : location = CENTER_PATH;

  ///帖子聚合页
  MyRoutePath.topics({this.params}) : location = TOPICS_PATH;

  ///Setting页
  MyRoutePath.setting({this.params}) : location = SETTING_PATH;

  ///test1页
  MyRoutePath.test1({this.params}) : location = TEST1_PATH;

  ///test2页
  MyRoutePath.test2({this.params}) : location = TEST2_PATH;

  /// 404页面
  MyRoutePath.unknown()
      : location = UNKNOWN_PATH,
        params = null;
}

bool inWhiteList(String scheme) {
  ///白名单列表
  bool isWhite = false;
  Global.SCHEMES.forEach((element) {
    if (element == scheme) {
      isWhite = true;
    }
  });
  return isWhite;
}
