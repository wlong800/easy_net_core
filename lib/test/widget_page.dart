import 'dart:collection';

import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/logger/logger.dart';
import 'package:app/base/widget/common_ui_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WidgetTestPage extends StatefulWidget {
  const WidgetTestPage({Key? key}) : super(key: key);

  @override
  _WidgetTestPageState createState() => _WidgetTestPageState();
}

class _WidgetTestPageState extends State<WidgetTestPage> {
  bool _switchSelected = true; //维护单选开关状态
  bool _checkboxSelected = true; //维护复选框状态
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: DefaultTextStyle(
          style: TextStyle(color: Colors.red),
          child: Container(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("text"),
                      DefaultTextStyle(
                        style: TextStyle(
                            color: R.color_font_1,
                            fontSize: sp(Sp.font_middle2)),
                        child: Column(
                          children: [
                            Text(
                              "DefaultTextStyle",
                              style: TextStyle(fontSize: sp(Sp.font_bigger)),
                            ),
                            Text("DefaultTextStyle"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Container(
                    child: Column(
                      children: [
                        Text("button"),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 24.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                padding: ButtonStyleButton.allOrNull<
                                    EdgeInsetsGeometry>(EdgeInsets.zero),
                                backgroundColor:
                                    ButtonStyleButton.allOrNull<Color>(
                                        Colors.black)),
                            child: Container(
                                alignment: Alignment.center,
                                child: Text("ElevatedButton")),
                            onPressed: () {},
                          ),
                        ),
                        OutlinedButton(
                          child: Text("OutlinedButton"),
                          onPressed: () {},
                        ),
                        TextButton(
                          child: Text("TextButton"),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.thumb_up),
                          onPressed: () {},
                        ),
                        ElevatedButton.icon(
                          icon: Icon(Icons.send),
                          label: Text("发送"),
                          onPressed: () {
                            pop(context);
                          },
                        ),
                        OutlinedButton.icon(
                          icon: Icon(Icons.add),
                          label: Text("添加"),
                          onPressed: () {},
                        ),
                        TextButton.icon(
                          icon: Icon(Icons.info),
                          label: Text("详情"),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Column(
                    children: [
                      Text("image"),
                      Text(""),
                      Container(
                        width: 100.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          child: CachedNetworkImage(
                            fadeOutCurve: Curves.linear,
                            fadeInCurve: Curves.linear,
                            fadeInDuration: Duration(milliseconds: 0),
                            fadeOutDuration: Duration(milliseconds: 0),
                            placeholder: (context, _) => Image.asset(
                                "images/bg_default.png",
                                fit: BoxFit.cover),
                            imageUrl:
                                "https://img.allhistory.com/60964b005c66234b0d367c2a.png",
                            errorWidget: (context, _, error) => Image.asset(
                                "images/bg_default.png",
                                fit: BoxFit.cover),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AvatarKit(
                          avatar:
                              "https://img.allhistory.com/60964b005c66234b0d367c2a.png",
                          width: 60.0,
                          height: 60.0,
                          radius: 30.0,
                          borderWidth: 0.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AvatarKit(
                          avatar:
                              "https://img.allhistory.com/60964b005c66234b0d367c2a.png",
                          width: 60.0,
                          height: 60.0,
                          radius: 30.0,
                          radius2: 30.0,
                          borderWidth: 3.0,
                          borderColor: R.color_1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Column(
                    children: <Widget>[
                      Text("checkbox"),
                      Switch(
                        value: _switchSelected, //当前状态
                        onChanged: (value) {
                          //重新构建页面
                          setState(() {
                            _switchSelected = value;
                          });
                        },
                      ),
                      Checkbox(
                        value: _checkboxSelected,
                        activeColor: Colors.red, //选中时的颜色
                        onChanged: (value) {
                          setState(() {
                            _checkboxSelected = value ?? false;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
