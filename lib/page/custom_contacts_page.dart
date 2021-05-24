import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/common/touch_callback.dart';
import 'package:app/base/widget/common_ui_kit.dart';
import 'package:app/page/base/base_provider_state.dart';
import 'package:app/page/cell/custom_contacts_cell.dart';
import 'package:app/page/view_model/custom_ticket_view_models.dart';
import 'package:flutter/material.dart';

import 'custom_contacts_add_page.dart';

class CustomContactsPage extends StatefulWidget {
  @override
  _CustomContactsPageState createState() => _CustomContactsPageState();
}

class _CustomContactsPageState
    extends BaseProviderState<CustomContactsPage, CustomTicketViewModel> {
  @override
  Widget buildBody(BuildContext context, CustomTicketViewModel model) {
    var list = model.data;
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return CustomContactsCell(
          model: list[index],
        );
      },
      itemCount: list.length,
    );
  }

  @override
  Widget buildFullScreen(BuildContext context, CustomTicketViewModel model) {
    initScreenUtil(context);
    return Scaffold(
      appBar: WMPreferredSize("购票使用人"),
      body: build2(context, model),
    );
  }

  @override
  Widget buildEmptyWidget() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("xxx.png"),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text("暂无使用人哦",
                    style: TextStyle(
                        color: R.color_font_1, fontSize: sp(Sp.font_big))),
              ),
            ],
          ),
        ),
        TouchCallBack(
          child: Container(
            height: 45.0,
            margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 35.0),
            alignment: Alignment.center,
            child: Text(
              "添加使用人",
              style: TextStyle(color: Colors.white, fontSize: sp(Sp.font_big)),
            ),
            decoration: MyBoxDecoration.all(radius: 23.0, color: R.color_1),
          ),
          onPressed: () {
            push(context, CustomContactsAddPage());
          },
        )
      ],
    );
  }
}
