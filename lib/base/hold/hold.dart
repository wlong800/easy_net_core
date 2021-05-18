
import 'package:all_future_flutter_module/base/common/lang.dart';

import 'hold_manager.dart';

/// 门面
class Hold {
  static put(String key, dynamic value) {
    HoldManager.instance!.holdFacade.put(key, value);
  }

  static dynamic get(String key) {
    return HoldManager.instance!.holdFacade.get(key);
  }

  static dynamic getString(String key) {
    var value = HoldManager.instance!.holdFacade.get(key);
    return toString2(value);
  }

  static dynamic getBool(String key) {
    var value = HoldManager.instance!.holdFacade.get(key);
    return toBool(value);
  }

  static dynamic getInt(String key) {
    var value = HoldManager.instance!.holdFacade.get(key);
    return toInt(value);
  }

  static delete(String key) {
    HoldManager.instance!.holdFacade.delete(key);
  }

  static deleteAll() {
    HoldManager.instance!.holdFacade.deleteAll();
  }

  static bool contains(String key) {
    return HoldManager.instance!.holdFacade.isContains(key);
  }

}
