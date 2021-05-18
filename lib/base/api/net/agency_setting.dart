import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/widget/common_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgencySetting extends StatefulWidget {
  @override
  _AgencySettingState createState() => _AgencySettingState();
}

class _AgencySettingState extends State<AgencySetting> {
  bool _showAgency = false;
  String? _address;
  String _port = "8888";

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      _showAgency = value.getBool("agency_setting") ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AFPreferredSize(
        "代理设置",
        elevation: Size2.elevation,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Switch(
              value: _showAgency, //当前状态
              onChanged: (change) {
                SharedPreferences.getInstance().then((value) {
                  value.setBool("agency_setting", change).then((v2) {
                    setState(() {
                      _showAgency = change;
                    });
                  });
                });
              },
            ),
            _showAgency ? _buildTextField() : Container(),
            _showAgency ? _buildTextField2() : Container(),
            ElevatedButton(
              child: Text("更新代理"),
              onPressed: () {
                if (isEmpty(_address) || isEmpty(_port)) {
                  return;
                }
                SharedPreferences.getInstance().then((value) {
                  value.setString("agency_address", _address!);
                  value.setString("agency_port", _port);
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              maxLines: 1,
              buildCounter: null,
              autofocus: true,
              cursorColor: R.color_1,
              decoration: InputDecoration(
                  hintText: "请输入主机名",
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      color: R.color_1, fontSize: sp(Sp.font_middle))),
              style: TextStyle(color: R.color_1, fontSize: sp(Sp.font_middle)),
              onChanged: (value) {
                _address = value;
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextField2() {
    return Container(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              maxLines: 1,
              buildCounter: null,
              autofocus: true,
              cursorColor: R.color_1,
              decoration: InputDecoration(
                  hintText: "请输入端口 默认8888",
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      color: R.color_1, fontSize: sp(Sp.font_middle))),
              style: TextStyle(color: R.color_1, fontSize: sp(Sp.font_middle)),
              onChanged: (value) {
                _port = value;
              },
            ),
          )
        ],
      ),
    );
  }
}
