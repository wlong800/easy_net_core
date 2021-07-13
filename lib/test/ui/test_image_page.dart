import 'package:app/base/common/resource.dart';
import 'package:app/base/widget/common_ui_kit.dart';
import 'package:app/base/widget/image/MyCachedNetworkImage.dart';
import 'package:flutter/material.dart';

class TestImagePage extends StatelessWidget {
  const TestImagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 24.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        child: MyCachedNetworkImage(
                            url:
                                "https://img.allhistory.com/60964b005c66234b0d367c2a.png"),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AvatarKit(
                        avatar:
                            "https://img.allhistory.com/60964b005c66234b0d367c2a.png",
                        width: 60.0,
                        height: 60.0,
                        radius: 30.0,
                        borderWidth: 0.0,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AvatarKit(
                        avatar:
                            "https://img.allhistory.com/60964b005c66234b0d367c2a.png",
                        width: 60.0,
                        height: 60.0,
                        radius: 30.0,
                        radius2: 30.0,
                        borderWidth: 3.0,
                        borderColor: R.color_1,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        child: Image.network(
                            "https://img.allhistory.com/60964b005c66234b0d367c2a.png"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
