import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/widget/image/MyCachedNetworkImage.dart';
import 'package:app/page/models/community_model.dart';
import 'package:flutter/material.dart';

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
              child: MyCachedNetworkImage(url: toString2(getFullUrl(event?.coverUrl))),
            ),
          ),
        ],
      ),
    );
  }
}
