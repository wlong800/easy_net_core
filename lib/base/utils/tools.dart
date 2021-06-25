import 'package:flutter/cupertino.dart';

/// 存放常用的一些工具函数

/// 1. json文件 -> string
Future<String> loadJson(BuildContext context, String jsonName) {
  return DefaultAssetBundle.of(context)
      .loadString(jsonName);
}
