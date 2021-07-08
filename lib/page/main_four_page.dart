import 'package:app/tools/channel_tools.dart';
import 'package:flutter/material.dart';
import 'package:app/base/utils/quote_utils.dart';

class MainFourPage extends StatefulWidget {
  const MainFourPage({Key? key}) : super(key: key);

  @override
  _MainFourPageState createState() => _MainFourPageState();
}

class _MainFourPageState extends State<MainFourPage> {
  UserSpanAction action = (userInfo){
    print("成功 ${userInfo.name} id=${userInfo.id}");
    return 1;
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("four..."),
          QuoteUtil.buildUserQuoteText("heyheyhey=={112,435}==heyheihey", action)
        ],
      )
    );
  }
}
