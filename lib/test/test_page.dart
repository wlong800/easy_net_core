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
                "https://fu.allhistory.com/api/m/future/v2/y/user/follow/list",
                params: {
                  "querySource": "mypage",
                  "size": 20,
                  "attentionType": 1,
                  "followType": 0,
                  "page": 1
                }, success: (data) {
              logger(data.toString());
            });
          },
        ),
      ),
    );
  }
}
