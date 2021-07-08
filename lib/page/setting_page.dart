import 'package:app/base/widget/common_ui_kit.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WMPreferredSize2("设置"),
      body: Center(
        child: Text("我是设置"),
      ),
    );
  }
}
