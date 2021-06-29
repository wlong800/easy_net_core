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
        height: toDouble(Global.globalInfo?.appBarHeight) > 0
            ? toDouble(Global.globalInfo?.appBarHeight)
            : Size2.app_bar_height,
      ),
      body: Container(
        color: R.color_white,
        padding: EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              "填写两真一假，更能吸引TA",
              style: TextStyle(
                  color: R.color_font_1,
                  fontSize: sp(Sp.font_bigger),
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                "为什么要填写两真一假？",
                style:
                    TextStyle(color: R.color_font_1, fontSize: sp(Sp.font_big)),
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
                style:
                    TextStyle(color: R.color_font_1, fontSize: sp(Sp.font_big)),
              ),
            ),
            //_buildGridViewItem
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Expanded(
                child: Container(
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    //增加
                    shrinkWrap: true,
                    //增加
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        //横轴三个子widget
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 12.0,
                        mainAxisExtent: 230.0,
                        childAspectRatio: 0.5 //宽高比为1时，子widget
                        ),
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
      padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            toString2(data.title),
            style: TextStyle(
                color: R.color_font_1,
                fontSize: sp(Sp.font_big),
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Column(children: _getChildrenAsList(data.subData)),
          )
        ],
      ),
    );
  }

  List<Widget> _getChildrenAsList(List<String>? descriptionList) {
    var list = <Widget>[];
    descriptionList?.forEach((element) {
      list.add(Padding(
        padding: const EdgeInsets.only(top: 16.0),
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
    });
    return list;
  }
}
