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
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  crossAxisCount: 3),
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
                        placeholder: (context, _) => Image.asset(
                            "images/bg_default.png",
                            fit: BoxFit.cover),
                        imageUrl: toString2(imageModel?.elementAt(index).url),
                        errorWidget: (context, _, error) => Image.asset(
                            "images/bg_default.png",
                            fit: BoxFit.cover),
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
