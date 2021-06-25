import 'package:app/base/common/lang.dart';
import 'package:flutter/material.dart';

class TextAreaPage extends StatefulWidget {
  const TextAreaPage({Key? key}) : super(key: key);

  @override
  _TextAreaPageState createState() => _TextAreaPageState();
}

class _TextAreaPageState extends State<TextAreaPage> {
  double _top = 0.0; //距顶部的偏移
  double _left = 0.0; //距左边的偏移
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: Container(
                color: Colors.red,
                  child: Center(child: Image.asset("images/icon_no_wifi.png", width: 150.0,))),
              //手指按下时会触发此回调
              onPanDown: (DragDownDetails e) {
                //打印手指按下的位置(相对于屏幕)
                print("用户手指按下：${e.globalPosition}");
              },
              //手指滑动时会触发此回调
              onPanUpdate: (DragUpdateDetails e) {
                //用户手指滑动时，更新偏移，重新构建
                setState(() {
                  _left += e.delta.dx;
                  _top += e.delta.dy;
                });
              },
              onPanEnd: (DragEndDetails e) {
                //打印滑动结束时在x、y轴上的速度
                print(e.velocity);
              },
            ),
          )
        ],
      ),
    );
  }
}
