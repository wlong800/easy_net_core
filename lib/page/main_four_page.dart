import 'package:flutter/material.dart';

class MainFourPage extends StatefulWidget {
  const MainFourPage({Key? key}) : super(key: key);

  @override
  _MainFourPageState createState() => _MainFourPageState();
}

class _MainFourPageState extends State<MainFourPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("four..."),
    );
  }

  bool get wantKeepAlive => true;
}
