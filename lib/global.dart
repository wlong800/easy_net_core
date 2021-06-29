import 'package:app/base/api/http/easy_net_global.dart';
import 'package:app/base/common/lang.dart';
import 'package:app/base/hold/hold_manager.dart';
import 'package:app/base/logger/logger.dart';
import 'package:app/page/models/global_model.dart';
import 'package:app/tools/channel_tools.dart';
import 'package:flutter/material.dart';

class Global {
  static GlobalInfo? globalInfo;

  /// 初始化全局信息，会在APP启动时执行
  static Future init() async {
    await HoldManager.instance?.init();
  }

  static getNativeGlobalInfo() async {
    var globalInfoStr = await Channel.getNativeGlobalInfo();
    logger("globalInfoStr: $globalInfoStr");
    if (isNotEmpty(globalInfoStr)) {
      globalInfo = GlobalInfo.fromJson(globalInfoStr);
      EasyNetGlobal.defaultBaseUrl =
          globalInfo?.baseUrl ?? "https://evt.tomorrow365.com/";
    }
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
