import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/common/touch_callback.dart';
import 'package:app/page/custom_contacts_add_page.dart';
import 'package:app/page/models/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

class CustomContactsCell extends StatelessWidget {
  final ContactsModel model;

  const CustomContactsCell({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: MyBoxDecoration.all(radius: 12.0, color: R.color_white),
      padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 16.0),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                toString2(model.contactName),
                style: TextStyle(
                    color: R.color_font_1,
                    fontSize: sp(Sp.font_17),
                    fontWeight: FontWeight.bold),
              ),
              Offstage(
                offstage: isNotEmpty(model.contactIdNo),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    "身份证 ${toString2(model.contactIdNo)}",
                    style: TextStyle(
                        color: R.color_font_2, fontSize: sp(Sp.font_middle)),
                  ),
                ),
              ),
              Offstage(
                offstage: isNotEmpty(model.contactMobile),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    "手机号 ${toString2(model.contactMobile)}",
                    style: TextStyle(
                        color: R.color_font_2, fontSize: sp(Sp.font_middle)),
                  ),
                ),
              ),
            ],
          ),
          TouchCallBack(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                "icon_profile_edit.png",
                width: 18.0,
              ),
            ),
            onPressed: () {
              push(context, CustomContactsAddPage());
            },
          ),
        ],
      ),
    );
  }
}
