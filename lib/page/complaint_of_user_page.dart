import 'package:app/tools/channel_tools.dart';
import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/common/touch_callback.dart';
import 'package:app/base/widget/common_ui_kit.dart';
import 'package:app/base/widget/dialog/base_dialog.dart';
import 'package:app/page/cell/complaint_option_cell.dart';
import 'package:flutter/material.dart';

import 'models/complaint_option.dart';

class ComplaintOfUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ComplaintSelectState();
  }
}

class ComplaintSelectState extends State<ComplaintOfUserPage> {
  var _options = [
    ComplaintOption(option: "头像图片"),
    ComplaintOption(option: "昵称"),
    ComplaintOption(option: "个性签名"),
    ComplaintOption(option: "个人信息"),
    ComplaintOption(option: "私信")
  ];

  @override
  Widget build(BuildContext context) {
    initScreenUtil(context);
    return Scaffold(
      appBar: WMPreferredSize("举报"),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return TouchCallBack(
                    child: ComplaintOptionCell(
                        key: ValueKey(_options[index]),
                        option: _options[index]),
                    onPressed: () {
                      _options[index].checked = !_options[index].checked;
                      setState(() {});
                    },
                  );
                },
                itemCount: _options.length),
          ),
          Container(
            padding: EdgeInsets.only(
                top: 10.0, left: 16.0, right: 16.0, bottom: 35.0),
            child: TouchCallBack(
              child: Container(
                height: 45.0,
                alignment: Alignment.center,
                child: Text(
                  "举报",
                  style:
                      TextStyle(color: Colors.white, fontSize: sp(Sp.font_big)),
                ),
                decoration: MyBoxDecoration.all(radius: 23.0, color: R.color_1),
              ),
              onPressed: () {
                var canReport = false;
                _options.forEach((element) {
                  if (element.checked) canReport = true;
                });
                if (!canReport) {
                  Channel.showNativeToast(msg: "请选择举报内容");
                  return;
                }
                showDialogLoadingKt(context);
                Future.delayed(Duration(seconds: 1), () {
                  Channel.showNativeToast(msg: "举报成功");
                  pop(context, system: true);
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
