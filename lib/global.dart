import 'package:app/base/api/http/easy_net_global.dart';
import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/hold/hold_manager.dart';
import 'package:app/base/logger/logger.dart';
import 'package:app/page/models/global_model.dart';
import 'package:app/tools/channel_tools.dart';
import 'package:flutter/material.dart';

import 'base/config/config_manager.dart';
import 'base/config/impl/base_logger_config.dart';
import 'base/config/impl/base_proxy_config.dart';
import 'base/hold/hold.dart';

class Global {
  static GlobalInfo? globalInfo;
  static double appBarHeight = Size2.app_bar_height;
  static double refreshHeight = 80.0;
  static int limit = 20;
  static const SCHEMES = ["wmactivity"];
  static const SCHEME = "wmactivity://";

  /// 初始化全局信息，会在APP启动时执行
  static Future init() async {
    await HoldManager?.preInit();
    String proxy = Hold.getString("proxy_setting");
    // if (isNotEmpty(proxy)) {
      ConfigManager.getInstance()
          // .addConfig(BaseProxyConfig(proxy.split(":")[0], proxy.split(":")[1]))
          .addConfig(BaseProxyConfig("10.6.12.169", "8888"))
          .addConfig(BaseLoggerConfig())
          .build();
    // }
    await getNativeGlobalInfo();

  }

  static getNativeGlobalInfo() async {
    var globalInfoStr = await AHChannel.getNativeGlobalInfo();
    logger("globalInfoStr: $globalInfoStr");
    if (globalInfoStr != null) {
      globalInfo =
          GlobalInfo.fromJson(Map<String, dynamic>.from(globalInfoStr));
      EasyNetGlobal.defaultBaseUrl =
          globalInfo?.baseUrl ?? "http://10.3.246.115/";
      logger("defaultBaseUrl: ${EasyNetGlobal.defaultBaseUrl}");
      if (!EasyNetGlobal.defaultBaseUrl.endsWith("/"))
        EasyNetGlobal.defaultBaseUrl = EasyNetGlobal.defaultBaseUrl + "/";
      if (globalInfo?.appBarHeight != null) {
        appBarHeight = toDouble(globalInfo?.appBarHeight);
      }
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
