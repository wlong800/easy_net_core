import 'package:flutter/foundation.dart' as Foundation;
import 'package:logger/logger.dart';
var mLogger;
/// 所有的log 日志 开关处理
logger(dynamic logContent, {String tag = "all_future"}) {
  if (Foundation.kReleaseMode) return;
  var log = "$tag : $logContent";
  if (mLogger == null) mLogger = Logger();
  mLogger.v(log);
}
