import 'package:app/base/common/resource.dart';
import 'package:app/base/common/touch_callback.dart';
import 'package:app/navigator/easy_navigator.dart';
import 'package:flutter/material.dart';

class MainSecondPage extends StatefulWidget {
  const MainSecondPage({Key? key}) : super(key: key);

  @override
  _MainSecondPageState createState() => _MainSecondPageState();
}

class _MainSecondPageState extends State<MainSecondPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: DefaultTextStyle(
          style:
              TextStyle(color: R.color_font_1, fontSize: sp(Sp.font_middle2)),
          child: TouchCallBack(
            child: Column(
              children: [
                Text("xxxx"),
                Text("xxxx"),
                Text("xxxx"),
                Text("xxxx"),
              ],
            ),
            onPressed: () {
              // push(context, WidgetTestPage());
              EasyNavigator.getInstance()
                  .onJumpTo(RouteStatus.test1, args: {"key": 1});
            },
          ),
        ),
      ),
    );
  }
}
