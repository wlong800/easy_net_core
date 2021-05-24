import 'package:app/base/common/resource.dart';
import 'package:app/base/widget/base_button.dart';
import 'package:app/base/widget/common_ui_kit.dart';
import 'package:flutter/material.dart';

import 'models/contacts_model.dart';

class CustomContactsAddPage extends StatefulWidget {
  final ContactsModel? model;

  const CustomContactsAddPage({Key? key, this.model}) : super(key: key);

  @override
  _CustomContactsAddPageState createState() => _CustomContactsAddPageState();
}

class _CustomContactsAddPageState extends State<CustomContactsAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WMPreferredSize("添加使用人"),
      body: Container(
        child: Column(
          children: [
            Container(
              decoration:
                  MyBoxDecoration.all(radius: 12.0, color: R.color_white),
              child: Text("xxx"),
            ),
            Container(
              padding: EdgeInsets.only(top: 32.0),
              child: MyRaisedButton(
                "保存",
                () async {
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
