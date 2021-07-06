import 'dart:ui';

import 'package:app/global.dart';
import 'package:app/main_page.dart';
import 'package:app/services/service_locator.dart';
import 'package:flutter/material.dart';

import 'base/widget/common_ui_kit.dart';
import 'base/logger/logger.dart';
import 'base/common/resource.dart';

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
            return MainPage();
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
