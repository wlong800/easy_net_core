import 'package:app/base/common/resource.dart';
import 'package:app/base/widget/common_ui_kit.dart';
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
    ComplaintOption(option: "私信")];
  @override
  Widget build(BuildContext context) {
    initScreenUtil(context);
    return Scaffold(
      appBar: WMPreferredSize("举报"),
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ComplaintOptionCell(
              key: ValueKey(_options[index]),
              option:_options[index]);
        },
        itemCount:_options.length
      ),

    );
  }

}