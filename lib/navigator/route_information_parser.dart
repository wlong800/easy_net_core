import 'package:app/base/common/lang.dart';
import 'package:app/base/logger/logger.dart';
import 'package:flutter/material.dart';

import '../global.dart';
import 'router_path.dart';

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
      case MyRoutePath.SEARCH_PATH:
        return MyRoutePath.search();
    }
    return MyRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(MyRoutePath path) {
    logger("restoreRouteInformation 不知道啥时候进这个方法，restore？: ${path.location}");
    return RouteInformation(location: '/');
  }
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
