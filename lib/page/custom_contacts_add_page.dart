import 'dart:convert';

import 'package:app/base/api/net/http_status2.dart';
import 'package:app/base/common/channel_tools.dart';
import 'package:app/base/common/lang.dart';
import 'package:app/base/common/logger.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/widget/base_button.dart';
import 'package:app/base/widget/common_ui_kit.dart';
import 'package:app/base/widget/dialog/base_dialog.dart';
import 'package:app/services/app/app_service.dart';
import 'package:app/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/contacts_model.dart';

class CustomContactsAddPage extends StatefulWidget {
  final ContactsModel? model;
  final Function? func;
  final bool isSystemPop;

  const CustomContactsAddPage(
      {Key? key, this.model, this.func, this.isSystemPop = false})
      : super(key: key);

  @override
  _CustomContactsAddPageState createState() => _CustomContactsAddPageState();
}

class _CustomContactsAddPageState extends State<CustomContactsAddPage> {
  TextEditingController? _userNameController;
  TextEditingController? _cardController;
  TextEditingController? _phoneController;
  TextEditingController? _emailController;
  TextEditingController? _addressController;
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
    _userNameController?.addListener(() {
      _enableClick();
      setState(() {});
    });
    _phoneController?.addListener(() {
      _enableClick();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    initScreenUtil(context);
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
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
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
                              padding: const EdgeInsets.only(top: 0.0),
                              child: TextFormField2(
                                hintText: "请输入姓名",
                                controller: _userNameController,
                                inputType: TextInputType.text,
                                inputFormatter: [
                                  LengthLimitingTextInputFormatter(15)
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "身份证",
                                  style: TextStyle(
                                      color: R.color_font_3,
                                      fontSize: sp(Sp.font_middle2)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: TextFormField2(
                                  hintText: "请填写身份证号",
                                  inputType: TextInputType.text,
                                  inputFormatter: [
                                    LengthLimitingTextInputFormatter(18)
                                  ],
                                  controller: _cardController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "手机号",
                                  style: TextStyle(
                                      color: R.color_font_3,
                                      fontSize: sp(Sp.font_middle2)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: TextFormField2(
                                  hintText: "请填写该使用人的手机号",
                                  inputType: TextInputType.phone,
                                  inputFormatter: [
                                    LengthLimitingTextInputFormatter(11),
                                    FilteringTextInputFormatter.allow(
                                        numberRegExp())
                                  ],
                                  controller: _phoneController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "邮箱",
                                  style: TextStyle(
                                      color: R.color_font_3,
                                      fontSize: sp(Sp.font_middle2)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: TextFormField2(
                                  hintText: "请输入邮箱",
                                  inputType: TextInputType.text,
                                  controller: _emailController,
                                  inputFormatter: [
                                    FilteringTextInputFormatter.allow(
                                        emailRegExp()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "地址",
                                  style: TextStyle(
                                      color: R.color_font_3,
                                      fontSize: sp(Sp.font_middle2)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: TextFormField2(
                                  hintText: "请输入地址",
                                  inputType: TextInputType.text,
                                  controller: _addressController,
                                  inputFormatter: [
                                    LengthLimitingTextInputFormatter(50),
                                  ],
                                ),
                              ),
                            ],
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
                  if (toInt(_phoneController?.text.length) < 11) {
                    Channel.showNativeToast(msg: "手机号位数不对");
                    return;
                  }
                  if (isNotEmpty(_cardController?.text) &&
                      toInt(_cardController?.text.length) != 15 &&
                      toInt(_cardController?.text.length) != 18) {
                    Channel.showNativeToast(msg: "身份证号码不对");
                    return;
                  }
                  showDialogLoadingKt(context);
                  var params = {
                    "contactMobile": _phoneController?.text,
                    "contactEmail": _emailController?.text,
                    "contactAddr": _addressController?.text,
                    "contactName": _userNameController?.text,
                    "contactIdNo": _cardController?.text,
                    "id": toInt(widget.model?.id, defaultValue: 0)
                  };
                  if (isEmpty(params['contactAddr'])) params.remove("contactAddr");
                  if (isEmpty(params['contactEmail'])) params.remove("contactEmail");
                  if (isEmpty(params['contactIdNo'])) params.remove("contactIdNo");
                  if (isEmpty(params['contactMobile'])) params.remove("contactMobile");
                  if (isEmpty(params['contactName'])) params.remove("contactName");
                  if (toInt(params["id"]) <= 0) params.remove("id");
                  var response =
                      await appService.updateContactsData(params: params);
                  pop(context);
                  if (response?.code == HttpStatus2.ok) {
                    widget.func?.call();
                    params["id"] = toInt(response?.data);
                    Channel.addContactsData(jsonEncode(params));
                    Future.delayed(Duration(milliseconds: 300), () {
                      pop(context, system: widget.isSystemPop);
                    });
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
    return isNotEmpty(_userNameController?.text) &&
        isNotEmpty(_phoneController?.text) &&
        phoneRegExp().hasMatch(toString2(_phoneController?.text));
  }
}
