import 'package:app/page/custom_contacts_page.dart';
import 'package:app/provider/services/service_locator.dart';
import 'package:flutter/material.dart';

import 'base/common/channel_tools.dart';
import 'base/common/global.dart';
import 'base/common/logger.dart';
import 'base/common/resource.dart';

GlobalKey<NavigatorState> navigatorState = new GlobalKey();

main() async {
  setupServiceLocator();
  // await Global.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
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
      home: CustomContactsPage(),
    );
  }

  @override
  Future<bool> didPopRoute() async {
    if ((await navigatorState.currentState?.maybePop()) == false) {
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
