import 'package:app/base/logger/logger.dart';
import 'package:app/page/topics_page.dart';
import 'package:app/page/user_center_page.dart';
import 'package:app/test/test2_page.dart';
import 'package:app/test/widget_page.dart';
import 'package:flutter/material.dart';

import 'bottom_navigator.dart';

typedef RouteChangeListener(RouteStatusInfo current, RouteStatusInfo pre);

///创建页面
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

///获取routeStatus在页面栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routeStatus) {
      return i;
    }
  }
  return -1;
}

///自定义路由封装，路由状态（1）
enum RouteStatus {
  home,
  center,
  topics,
  setting,
  test1,
  test2,
  unknown,
}

///获取page对应的RouteStatus,增加一个page，这个地方就需要注册一个（2）
RouteStatus getStatus(MaterialPage page) {
  if (page.child is BottomNavigator) {
    return RouteStatus.home;
  } else if (page.child is UserCenterPage) {
    return RouteStatus.center;
  } else if (page.child is TopicsPage) {
    return RouteStatus.topics;
  } else if (page.child is WidgetTestPage) {
    return RouteStatus.test1;
  } else if (page.child is TextAreaPage) {
    return RouteStatus.test2;
  }
  return RouteStatus.unknown;
}

///路由信息
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

///监听路由页面跳转
///感知当前页面是否压后台
class EasyNavigator extends _RouteJumpListener {
  static EasyNavigator? _instance;

  RouteJumpListener? _routeJump;
  List<RouteChangeListener> _listeners = [];
  RouteStatusInfo? _current;

  //首页底部tab
  RouteStatusInfo? _bottomTab;

  EasyNavigator._();

  static EasyNavigator getInstance() {
    if (_instance == null) {
      _instance = EasyNavigator._();
    }
    return _instance!;
  }

  ///首页底部tab切换监听
  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab!);
  }

  ///注册路由跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    this._routeJump = routeJumpListener;
  }

  ///监听路由页面跳转
  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  ///移除监听
  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map<String, dynamic>? args}) {
    _routeJump?.onJumpTo?.call(routeStatus, args: args);
  }

  ///通知路由页面变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;
    var current =
        RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if (current.page is BottomNavigator && _bottomTab != null) {
      //如果打开的是首页，则明确到首页具体的tab
      current = _bottomTab!;
    }
    logger('easy_navigator:current:${current.page}');
    logger('easy_navigator:pre:${_current?.page}');
    _listeners.forEach((listener) {
      listener(current, _current!);
    });
    _current = current;
  }
}

///抽象类供HiNavigator实现
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map<String, dynamic>? args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus,
    {Map<String, dynamic>? args});

///定义路由跳转逻辑要实现的功能
class RouteJumpListener {
  final OnJumpTo? onJumpTo;

  RouteJumpListener({this.onJumpTo});
}
