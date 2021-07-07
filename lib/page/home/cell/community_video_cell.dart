import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/common/touch_callback.dart';
import 'package:app/page/home/cell/community_header_cell.dart';
import 'package:app/page/models/community_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'community_footer_cell.dart';

class CommunityVideoCell extends StatelessWidget {
  final CommunityFeedModel? model;

  const CommunityVideoCell({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: MyBoxDecoration.all(color: R.color_white, radius: 12.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommunityHeaderCell(
            model: model,
          ),
          Offstage(
            offstage: isEmpty(model?.getTitle()),
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                toString2(model?.getTitle()).trim(),
                style:
                    TextStyle(color: R.color_font_1, fontSize: sp(Sp.font_17)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: _buildVideoView(context, model?.getVideos()?.elementAt(0)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: CommunityFooterCell(model: model),
          )
        ],
      ),
    );
  }

  Widget _buildVideoView(BuildContext context, ImageObject? model) {
    var width = getScreenWidth() * 237 / 414.0;
    var height = 0.0;
    var maxHeight = toDouble(width * 4 / 3.0);
    var realHeight =
        toDouble(model?.height) * width / toDouble(model?.width) <= 0
            ? 1.0
            : toDouble(model?.width);
    if (realHeight > maxHeight) {
      height = maxHeight;
    } else {
      height = realHeight;
    }
    return Container(
      width: width,
      height: height,
      color: Colors.black,
      child: TouchCallBack(
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                child: CachedNetworkImage(
                  fadeOutCurve: Curves.linear,
                  fadeInCurve: Curves.linear,
                  fadeInDuration: Duration(milliseconds: 0),
                  fadeOutDuration: Duration(milliseconds: 0),
                  placeholder: (context, _) =>
                      Image.asset("images/bg_default.png", fit: BoxFit.cover),
                  imageUrl: toString2(model?.thumb),
                  errorWidget: (context, _, error) =>
                      Image.asset("images/bg_default.png", fit: BoxFit.cover),
                  fit: BoxFit.cover,
                ),
              ),
              Image.asset(
                "images/all_future_community_video_play_big.png",
                width: 70.0,
              ),
              Positioned(
                  bottom: 6.0,
                  right: 6.0,
                  child: Container(
                    height: 20.0,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: MyBoxDecoration.all(
                        radius: 3.0, color: R.color_black.withOpacity(0.4)),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/icon_game_list_video.webp",
                          width: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "00:21",
                            style: TextStyle(
                                color: R.color_white,
                                fontSize: sp(Sp.font_small)),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
