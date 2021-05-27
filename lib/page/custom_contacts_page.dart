import 'package:app/base/api/net/HttpStatus2.dart';
import 'package:app/base/api/net/services/net_state_enum.dart';
import 'package:app/base/common/channel_tools.dart';
import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/common/touch_callback.dart';
import 'package:app/base/widget/common_ui_kit.dart';
import 'package:app/base/widget/dialog/base_dialog.dart';
import 'package:app/page/base/base_provider_state.dart';
import 'package:app/page/cell/custom_contacts_cell.dart';
import 'package:app/page/view_model/custom_ticket_view_models.dart';
import 'package:flutter/material.dart';

import 'custom_contacts_add_page.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

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
        var model = list[index];
        return Container(
          margin: EdgeInsets.only(right: 16.0, top: 8.0),
          child: SwipeActionCell(
            key: ValueKey(list[index]),
            trailingActions: <SwipeAction>[
              SwipeAction(
                  content: Container(
                    child: Text(
                      "删除",
                      style: TextStyle(
                          color: R.color_white, fontSize: sp(Sp.font_middle2)),
                    ),
                    alignment: Alignment.center,
                    decoration: MyBoxDecoration.only(
                        topRight: 12.0, bottomRight: 12.0, color: R.color_1),
                  ),
                  onTap: (CompletionHandler handler) async {
                    showDialogLoadingKt(context);
                    var response = await providerModel.appService
                        .deleteContactsData(params: {"cid": model.id});
                    pop(context);
                    if (response?.code == HttpStatus2.ok) {
                      list.removeAt(index);
                      if (isEmpty(list)) {
                        providerModel.setConnectionState = NetState.empty;
                      }
                      setState(() {});
                    } else {
                      Channel.showNativeToast(msg: response?.msg);
                    }
                  },
                  color: R.color_background),
            ],
            child: TouchCallBack(
              child: CustomContactsCell(
                model: list[index],
              ),
              onPressed: () {
                push(
                    context,
                    CustomContactsAddPage(
                      model: list[index],
                      func: () {
                        onFetchData(showLoadingUI: false);
                      },
                    ));
              },
            ),
          ),
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
      body: Column(
        children: [
          Expanded(child: build2(context, model)),
          Container(
            color: R.color_white,
            padding: EdgeInsets.only(
                top: 10.0, left: 16.0, right: 16.0, bottom: 35.0),
            child: TouchCallBack(
              child: Container(
                height: 45.0,
                alignment: Alignment.center,
                child: Text(
                  "新增使用人",
                  style:
                      TextStyle(color: Colors.white, fontSize: sp(Sp.font_big)),
                ),
                decoration: MyBoxDecoration.all(radius: 23.0, color: R.color_1),
              ),
              onPressed: () {
                push(context, CustomContactsAddPage(
                  func: () {
                    onFetchData(showLoadingUI: false);
                  },
                ));
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget buildEmptyWidget() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("images/icon_profile_edit.png"),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text("暂无使用人哦",
                style: TextStyle(
                    color: R.color_font_1, fontSize: sp(Sp.font_big))),
          ),
        ],
      ),
    );
  }
}
