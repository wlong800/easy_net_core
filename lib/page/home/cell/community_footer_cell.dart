import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/widget/common_ui_kit.dart';
import 'package:app/page/models/community_model.dart';
import 'package:flutter/material.dart';

class CommunityFooterCell extends StatelessWidget {
  final CommunityFeedModel? model;

  const CommunityFooterCell({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: MyBoxDecoration.topDecoration(
          width: 0.33, color: R.color_text_field_border),
      padding: EdgeInsets.only(top: 12.0),
      child: Row(
        children: [
          Flexible(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/all_future_community_icon_share.png",
                    width: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: Text(
                      toString2(model?.transmitNum),
                      style: TextStyle(
                          color: R.color_font_3, fontSize: sp(Sp.font_middle2)),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/all_future_community_icon_comment.png",
                    width: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: Text(
                      toString2(model?.commentNum),
                      style: TextStyle(
                          color: R.color_font_3, fontSize: sp(Sp.font_middle2)),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    model?.hasLiked == true
                        ? "images/all_future_community_icon_like_selected.png"
                        : "images/all_future_community_icon_like_normal.png",
                    width: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: Text(
                      toString2(model?.likeNum),
                      style: TextStyle(
                          color: R.color_font_3, fontSize: sp(Sp.font_middle2)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
