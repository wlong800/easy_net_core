import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:flutter/material.dart';

showDialogLoadingKt(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LoadingDialog();
      });
}

/// dialog
class LoadingDialog extends Dialog {
  final String? text;
  final bool showText;

  LoadingDialog({Key? key, this.text, this.showText = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        //保证控件居中效果
        child: SizedBox(
          width: 100.0,
          height: 100.0,
          child: Container(
            decoration: ShapeDecoration(
              color: R.color_3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "images/icon_profile_edit.png",
                  width: 58.0,
                ),
                isEmpty(text) || !showText
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: Text(
                          text!,
                          style: TextStyle(fontSize: 12.0),
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
