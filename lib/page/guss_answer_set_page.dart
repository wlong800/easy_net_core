import 'dart:convert';

import 'package:app/base/api/net/HttpStatus2.dart';
import 'package:app/base/common/channel_tools.dart';
import 'package:app/base/common/lang.dart';
import 'package:app/base/common/logger.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/common/touch_callback.dart';
import 'package:app/base/widget/base_button.dart';
import 'package:app/base/widget/common_ui_kit.dart';
import 'package:app/base/widget/dialog/base_dialog.dart';
import 'package:app/provider/services/app/app_service.dart';
import 'package:app/provider/services/service_locator.dart';
import 'package:flutter/material.dart';

import 'guss_example_page.dart';

class UserTTALSetPage extends StatefulWidget {
  const UserTTALSetPage({Key? key}) : super(key: key);

  @override
  _UserTTALSetPageState createState() => _UserTTALSetPageState();
}

class _UserTTALSetPageState extends State<UserTTALSetPage> {
  TextEditingController? _real1Controller;
  TextEditingController? _real2Controller;
  TextEditingController? _fakeController;

  AppService appService = serviceLocator<AppService>();

  @override
  void initState() {
    super.initState();
    _real1Controller = TextEditingController();
    _real2Controller = TextEditingController();
    _fakeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    initScreenUtil(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: WMPreferredSize(""),
      body: Container(
        padding: EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
        color: R.color_white,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView(
              children: [
                Text(
                  "请填写你的两真一假",
                  style: TextStyle(
                      color: R.color_font_1,
                      fontSize: sp(Sp.font_bigger),
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    "填写2件真实+1件虚假的事情来描述你自己，看看谁最懂你~",
                    style: TextStyle(
                        color: R.color_font_2, fontSize: sp(Sp.font_middle2)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: _buildGussItem(_real1Controller, "我是单身", true),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: _buildGussItem(_real2Controller, "我能吃", true),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: _buildGussItem(_fakeController, "我能玩", false),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: TouchCallBack(
                      child: Text(
                        "看看他们怎么写 >",
                        style: TextStyle(
                            color: R.color_1, fontSize: sp(Sp.font_middle2)),
                      ),
                      onPressed: () {
                        push(context, GussExamplePage());
                      }),
                ),
                Container(
                  height: 360.0,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: MyRaisedButton(
                "完成",
                () async {
                  showDialogLoadingKt(context);
                  var params = {
                    "type": "TTAL",
                    "ttalQuestion": {
                      "lieOption": _fakeController?.text,
                      "truthOption1": _real1Controller?.text,
                      "truthOption2": _real2Controller?.text,
                    }
                  };
                  if (isEmpty(params['contactAddr']))
                    params.remove("contactAddr");
                  if (isEmpty(params['contactEmail']))
                    params.remove("contactEmail");
                  if (isEmpty(params['contactIdNo']))
                    params.remove("contactIdNo");
                  var response =
                      await appService.updateUserTTALData(params: params);
                  pop(context);
                  if (response?.code == HttpStatus2.ok) {
                    Channel.updateUserTTALData(jsonEncode(params));
                    Future.delayed(Duration(milliseconds: 300), () {
                      pop(context, system: true);
                    });
                  } else {
                    logger("error msg : ${response?.msg}");
                  }
                },
                enableClick: enableClick(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGussItem(
      TextEditingController? controller, String hint, bool real) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          real ? "真实" : "虚假",
          style: TextStyle(color: R.color_font_1, fontSize: sp(Sp.font_15)),
        ),
        Container(
          margin: const EdgeInsets.only(top: 12.0),
          decoration:
              MyBoxDecoration.all(radius: 4.0, color: R.color_background),
          child: TextFormField2(
            controller: controller,
            inputDecoration: MyOutlineInputDecoration(hintText: hint).build(),
          ),
        ),
      ],
    );
  }

  bool enableClick() {
    return isNotEmpty(_real1Controller?.text) &&
        isNotEmpty(_real2Controller?.text) &&
        isNotEmpty(_fakeController?.text);
  }
}
