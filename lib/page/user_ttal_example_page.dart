import 'dart:convert';

import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/utils/tools.dart';
import 'package:app/base/widget/common_ui_kit.dart';
import 'package:app/global.dart';
import 'package:app/page/models/guss_example_model.dart';
import 'package:flutter/material.dart';

class UserTTALExamplePage extends StatefulWidget {
  const UserTTALExamplePage({Key? key}) : super(key: key);

  @override
  _UserTTALExamplePageState createState() => _UserTTALExamplePageState();
}

class _UserTTALExamplePageState extends State<UserTTALExamplePage> {
  var _data = [];

  @override
  void initState() {
    super.initState();
    loadJson(context, "json/guss_example_data.json")
        .then((value) => {
              (json.decode(value) as List).forEach((element) {
                _data.add(GussExampleModel.fromJson(element));
              })
            })
        .whenComplete(() => {setState(() {})});
  }

  @override
  Widget build(BuildContext context) {
    initScreenUtil(context);
    return Scaffold(
      appBar: WMPreferredSize(
        "",
        height: Global.appBarHeight,
      ),
      body: Container(
        color: R.color_white,
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "填写两真一假，更能吸引TA",
                style: TextStyle(
                    color: R.color_font_1,
                    fontSize: sp(Sp.font_bigger),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                "为什么要填写两真一假？",
                style: TextStyle(
                    color: R.color_font_1,
                    fontSize: sp(Sp.font_big),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                "当然是更容易吸引到TA啦！通过两真一假能更好的去了解TA, 更方便的开启聊天~",
                style: TextStyle(
                    color: R.color_font_2, fontSize: sp(Sp.font_middle2)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                "写点什么呢？",
                style: TextStyle(
                    color: R.color_font_1,
                    fontSize: sp(Sp.font_big),
                    fontWeight: FontWeight.bold),
              ),
            ),
            //_buildGridViewItem
            Container(
              child: Expanded(
                child: Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    //增加
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildGridViewItem(index);
                    },
                    itemCount: _data.length,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                "END",
                style:
                    TextStyle(color: R.color_font_1, fontSize: sp(Sp.font_big)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 36.0),
              child: Text(
                "祝你在「完美活动」找到有趣的活动，和有意思的人！",
                style: TextStyle(
                    color: R.color_font_3, fontSize: sp(Sp.font_middle2)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridViewItem(int index) {
    var data = _data[index] as GussExampleModel;
    return Container(
      decoration: MyBoxDecoration.all(radius: 6.0, color: R.color_background),
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      margin: EdgeInsets.only(top: 12.0),
      child: Row(
        children: [
          Container(
            width: 24,
            child: Text(
              toString2(data.title),
              textDirection: TextDirection.ltr,
              softWrap: true,
              style: TextStyle(
                  color: R.color_font_1,
                  fontSize: sp(Sp.font_bigger),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16.0),
            margin: EdgeInsets.only(left: 24.0),
            decoration: MyBoxDecoration.leftDecoration(
                color: R.color_d8d8d8, width: 0.5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _getChildrenAsList(data.subData)),
          ),
        ],
      ),
    );
  }

  List<Widget> _getChildrenAsList(List<String>? descriptionList) {
    var list = <Widget>[];
    int index = 0;
    descriptionList?.forEach((element) {
      list.add(Padding(
        padding: EdgeInsets.only(top: (index == 0) ? 0.0 : 16.0),
        child: Row(
          children: [
            Image.asset(
              "images/icon_guss_title_mark.png",
              width: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                element,
                style: TextStyle(
                    color: R.color_font_1, fontSize: sp(Sp.font_middle2)),
              ),
            ),
          ],
        ),
      ));
      index++;
    });
    return list;
  }
}
