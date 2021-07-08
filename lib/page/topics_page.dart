import 'package:app/base/widget/common_ui_kit.dart';
import 'package:flutter/material.dart';

class TopicsPage extends StatefulWidget {
  final String id;

  const TopicsPage({Key? key, required this.id}) : super(key: key);

  @override
  _TopicsPageState createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WMPreferredSize2("话题聚合页"),
      body: Center(
        child: Text("我是话题聚合页"),
      ),
    );
  }
}
