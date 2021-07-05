import 'package:app/base/common/lang.dart';
import 'package:app/base/hold/hold.dart';
import 'package:app/base/widget/base_button.dart';
import 'package:app/base/widget/common_ui_kit.dart';
import 'package:app/tools/channel_tools.dart';
import 'package:flutter/material.dart';

class ProxySettingPage extends StatefulWidget {
  @override
  _ProxySettingPageState createState() => _ProxySettingPageState();
}

class _ProxySettingPageState extends State<ProxySettingPage> {
  TextEditingController _proxyController = TextEditingController();
  TextEditingController _portController = TextEditingController();

  bool switchFlag = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WMPreferredSize2("Proxy Setting"),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("open proxy ?"),
                Switch(
                    value: switchFlag,
                    onChanged: (b) {
                      Channel.showNativeToast(
                          msg: b ? "open success" : "closed success");
                      setState(() {
                        switchFlag = b;
                      });
                    })
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextFormField2(
                controller: _proxyController,
                inputType: TextInputType.emailAddress,
                hintText: "local address",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextFormField2(
                controller: _portController,
                inputType: TextInputType.number,
                hintText: "port",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: MyRaisedButton(
                "submit",
                () {
                  if (switchFlag) {
                    Hold.put("proxy_setting",
                        "${_proxyController.text}:${_portController.text}");
                  } else {
                    Hold.put("proxy_setting", "");
                  }
                  pop(context);
                },
                enableClick: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
