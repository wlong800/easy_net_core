import 'package:app/navigator/easy_navigator.dart';
import 'package:app/navigator/router_path.dart';
import 'package:flutter/material.dart';
import 'package:app/base/utils/quote_utils.dart';

class MainFourPage extends StatefulWidget {
  const MainFourPage({Key? key}) : super(key: key);

  @override
  _MainFourPageState createState() => _MainFourPageState();
}


class _MainFourPageState extends State<MainFourPage> with TickerProviderStateMixin {
  UserSpanAction action = (userInfo){
    print("成功 ${userInfo.name} id=${userInfo.id}");
    EasyNavigator.getInstance().onJumpTo(MyRoutePath.CENTER_PATH);
    return 1;
  };
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text("four..."),
          QuoteUtil.buildUserQuoteText("heyheyhey=={112,435}==heyheihey", action)
        ],
      )
    );
  }

  bool get wantKeepAlive => true;
}
