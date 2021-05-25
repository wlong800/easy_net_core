import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/page/models/contacts_model.dart';
import 'package:flutter/material.dart';

class CustomContactsCell extends StatelessWidget {
  final ContactsModel model;

  const CustomContactsCell({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: MyBoxDecoration.all(radius: 12.0, color: R.color_white),
      padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 16.0),
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  toString2(model.contactName),
                  style: TextStyle(
                      color: R.color_font_1,
                      fontSize: sp(Sp.font_17),
                      fontWeight: FontWeight.bold),
                ),
                Offstage(
                  offstage: isEmpty(model.contactIdNo),
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
                  offstage: isEmpty(model.contactMobile),
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
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              "images/icon_profile_edit.png",
              width: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
