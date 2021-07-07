import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/widget/common_ui_kit.dart';
import 'package:app/page/models/community_model.dart';
import 'package:flutter/material.dart';

class CommunityHeaderCell extends StatelessWidget {
  final CommunityFeedModel? model;

  const CommunityHeaderCell({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var creator = model?.creator;
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Row(
            children: [
              AvatarKit(
                avatar: creator?.getAvatar(),
                width: 40.0,
                height: 40.0,
                radius: 20.0,
                borderWidth: 0.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(toString2(creator?.username)),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        children: [
                          Offstage(
                            offstage: isEmpty(creator?.getGenderImage()),
                            child: Container(
                              margin: const EdgeInsets.only(right: 6.0),
                              child: Image.asset(
                                toString2(creator?.getGenderImage()),
                                width: 16.0,
                              ),
                            ),
                          ),
                          Container(
                            decoration: MyBoxDecoration.all(
                                radius: 8.0, color: R.color_ff9932),
                            height: 16.0,
                            padding: EdgeInsets.symmetric(horizontal: 6.0),
                            alignment: Alignment.center,
                            child: Text(
                              "0.1km",
                              style: TextStyle(
                                  color: R.color_white,
                                  fontSize: sp(Sp.font_10)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
          Text(
            "1分钟前",
            style:
                TextStyle(color: R.color_font_2, fontSize: sp(Sp.font_small)),
          ),
        ],
      ),
    );
  }
}
