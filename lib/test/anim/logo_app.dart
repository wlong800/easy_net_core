import 'package:flutter/material.dart';

class LogoPage extends StatefulWidget {
  const LogoPage({Key? key}) : super(key: key);

  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage>
    with SingleTickerProviderStateMixin {
  ///Flutter 动画库中的核心类，插入用于指导动画的值
  ///是一个抽象类，它本身和UI渲染没有任何关系，而它主要的功能是保存动画的插值和状态
  ///Animation对象是一个在一段时间内依次生成一个区间(Tween)之间值的类
  ///Animation对象在整个动画执行过程中输出的值可以是线性的、曲线的、一个步进函数或者任何其他曲线函数等等，这由Curve来决定
  /// 根据Animation对象的控制方式，动画可以正向运行（从起始状态开始，到终止状态结束），也可以反向运行，甚至可以在中间切换方向
  /// Animation还可以生成除double之外的其他类型值，如：Animation<Color> 或Animation<Size>
  late Animation<double> _animation;

  ///管理 Animation
  late AnimationController _animationController;

  /// dismissed<消失>；forward<开始-结束>; reverse<结束-开始>; completed<完成>
  /// Flutter中通过Curve（曲线）来描述动画过程，我们把匀速动画称为线性的(Curves.linear)，而非匀速动画称为非线性的
  AnimationStatus? _animationStatus;

  @override
  void initState() {
    super.initState();

    //controller
    _animationController = AnimationController(
        duration: Duration(seconds: 5),
        reverseDuration: Duration(seconds: 2),
        vsync: this);

    var curve =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceIn);

    //图片宽高0-300
    _animation = Tween<double>(begin: 0, end: 300).animate(curve)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _animationController.forward();
            }
          })
        /*..addListener(() {
        setState(() {});
      })*/
        ;
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    /// 1
    // return Material(
    //   child: SafeArea(
    //       child: Row(
    //     children: [
    //       SizedBox(
    //         width: _animation.value,
    //         height: _animation.value,
    //         child: Image.asset("images/icon_no_wifi.png"),
    //       ),
    //     ],
    //   )),
    // );

    /// 2
    // return Material(
    //   child: SafeArea(
    //       child: AnimatedImage(animation: _animation,)),
    // );
    /// 3
    return Material(
      child: SafeArea(
          child: GrowTransition(
        animation: _animation,
        child: Image.asset("images/icon_no_wifi.png"),
      )),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class AnimatedImage extends AnimatedWidget {
  final Animation<double> animation;

  AnimatedImage({Key? key, required this.animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    return new Center(
      child: Image.asset("images/icon_no_wifi.png",
          width: animation.value, height: animation.value),
    );
  }
}

class GrowTransition extends StatelessWidget {
  GrowTransition({required this.child, required this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return new Center(
      child: new AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            return Container(
                height: animation.value, width: animation.value, child: child);
          },
          child: child),
    );
  }
}
