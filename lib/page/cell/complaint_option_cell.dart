import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/page/models/complaint_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ComplaintOptionCell extends StatelessWidget {
  final ComplaintOption option;

  const ComplaintOptionCell({Key? key, required this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          decoration: MyBoxDecoration.bottomDecoration(
              color: R.color_divider_1, width: 0.5),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                toString2(option.option),
                style:
                    TextStyle(color: R.color_font_1, fontSize: sp(Sp.font_big)),
              )),
              Offstage(
                offstage: !option.checked,
                child: Image.asset(
                  "images/icon_message_icon_location_checked.png",
                  width: 22.0,
                ),
              )
            ],
          )),
    );
  }
}
