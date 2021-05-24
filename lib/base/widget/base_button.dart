import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:flutter/material.dart';

class MyRaisedButton extends StatelessWidget {
  final String text;
  final bool enableClick;
  final VoidCallback callback;
  final Color textColor;
  final Color disabledTextColor;
  final Color enableColor;
  final Color disabledColor;
  final String? imageName;
  final double height;
  final double radius;

  MyRaisedButton(this.text, this.callback,
      {this.enableClick = false,
      this.textColor = R.color_white,
      this.disabledTextColor = R.color_white,
      this.enableColor = R.color_1,
      this.disabledColor = R.color_1_60,
      this.imageName,
      this.height = 45.0,
      this.radius = 23.0});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: height,
            child: RaisedButton(
              textColor: textColor,
              disabledColor: disabledColor,
              disabledTextColor: disabledTextColor,
              color: enableColor,
              elevation: 0.0,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    isEmpty(imageName)
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Image.asset(
                              imageName!,
                              width: 18.0,
                              height: 15.0,
                            ),
                          ),
                    Text(text),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius)),
              onPressed: enableClick
                  ? () {
                      callback();
                    }
                  : null,
            ),
          ),
        )
      ],
    );
  }
}
