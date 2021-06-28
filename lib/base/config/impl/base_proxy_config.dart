
import '../light_switch_config.dart';

class BaseProxyConfig extends LightSwitchConfig {
  final String ip;
  final String port;

  BaseProxyConfig(this.ip, this.port);

  @override
  bool enable() {
    ///默认都是true,如果有需求自定义，继承ProxyConfig
    return true;
  }

}
