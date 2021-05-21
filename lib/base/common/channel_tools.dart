 import 'package:flutter/services.dart';

 const platform = const MethodChannel('all_future_flutter_method_plugin');

 const eventChannel = const EventChannel('all_future_flutter_event_plugin');

 const basicMessageChannel = const BasicMessageChannel(
     'all_future_flutter_basic_plugin', StandardMessageCodec());

Future<void> systemPop() async {
await platform.invokeMethod<void>('SystemNavigator.systemPop');
}