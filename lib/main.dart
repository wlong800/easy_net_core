import 'dart:ui';

import 'package:app/base/common/lang.dart';
import 'package:app/services/service_locator.dart';
import 'package:app/router.dart';
import 'package:flutter/material.dart';

import 'base/common/channel_tools.dart';
import 'base/common/logger.dart';
import 'base/common/resource.dart';

GlobalKey<NavigatorState> navigatorState = new GlobalKey();

main() async {
  setupServiceLocator();
  // await Global.init();
  runApp(MyApp(
    scheme: window.defaultRouteName,
  ));
}

class MyApp extends StatefulWidget {
  final String? scheme;

  const MyApp({Key? key, this.scheme}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorState,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: R.color_background,
      ),
      home: pushPageByRouter(toString2(widget.scheme)),
    );
  }

  @override
  Future<bool> didPopRoute() async {
    if (isAndroid() && (await navigatorState.currentState?.maybePop()) == false) {
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
}
