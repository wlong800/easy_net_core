import 'package:app/base/api/net/api.dart';
import 'package:app/base/common/logger.dart';
import 'package:app/base/common/touch_callback.dart';
import 'package:app/base/widget/common_ui_kit.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AFPreferredSize(
        "Test",
      ),
      body: Container(
        alignment: Alignment.center,
        child: TouchCallBack(
          child: Text("Click"),
          onPressed: () {
            Api.get("http://10.4.40.54/api/m/future/event/v1/info",
                params: {"id": "457"}, success: (data) {
              logger(data.toString());
            });
          },
        ),
      ),
    );
  }
}
