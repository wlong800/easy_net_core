import 'package:app/base/config/impl/base_proxy_config.dart';
import 'package:app/base/config/light_switch_config.dart';

class ConfigManager {
  ConfigManager._();

  static ConfigManager? _instance;

  List<LightSwitchConfig> _configs = [];

  static ConfigManager getInstance() {
    if (_instance == null) {
      _instance = ConfigManager._();
    }
    return _instance!;
  }

  ConfigManager addConfig(LightSwitchConfig config) {
    _configs.add(config);
    return this;
  }

  ConfigManager addConfigs(List<LightSwitchConfig> configs) {
    _configs.clear();
    _configs.addAll(configs);
    return this;
  }

  build() {
    /// 扩展用，后期肯定用的到
    _configs.forEach((element) {});
  }

  String? getProxy() {
    String? proxy;
    _configs.forEach((element) {
      if (element is BaseProxyConfig) {
        proxy = "${element.ip}:${element.port}";
      }
    });
    return proxy;
  }
}
