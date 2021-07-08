import 'package:app/base/widget/common_ui_kit.dart';
import 'package:flutter/material.dart';

class UserCenterPage extends StatefulWidget {
  const UserCenterPage({Key? key}) : super(key: key);

  @override
  _UserCenterPageState createState() => _UserCenterPageState();
}

class _UserCenterPageState extends State<UserCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WMPreferredSize2("个人中心"),
      body: Center(
        child: Text("我是个人中心"),
      ),
    );
  }
}
