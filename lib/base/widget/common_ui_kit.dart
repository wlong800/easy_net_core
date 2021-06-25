import 'dart:io';
import 'package:app/base/common/channel_tools.dart';
import 'package:app/base/common/common_callback.dart';
import 'package:app/base/common/lang.dart';
import 'package:app/base/common/logger.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/common/touch_callback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../main.dart';

/// 公共控件前期全部放到这，后期随着页面增多，抽离

/// 标题栏
class WMPreferredSize extends PreferredSize {
  final String title;
  final bool leading;
  final bool isSystemPop;
  final VoidCallback? callback;
  final VoidCallback? leadingCallback;
  final String? rightText;
  final Widget? rightWidget;
  final Color bgColor;
  final Color titleColor;
  final double titleSize;
  final bool titleBold;
  final Widget? titleWidget;
  final Widget? leadingWidget;
  final double elevation;
  final double height;
  final Brightness brightness;

  WMPreferredSize(this.title,
      {this.leading = true,
      this.isSystemPop = false,
      this.callback,
      this.rightText,
      this.rightWidget,
      this.bgColor = Colors.white,
      this.titleColor = R.color_font_1,
      this.titleBold = false,
      this.titleWidget,
      this.leadingWidget,
      this.height = Size2.app_bar_height,
      this.leadingCallback,
      this.elevation = 0.0,
      this.titleSize = Sp.font_17,
      this.brightness = Brightness.light})
      : super(child: Container(), preferredSize: Size.fromHeight(height));

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      title: _buildTitleWidget(),
      centerTitle: true,
      elevation: this.elevation,
      brightness: brightness,
      leading: _buildLeadingButton(context),
      actions: getActions(),
      shadowColor: R.color_2,
    );
  }

  Widget? _buildTitleWidget() {
    if (titleWidget != null) return titleWidget;
    return Text(
      title,
      style: TextStyle(
          fontSize: sp(titleSize),
          color: titleColor,
          fontWeight: titleBold ? FontWeight.bold : FontWeight.normal),
    );
  }

  List<Widget>? getActions() {
    Widget widget = rightText == null
        ? Container()
        : TouchCallBack(
            child: Container(
              padding: EdgeInsets.only(right: 10.0),
              alignment: Alignment.center,
              child: Text(
                rightText!,
                style:
                    TextStyle(color: R.color_2, fontSize: sp(Sp.font_middle2)),
              ),
            ),
            onPressed: () {
              callback?.call();
            });

    return <Widget>[
      rightWidget != null ? rightWidget! : widget,
    ];
  }

  Widget? _buildLeadingButton(BuildContext context) {
    if (!leading) return null;
    if (leadingWidget != null) {
      return TouchCallBack(
        child: leadingWidget,
        onPressed: () {
          if (leadingCallback != null) {
            leadingCallback!();
            return;
          }
          pop(context, system: isSystemPop);
        },
      );
    }
    return IconButton(
      padding: EdgeInsets.all(14.0),
      icon: Image.asset(
        "images/icon_back_black.webp",
        height: 18.0,
      ),
      onPressed: () async {
        if (leadingCallback != null) {
          leadingCallback?.call();
          return;
        }
        if (isSystemPop) {
          systemPop();
        } else {
          try {
            if ((navigatorState.currentState?.canPop()) == false) {
              systemPop();
              return;
            }
          } catch (e) {
            print(e);
          }
          Navigator.pop(context);
        }
      },
    );
  }
}

Widget buildRightButton({required String imageName}) {
  return Container(
    padding: EdgeInsets.all(16.0),
    child: Image.asset(imageName, width: 24.0),
  );
}

class EmptyWidget extends StatelessWidget {
  final Color bgColor;
  final Color textColor;
  final String text;
  final String image;
  final double paddingTop;
  final bool showAppBar;

  const EmptyWidget(
      {Key? key,
      this.bgColor = Colors.white,
      this.textColor = R.color_1,
      this.text = String2.error,
      this.image = "images/icon_nothing.png",
      this.paddingTop = 89.0,
      this.showAppBar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (showAppBar) {
      return Scaffold(
        appBar: WMPreferredSize(""),
        body: _buildContainer(),
      );
    } else {
      return _buildContainer();
    }
  }

  Container _buildContainer() {
    return Container(
        color: bgColor,
        alignment: Alignment.bottomCenter,
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                height: showAppBar
                    ? (paddingTop - Size2.app_bar_height)
                    : paddingTop,
              ),
              Image.asset(
                image,
                width: 119.0,
                height: 113.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 29.0, left: 24.0, right: 24.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: textColor.withOpacity(0.6),
                      fontSize: sp(Sp.font_big)),
                ),
              ),
            ],
          ),
        ));
  }
}

class Error2Widget extends StatelessWidget {
  final Color bgColor;
  final Color textColor;
  final String text;
  final String btnText;
  final String image;
  final Function? func;

  const Error2Widget({
    Key? key,
    this.func,
    this.bgColor = R.color_background,
    this.textColor = R.color_font_1,
    this.text = "哎呀怎么没网了",
    this.image = "images/icon_no_wifi.png",
    this.btnText = "刷新",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 150.0),
      child: Column(
        children: <Widget>[
          Image.asset(
            image,
            width: 200.0,
            height: 160.0,
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Text(
              text,
              strutStyle: StrutStyle(forceStrutHeight: true, height: 1.5),
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor, fontSize: sp(Sp.font_big)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 24.0, right: 24.0),
            child: TouchCallBack(
              child: Container(
                height: 45.0,
                width: 200.0,
                alignment: Alignment.center,
                decoration: MyBoxDecoration.all(
                    radius: 23.0,
                    color: R.color_background,
                    borderColor: R.color_divider_1,
                    borderWidth: 0.5),
                child: Text(
                  btnText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: R.color_font_1, fontSize: sp(Sp.font_big)),
                ),
              ),
              onPressed: () {
                func?.call();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomLoadingMoreKit extends StatelessWidget {
  final Color color;
  final VoidCallback? onLoadMoreErrorCallback;

  const CustomLoadingMoreKit(
      {Key? key, this.color = R.color_2, this.onLoadMoreErrorCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = _buildLoadWidget("Loading", showLoading: true);
        } else if (mode == LoadStatus.loading) {
          body = _buildLoadWidget("Loading", showLoading: true);
        } else if (mode == LoadStatus.failed) {
          return _buildLoadWidget("Network error, Tap to refresh");
        } else if (mode == LoadStatus.canLoading) {
          body = Container();
        } else if (mode == LoadStatus.noMore) {
          return _buildLoadWidget("- That's my bottom line -");
        } else {
          body = _buildLoadWidget("Loading", showLoading: true);
        }
        return Container(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }

  Widget _buildLoadWidget(String text, {bool showLoading = false}) {
    if (showLoading) {
      return Container(
          color: color,
          height: 46.0,
          child: Center(
            child: Image.asset(
              'images/loading_bottom.webp',
              width: 26.0,
            ),
          ));
    }
    return TouchCallBack(
      child: Container(
          color: color,
          height: 46.0,
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: R.color_2, fontSize: sp(Sp.font_middle)),
            ),
          )),
      onPressed: () {
        if (onLoadMoreErrorCallback != null) onLoadMoreErrorCallback!();
      },
    );
  }
}

class LoadingMoreKit extends StatelessWidget {
  static const int STATE_LOADING = 0;
  static const int STATE_COMPLETE = 1;
  static const int STATE_NO_DATA = 2;
  static const int STATE_ERROR = 3;

  final int? state;
  final Color color;

  const LoadingMoreKit({Key? key, this.state, this.color = R.color_2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state == STATE_NO_DATA) {
      return _buildLoadWidget("- That's my bottom line -");
    } else if (state == STATE_LOADING) {
      return _buildLoadWidget("Loading...", showLoading: true);
    } else if (state == STATE_ERROR) {
      return _buildLoadWidget("Load Error");
    } else {
      return _buildLoadWidget("Loading...", showLoading: true);
    }
  }

  Widget _buildLoadWidget(String text, {bool showLoading = false}) {
    if (showLoading) {
      return Container(
          color: color,
          height: 46.0,
          child: Center(
            child: Image.asset(
              'images/loading_bottom.webp',
              width: 26.0,
            ),
          ));
    }
    return Container(
        color: color,
        height: 46.0,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: R.color_2, fontSize: sp(Sp.font_middle)),
          ),
        ));
  }
}

class AvatarKit extends StatelessWidget {
  final String? avatar;
  final double width, height;
  final double radius;
  final double radius2;
  final bool shadow;
  final double borderWidth;

  const AvatarKit(
      {Key? key,
      this.avatar,
      this.width = 68.0,
      this.height = 68.0,
      this.radius = 12.0,
      this.radius2 = 14.0,
      this.shadow = true,
      this.borderWidth = 3.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: !shadow
          ? null
          : BoxDecoration(
              border: Border.all(color: R.color_3, width: borderWidth),
              boxShadow: MyBoxShadow.all(),
              borderRadius: BorderRadius.circular(radius2),
            ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: buildAvatar(),
      ),
    );
  }

  Widget buildAvatar() {
    if (toString2(avatar).startsWith("http") || isEmpty(avatar)) {
      if (isEmpty(avatar)) {
        return Image.asset(
          "images/icon_photo_auto.png",
          width: width,
          fit: BoxFit.cover,
        );
      }
      return FadeInImage.assetNetwork(
        placeholder: "images/icon_photo_auto.png",
        image: avatar ?? "",
        fit: BoxFit.cover,
      );
    }
    return Image.file(
      File(avatar!),
      fit: BoxFit.cover,
    );
  }
}

/// loading页
class LoadingKit extends StatelessWidget {
  final Color bgColor;

  const LoadingKit({Key? key, this.bgColor = R.color_background})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                    "images/icon_dialog_loading.webp",
                    width: 32.0,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 12.0),
                  //   child: Text(
                  //     "加载中...",
                  //     style: TextStyle(
                  //       color: R.color_font_1,
                  //       fontSize: sp(Sp.font_big),
                  //     ),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyOutlineInputDecoration {
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final String? hintText;
  final double? hintTextSize;

  MyOutlineInputDecoration(
      {this.enabledBorderColor = R.color_background,
      this.focusedBorderColor = R.color_background,
      this.hintText,
      this.hintTextSize = Sp.font_big});

  InputDecoration build() {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: enabledBorderColor!, width: 0.5)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: enabledBorderColor!, width: 0.5)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor!, width: 0.5)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: enabledBorderColor!, width: 0.5)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor!, width: 0.5)),
      hintText: hintText,
      hintStyle: TextStyle(color: R.color_font_4, fontSize: sp(hintTextSize!)),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
    );
  }
}

class TextFormField2 extends StatelessWidget {
  final String? hintText;
  final double hintTextSize;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final bool enabled;
  final bool autoFocus;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatter;
  final Callback? onSaved;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final double radius;
  final InputDecoration? inputDecoration;
  final Callback? onFieldSubmitted;

  const TextFormField2(
      {Key? key,
      this.hintText,
      this.controller,
      this.focusNode,
      this.suffixIcon,
      this.validator,
      this.obscureText = false,
      this.enabled = true,
      this.onSaved,
      this.inputType,
      this.inputFormatter,
      this.hintTextSize = Sp.font_big,
      this.enabledBorderColor = R.color_text_field_border,
      this.focusedBorderColor = R.color_1,
      this.onFieldSubmitted,
      this.autoFocus = false,
      this.radius = 8.0,
      this.inputDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 48,
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        //验证用户名
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        enabled: enabled,
        autofocus: autoFocus,
        inputFormatters: inputFormatter,
        keyboardType: inputType,
        cursorColor: R.color_1,
        style: TextStyle(color: R.color_font_1, fontSize: sp(Sp.font_big)),
        decoration: inputDecoration != null
            ? inputDecoration
            : InputDecoration(
                border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: enabledBorderColor, width: 0.5)),
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: enabledBorderColor, width: 0.5)),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: focusedBorderColor, width: 0.5)),
                errorBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: enabledBorderColor, width: 0.5)),
                focusedErrorBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: focusedBorderColor, width: 0.5)),
                hintText: hintText,
                hintStyle: TextStyle(
                    color: R.color_font_4, fontSize: sp(hintTextSize)),
                //尾部添加清除按钮
                suffixIcon: suffixIcon,
              ),
        obscureText: obscureText,
        onFieldSubmitted: (value) {
          if (isEmpty(value)) return;
          onFieldSubmitted!(value);
        },
        //保存数据
        onSaved: (String? value) {
          onSaved!(value);
        },
      ),
    );
  }
}
