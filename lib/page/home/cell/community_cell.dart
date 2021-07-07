import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/page/home/cell/community_header_cell.dart';
import 'package:app/page/models/community_model.dart';
import 'package:flutter/material.dart';

import 'community_footer_cell.dart';

class CommunityCell extends StatelessWidget {
  final CommunityFeedModel? model;

  const CommunityCell({Key? key, this.model}) : super(key: key);

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
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              toString2(model?.getTitle()).trim(),
              style: TextStyle(color: R.color_font_1, fontSize: sp(Sp.font_17)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: CommunityFooterCell(model: model),
          )
        ],
      ),
    );
  }
}