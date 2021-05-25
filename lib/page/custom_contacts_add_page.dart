import 'package:app/base/api/net/HttpStatus2.dart';
import 'package:app/base/common/lang.dart';
import 'package:app/base/common/logger.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/widget/base_button.dart';
import 'package:app/base/widget/common_ui_kit.dart';
import 'package:app/base/widget/dialog/base_dialog.dart';
import 'package:app/provider/services/app/app_service.dart';
import 'package:app/provider/services/service_locator.dart';
import 'package:flutter/material.dart';

import 'models/contacts_model.dart';

class CustomContactsAddPage extends StatefulWidget {
  final ContactsModel? model;
  final Function? func;

  const CustomContactsAddPage({Key? key, this.model, this.func})
      : super(key: key);

  @override
  _CustomContactsAddPageState createState() => _CustomContactsAddPageState();
}

class _CustomContactsAddPageState extends State<CustomContactsAddPage> {
  late TextEditingController _userNameController;
  late TextEditingController _cardController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  AppService appService = serviceLocator<AppService>();

  @override
  void initState() {
    super.initState();
    _userNameController =
        TextEditingController(text: widget.model?.contactName);
    _cardController = TextEditingController(text: widget.model?.contactIdNo);
    _phoneController = TextEditingController(text: widget.model?.contactMobile);
    _emailController = TextEditingController(text: widget.model?.contactEmail);
    _addressController = TextEditingController(text: widget.model?.contactAddr);
    _userNameController.addListener(() {
      _enableClick();
      setState(() {});
    });
    _phoneController.addListener(() {
      _enableClick();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: WMPreferredSize("添加使用人"),
      body: Container(
        padding: EdgeInsets.only(top: 12.0, left: 16.0, right: 16.0),
        child: Column(
          children: [
            Container(
              decoration:
                  MyBoxDecoration.all(radius: 12.0, color: R.color_white),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "姓名",
                            style: TextStyle(
                                color: R.color_font_3,
                                fontSize: sp(Sp.font_middle2)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextFormField2(
                            hintText: "请输入姓名",
                            controller: _userNameController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextFormField2(
                            hintText: "请填写身份证号",
                            controller: _cardController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextFormField2(
                            hintText: "请填写该使用人的手机号",
                            controller: _phoneController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextFormField2(
                            hintText: "请输入邮箱",
                            controller: _emailController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextFormField2(
                            hintText: "请输入地址",
                            controller: _addressController,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 50.0),
              child: MyRaisedButton(
                "保存",
                () async {
                  showDialogLoadingKt(context);
                  var response = await appService.updateContactsData(params: {
                    "contactAddr": _addressController.text,
                    "contactEmail": _emailController.text,
                    "contactIdNo": _cardController.text,
                    "contactMobile": _phoneController.text,
                    "contactName": _userNameController.text,
                    "id": toInt(widget.model?.id, defaultValue: 0)
                  });
                  pop(context);
                  if (response?.code == HttpStatus2.ok) {
                    pop(context);
                    widget.func?.call();
                  } else {
                    logger("error msg : ${response?.msg}");
                  }
                },
                enableClick: _enableClick(),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _enableClick() {
    return isNotEmpty(_userNameController.text) &&
        isNotEmpty(_phoneController.text);
  }
}
