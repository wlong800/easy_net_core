
import 'package:app/base/hold/hold_manager.dart';
import 'package:flutter/material.dart';

enum Environment {
  test,
  beta,
  release
}

class Global {
  static int env = 0;

  static String defaultBaseUrl = "https://evt.tomorrow365.com";

  static bool get isTest => env == 1;

  static bool get isBeta => env == 2;

  static bool get isRelease => env == 0;


  /// 初始化全局信息，会在APP启动时执行
  static Future init() async {
    await HoldManager.init();
  }
}

final ThemeData mDefaultTheme = ThemeData(
  // primaryColor: R.color_1,
  // dividerColor: R.divider_1,
  // backgroundColor: Colors.white,
  // cardColor: Colors.white,
  // scaffoldBackgroundColor: Colors.white,
  // cursorColor: R.color_2,
  // indicatorColor: R.color_2,
  // primaryColorDark: R.color_2,
  // primaryColorLight: R.color_2,
);
