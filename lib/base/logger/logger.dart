import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';

/// 所有的log 日志 开关处理
logger(dynamic log, {String tag = "all_future"}) {
  if (Foundation.kReleaseMode) return;
  var logger = "$tag : $log";
  debugPrint(logger);
}
