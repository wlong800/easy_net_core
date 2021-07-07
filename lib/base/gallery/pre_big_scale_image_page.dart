import 'package:app/base/common/lang.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PreBigImagePage extends StatefulWidget {
  final List<String>? images;
  final int? currentIndex;

  PreBigImagePage({this.images, this.currentIndex});

  @override
  _PreBigImagePageState createState() => _PreBigImagePageState();
}

class _PreBigImagePageState extends State<PreBigImagePage> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _index = toInt(widget.currentIndex, defaultValue: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Colors.black,
        child: Container(
            color: Colors.black,
            child: ExtendedImageSlidePage(
              slideAxis: SlideAxis.both,
              slideType: SlideType.onlyImage,
              onSlidingPage: (state) {},
              child: ExtendedImageGesturePageView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var item = widget.images![index];
                  Widget image = ExtendedImage.network(
                    item,
                    fit: BoxFit.contain,
                    mode: ExtendedImageMode.gesture,
                    initGestureConfigHandler: (ExtendedImageState state) {
                      return GestureConfig(
                        inPageView: true,
                        initialScale: 1.0,
                        maxScale: 5.0,
                        animationMaxScale: 6.0,
                        initialAlignment: InitialAlignment.center,
                      );
                    },
                  );
                  Widget image1 = GestureDetector(
                    child: Container(
                      color: Colors.black,
                      child: image,
                      padding: EdgeInsets.all(5.0),
                    ),
                    onTap: () {
                      pop(context);
                    },
                    onLongPress: () {},
                  );
                  if (index == widget.currentIndex) {
                    return Hero(
                      tag: item + index.toString(),
                      child: image1,
                    );
                  } else {
                    return image1;
                  }
                },
                itemCount: widget.images!.length,
                onPageChanged: (int index) {
                  _index = index;
                },
                controller:
                    PageController(initialPage: _index, keepPage: false),
                scrollDirection: Axis.horizontal,
              ),
            )),
      ),
    );
  }
}
