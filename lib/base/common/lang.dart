import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import '../../main.dart';
import '../../tools/channel_tools.dart';
import 'logger.dart';

/// 封装一些常用的函数

///去除空格换换行
String removeSpaces(String? value) {
  if (value == null) return "";
  return value.replaceAll(RegExp(r"\s+"), "");
}

String removeSuffixSpaces(String? value) {
  if (value == null) return "";
  if (value.endsWith(" ")) {
    return value.substring(0, value.length - 1);
  }
  return value;
}

/// 目前支持String List Map
bool isEmpty(var data) {
  if (data == null) return true;
  if (data is List) {
    return data.isEmpty;
  } else if (data is String) {
    return data.isEmpty;
  } else if (data is Map) {
    return data.isEmpty;
  }
  return false;
}

/// 目前支持String List Map
bool isNotEmpty(var data) {
  if (data == null) return false;
  if (data is List) {
    return data.isNotEmpty;
  } else if (data is Map) {
    return data.isNotEmpty;
  } else if (data is String) {
    return data.isNotEmpty;
  } else if (data is int || data is double) {
    return true;
  }
  return false;
}

int toInt(value, {int defaultValue = -1}) {
  if (isEmpty(value)) return defaultValue;
  if (value is int) return value;
  if (value is String) {
    try {
      if (value.contains(".")) {
        return toInt(double.parse(value));
      } else {
        return int.parse(value);
      }
    } catch (e) {
      logger(e.toString());
      return defaultValue;
    }
  }
  if (value is double) {
    return value.toInt();
  }
  return defaultValue;
}

String toString2(value, {String defaultValue = ""}) {
  if (value is int || value is double) return value.toString();
  if (value is String) return value;
  return defaultValue;
}

bool toBool(value) {
  if (value == null) return false;
  if (value is bool) return value;
  if (value is int) return value == 1;
  return false;
}

int toFloor(double value) {
  return value.floor();
}

String getLimitText(value, {required int maxLen, String ellipsis = "..."}) {
  var text = toString2(value);
  if (text.length > maxLen) {
    return text.substring(0, maxLen) + ellipsis;
  }
  return text;
}

///类似android中 startActivity
push(BuildContext context, Widget route, {bool replace = false}) async {
  if (replace) {
    await Navigator.pushReplacement(context,
        CupertinoPageRoute(builder: (context) {
      return route;
    }));
  } else {
    try {
      await Navigator.push(context, CupertinoPageRoute(builder: (context) {
        return route;
      }));
    } catch (e) {
      logger(e.toString());
    }
  }
}

double getScreenWidth() {
  return MediaQuery.of(navigatorState.currentContext!).size.width;
}

double getScreenHeight() {
  return MediaQuery.of(navigatorState.currentContext!).size.height;
}

///类似android中 finish
pop(BuildContext context, {bool system = false}) {
  if (system) {
    Navigator.pop(context);
    systemPop();
  } else {
    Navigator.pop(context);
  }
}

fadePush(BuildContext context, Widget route) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 300), //动画时间为300毫秒
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return new FadeTransition(
          //使用渐隐渐入过渡,
          opacity: animation as Animation<double>,
          child: route, //路由B
        );
      },
    ),
  );
}

delayed(int milliseconds, [FutureOr computation()?]) {
  Future.delayed(Duration(milliseconds: milliseconds), () {
    computation!();
  });
}

Type typeOf<T>() => T;

String uuid() {
  return Uuid().v4();
}

RegExp emailRegExp() {
  return RegExp("[a-z,A-Z,0-9,@_?\\-?\\.]");
}

RegExp nickNameRegExp() {
  return RegExp("[a-z,A-Z,0-9]");
}

RegExp numberRegExp() {
  return RegExp("[0-9]");
}

RegExp phoneRegExp() {
  //1[0-9]\d{9}
  return RegExp("1");
}

String getHideCenterText(String text) {
  var re = RegExp("(\\w{3})(\\w+)(\\w{4})");
  if (re.hasMatch(text)) {
    var len = text.length;
    return text.replaceRange(3, len - 4, "*" * (len - 7));
  }
  return text;
}

bool isIOS() {
  return Platform.isIOS;
}

bool isAndroid() {
  return Platform.isAndroid;
}
