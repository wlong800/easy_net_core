import 'package:flutter/material.dart';

class MainThirdPage extends StatefulWidget {
  const MainThirdPage({Key? key}) : super(key: key);

  @override
  _MainThirdPageState createState() => _MainThirdPageState();
}

class _MainThirdPageState extends State<MainThirdPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("third..."),
    );
  }

  bool get wantKeepAlive => true;
}
