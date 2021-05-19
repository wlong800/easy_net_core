import 'package:app/base/api/net/api.dart';
import 'package:app/base/common/logger.dart';
import 'package:app/base/common/touch_callback.dart';
import 'package:app/base/widget/common_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:all_future_plugin/all_future_plugin.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
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
          onPressed: () async {
            // var platformHeaders = await AllFuturePlugin.platformHeaders({
            //   "url": "http://10.4.40.54/api/m/future/event/v1/n/feed",
            //   "method": "post",
            //   "contentType": "json",
            //   "requestBody": {
            //     "cityAreaId": "",
            //     "distance": "",
            //     "endTime": null,
            //     "feedTimeFilter": "ALL_TIME",
            //     "feedType": "NEARBY",
            //     "geo": {"lat": 40.003489, "lon": 116.422965},
            //     "groupStatus": "",
            //     "hotFlag": null,
            //     "id": null,
            //     "minImportance": null,
            //     "page": 1,
            //     "priceAttribute": "",
            //     "regionId": null,
            //     "siteId": null,
            //     "size": 20,
            //     "sortBy": null,
            //     "startTime": null,
            //     "tagIds": null,
            //     "themeId": null,
            //     "userId": null
            //   }
            // });
            // debugPrint("platformHeaders : $platformHeaders");
            Api.post(
                "https://fu.allhistory.com/api/m/future/login/v1/n/app/token",
                params: {
                  "appId": "wmzh65c3f1601a7d68d9",
                  "ticket": "8e1044ef7e0d432a9f101779cd17d73b"
                }, success: (data) {
              logger(data.toString());
            });
          },
        ),
      ),
    );
  }
}
