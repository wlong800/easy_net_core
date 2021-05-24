import 'package:app/page/custom_contacts_page.dart';
import 'package:app/provider/services/service_locator.dart';
import 'package:flutter/material.dart';

import 'base/common/resource.dart';

GlobalKey<NavigatorState> navigatorState = new GlobalKey();

main() async {
  // await Global.init();
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorState,
      theme: ThemeData(
        backgroundColor: R.color_background,
      ),
      home: CustomContactsPage(),
    );
  }
}
