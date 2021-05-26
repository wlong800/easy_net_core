import 'package:flutter/services.dart';

const platform = const MethodChannel('all_future_flutter_method_plugin');

const eventChannel = const EventChannel('all_future_flutter_event_plugin');

const basicMessageChannel = const BasicMessageChannel(
    'all_future_flutter_basic_plugin', StandardMessageCodec());

Future<void> systemPop() async {
  await platform.invokeMethod<void>('SystemNavigator.systemPop');
}

enum Toast { LENGTH_SHORT, LENGTH_LONG }

class Channel {
  static Future<void> addContactsData(String data) async {
    await platform.invokeMethod<void>('addContactsData', data);
  }

  static Future<bool?> showNativeToast(
      {required String? msg, Toast? toastLength}) async {
    String toast = "short";
    if (toastLength == Toast.LENGTH_LONG) {
      toast = "long";
    }
    final Map<String, dynamic> params = <String, dynamic>{
      'msg': msg,
      'length': toast
    };
    final bool? res = await platform.invokeMethod('showToast', params);
    return res;
  }
}
