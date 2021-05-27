
import 'hold_facade.dart';
import 'hold_impl.dart';

/// 管理类，真正对接 '保存'功能
class HoldManager {
  static HoldManager? _instance;
  HoldFacade _holdFacade;

  HoldManager(this._holdFacade);

  static HoldManager? get instance => _instance;


  HoldFacade get holdFacade => _holdFacade;

  static Future<Null> init() async {
    // var holdImpl = await HoldFacadeImpl().init();
    // _instance = HoldManager(holdImpl);
  }
}
