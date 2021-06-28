import 'package:app/base/config/light_switch_config.dart';

class BaseLoggerConfig implements LightSwitchConfig {
  @override
  bool enable() {
    return true;
  }
}
