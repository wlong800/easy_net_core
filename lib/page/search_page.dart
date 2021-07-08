import 'package:app/base/widget/common_ui_kit.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WMPreferredSize2("搜索"),
      body: Center(
        child: Text("我是搜索"),
      ),
    );
  }
}
