/// 资源文件类
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'lang.dart';

/// 颜色
class R {
  /// 主色
  static const Color color_1 = Color(0xffFF2773);
  static const Color color_1_60 = Color(0xff3dFF2773);
  static const Color color_2 = Color(0xffFFDA3F);
  static const Color color_3 = Color(0xffffffff);
  static const Color color_4 = Color(0xff000000);
  static const Color color_5 = Color(0xffF4AC22);

  static const Color color_font_1 = Color(0xff333333);
  static const Color color_font_2 = Color(0xff999999);
  static const Color color_font_3 = Color(0xff666666);
  static const Color color_font_4 = Color(0xffcccccc);

  static const Color color_d8d8d8 = Color(0xffD8D8D8);

  static const Color color_divider_1 = Color(0xffE0E0E0);

  static const Color color_white = Color(0xffffffff);

  static const Color color_background = Color(0xfff7f7f7);

  static const Color color_text_field_border = Color(0xffEDEDED);
}

/// 字体大写
class Sp {
  static const double font_small = 12.0;

  static const double font_middle = 13.0;

  static const double font_middle2 = 14.0;

  static const double font_big = 16.0;

  static const double font_bigger = 20.0;

  static const double font_large = 24.0;

  static const double font_17 = 17.0;
  static const double font_15 = 17.0;
}

/// 图标大写 & 宽度 & 高度
class Size2 {
  static const double app_bar_height = 50.0;

  static const double screen_w = 375.0;

  static const double screen_h = 667.0;

  static const double elevation = 0.5;

  static const double divider = 0.5;
}

class String2 {
  static const String success = "success";
  static const String error = "error";
}

class ImageString {
  static const String defaultImage = 'images/bg_default.png';
}

double sp(double size) {
  return ScreenUtil().lumSetSp(size, allowFontScalingSelf: false);
}

extension ScreenUtilExtend on ScreenUtil {
  double lumSetSp(num fontSize, {bool? allowFontScalingSelf}) =>
      allowFontScalingSelf == null
          ? ((fontSize * scaleText) / textScaleFactor)
          : allowFontScalingSelf
              ? (fontSize * scaleText)
              : ((fontSize * scaleText) / textScaleFactor);
}

bool isPad(context) {
  return MediaQuery.of(context).size.width > 500;
}

initScreenUtil(BuildContext context, {bool portrait = true}) {
  ScreenUtil.init(
    BoxConstraints(maxWidth: getScreenWidth(), maxHeight: getScreenHeight()),
    designSize: isPad(context)
        ? Size(768, 1024)
        : Size(portrait ? Size2.screen_w : Size2.screen_h,
            portrait ? Size2.screen_h : Size2.screen_w),
  );
}

class MyBoxShadow {
  static all() {
    return [
      BoxShadow(
        color: R.color_2.withOpacity(0.08),
        blurRadius: 18.0,
      ),
    ];
  }
}

class MyBoxDecoration {
  static BoxDecoration all(
      {double radius = 6.0,
      Color color = R.color_2,
      Color? borderColor,
      double borderWidth = 1.0}) {
    return BoxDecoration(
        border: isEmpty(borderColor)
            ? null
            : Border.all(color: borderColor!, width: borderWidth),
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(radius)));
  }

  static BoxDecoration only(
      {double topLeft = 0.0,
      double topRight = 0.0,
      double bottomLeft = 0.0,
      double bottomRight = 0.0,
      Color color = R.color_2}) {
    return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft),
          topRight: Radius.circular(topRight),
          bottomLeft: Radius.circular(bottomLeft),
          bottomRight: Radius.circular(bottomRight),
        ));
  }

  static BoxDecoration decoration2({double radius = 6.0}) {
    return BoxDecoration(
        border: Border.all(color: R.color_2),
        borderRadius: BorderRadius.all(Radius.circular(radius)));
  }

  static BoxDecoration bottomDecoration(
      {Color color = R.color_2, double width = 1.0}) {
    return BoxDecoration(
      border: Border(bottom: BorderSide(color: color, width: width)),
    );
  }

  static BoxDecoration topDecoration(
      {Color color = R.color_font_3, double width = 1.0}) {
    return BoxDecoration(
      border: Border(top: BorderSide(color: color, width: width)),
    );
  }

  static BoxDecoration leftDecoration(
      {Color color = R.color_font_3, double width = 1.0}) {
    return BoxDecoration(
      border: Border(left: BorderSide(color: color, width: width)),
    );
  }
}

class MyIcons {
  static const IconData arrow_right =
      IconData(0xe6cc, fontFamily: 'appIconFonts', matchTextDirection: true);
}
