import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/common/touch_callback.dart';
import 'package:app/base/gallery/pre_big_scale_image_page.dart';
import 'package:app/base/widget/image/MyCachedNetworkImage.dart';
import 'package:app/page/home/cell/community_header_cell.dart';
import 'package:app/page/models/community_model.dart';
import 'package:flutter/material.dart';
import 'package:nine_grid_view/nine_grid_view.dart';

import 'community_footer_cell.dart';

class CommunityImageCell extends StatelessWidget {
  final CommunityFeedModel? model;

  const CommunityImageCell({Key? key, this.model}) : super(key: key);

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
            child: toInt(model?.getImages()?.length) > 1
                ? _buildGridImages()
                : _buildSingleImage(context, model?.getImages()?.elementAt(0)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: CommunityFooterCell(model: model),
          )
        ],
      ),
    );
  }

  Widget _buildGridImages() {
    return NineGridView(
      space: 5,
      type: NineGridType.normal,
      width: (getScreenWidth() - 12 * 2 - 16 * 2 - 5 * 2),
      //NineGridType.weChat, NineGridType.weiBo
      itemCount: toInt(model?.getImages()?.length),
      itemBuilder: (BuildContext context, int index) {
        var imageModel = model?.getImages();
        return TouchCallBack(
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              child: MyCachedNetworkImage(
                url: toString2(imageModel?.elementAt(index).url),
              ),
            ),
          ),
          onPressed: () {
            fadePush(
                context,
                PreBigImagePage(
                  images: model?.getImagesUrl(),
                  currentIndex: index,
                ));
          },
        );
      },
    );
  }

  Widget _buildSingleImage(BuildContext context, ImageObject? model) {
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
      child: TouchCallBack(
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            child: MyCachedNetworkImage(url: toString2(model?.url)),
          ),
        ),
        onPressed: () {
          fadePush(
              context,
              PreBigImagePage(
                images: [toString2(model?.url)],
                currentIndex: 0,
              ));
        },
      ),
    );
  }
}
