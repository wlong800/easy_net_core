import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/common/touch_callback.dart';
import 'package:app/base/gallery/pre_big_scale_image_page.dart';
import 'package:app/page/home/cell/community_header_cell.dart';
import 'package:app/page/models/community_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'community_footer_cell.dart';

class CommunityReferEventCell extends StatelessWidget {
  final CommunityFeedModel? model;

  const CommunityReferEventCell({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: MyBoxDecoration.all(radius: 6.0, color: R.color_f9f9f9),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: _buildEventView(model),
    );
  }

  Widget _buildEventView(CommunityFeedModel? model) {
    var event = model?.referenceData?.event;
    return Container(
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                toString2(event?.title),
                style: TextStyle(
                    color: R.color_font_1, fontSize: sp(Sp.font_middle2)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "5月21日 周六 20:00",
                  style: TextStyle(
                      color: R.color_font_2, fontSize: sp(Sp.font_small)),
                ),
              ),
            ],
          )),
          Container(
            width: 36.0,
            height: 48.0,
            margin: EdgeInsets.only(left: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              child: CachedNetworkImage(
                fadeOutCurve: Curves.linear,
                fadeInCurve: Curves.linear,
                fadeInDuration: Duration(milliseconds: 0),
                fadeOutDuration: Duration(milliseconds: 0),
                placeholder: (context, _) =>
                    Image.asset("images/bg_default.png", fit: BoxFit.cover),
                imageUrl: toString2(getFullUrl(event?.coverUrl)),
                errorWidget: (context, _, error) =>
                    Image.asset("images/bg_default.png", fit: BoxFit.cover),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
