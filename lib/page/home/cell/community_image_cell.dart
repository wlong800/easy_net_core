import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/common/touch_callback.dart';
import 'package:app/base/gallery/pre_big_scale_image_page.dart';
import 'package:app/page/home/cell/community_header_cell.dart';
import 'package:app/page/models/community_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 5.0, mainAxisSpacing: 5.0, crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        var imageModel = model?.getImages();
        return TouchCallBack(
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              child: CachedNetworkImage(
                fadeOutCurve: Curves.linear,
                fadeInCurve: Curves.linear,
                fadeInDuration: Duration(milliseconds: 0),
                fadeOutDuration: Duration(milliseconds: 0),
                placeholder: (context, _) =>
                    Image.asset("images/bg_default.png", fit: BoxFit.cover),
                imageUrl: toString2(imageModel?.elementAt(index).url),
                errorWidget: (context, _, error) =>
                    Image.asset("images/bg_default.png", fit: BoxFit.cover),
                fit: BoxFit.cover,
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
      itemCount: toInt(model?.getImages()?.length),
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
            child: CachedNetworkImage(
              fadeOutCurve: Curves.linear,
              fadeInCurve: Curves.linear,
              fadeInDuration: Duration(milliseconds: 0),
              fadeOutDuration: Duration(milliseconds: 0),
              placeholder: (context, _) =>
                  Image.asset("images/bg_default.png", fit: BoxFit.cover),
              imageUrl: toString2(model?.url),
              errorWidget: (context, _, error) =>
                  Image.asset("images/bg_default.png", fit: BoxFit.cover),
              fit: BoxFit.cover,
            ),
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
