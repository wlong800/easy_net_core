import 'dart:ui';

import 'package:app/base/common/lang.dart';
import 'package:app/base/config/impl/base_logger_config.dart';
import 'package:app/base/config/impl/base_proxy_config.dart';
import 'package:app/global.dart';
import 'package:app/services/service_locator.dart';
import 'package:app/router.dart';
import 'package:flutter/material.dart';

import 'base/config/config_manager.dart';
import 'base/widget/common_ui_kit.dart';
import 'tools/channel_tools.dart';
import 'base/logger/logger.dart';
import 'base/common/resource.dart';

GlobalKey<NavigatorState> navigatorState = new GlobalKey();

main() async {
  setupServiceLocator();
  ConfigManager.getInstance()
      // .addConfig(BaseProxyConfig("10.6.12.169", "8888"))
      .addConfig(BaseLoggerConfig())
      .build();
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
        future: _initGlobalInfo(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return pushPageByRouter(widget.router!);
          }
          return Material(
            child: LoadingKit(),
          );
        },
      ),
    );
  }

  @override
  Future<bool> didPopRoute() async {
    if (isAndroid() &&
        (await navigatorState.currentState?.maybePop()) == false) {
      logger("not pop, because _history is null...");
      systemPop();
    }
    return Future<bool>.value(true);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  _initGlobalInfo() async {
    await Global.getNativeGlobalInfo();
  }
}
