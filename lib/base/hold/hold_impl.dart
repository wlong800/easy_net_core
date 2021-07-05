
import 'package:shared_preferences/shared_preferences.dart';

import 'hold_facade.dart';

class HoldFacadeImpl extends HoldFacade {
  static SharedPreferences? _prefs;

  Future<HoldFacadeImpl> init() async {
    try {
      SharedPreferences.setMockInitialValues({}); // set initial values here if desired
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print(e);
    }
    return this;
  }

  @override
  Future<bool?> delete(String key) async {
    return await _prefs?.remove(key);
  }

  @override
  Future<bool?> deleteAll() async {
    return await _prefs?.clear();
  }

  @override
  dynamic get(String key) {
    if (_prefs == null || _prefs?.containsKey(key) == false) return null;
    return _prefs?.get(key);
  }

  @override
  bool isContains(String key) {
    return _prefs?.containsKey(key) == true;
  }

  @override
  Future<bool?> put(String key, value) async {
    if (value is String) {
      return await _prefs?.setString(key, value);
    } else if (value is int) {
      return await _prefs?.setInt(key, value);
    } else if (value is bool) {
      return await _prefs?.setBool(key, value);
    } else if (value is List<String>) {
      return await _prefs?.setStringList(key, value);
    } else {
      throw Exception("value is $value, fail to save...");
    }
  }
}
