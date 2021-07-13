import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/common/touch_callback.dart';
import 'package:app/page/home/main_home_page.dart';
import 'package:app/page/main_four_page.dart';
import 'package:app/page/main_second_page.dart';
import 'package:app/page/main_third_page.dart';
import 'package:app/tools/channel_tools.dart';
import 'package:app/utils/color.dart';
import 'package:flutter/material.dart';

import 'easy_navigator.dart';

///底部导航
class BottomNavigator extends StatefulWidget {
  final String? router;

  const BottomNavigator({Key? key, this.router}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator>
    with SingleTickerProviderStateMixin {
  final _defaultColor = Colors.grey;
  final _activeColor = primary;
  int _currentIndex = 0;
  DateTime? _lastPressedAt; //上次点击时间
  static int initialPage = 0;
  final PageController _controller = PageController(initialPage: initialPage);
  late List<Widget> _pages;
  bool _hasBuild = false;

  @override
  void initState() {
    super.initState();
    _pages = [
      MainHomePage(),
      MainSecondPage(),
      MainThirdPage(),
      MainFourPage()
    ];
    if (isNotEmpty(widget.router)) {
      Future.delayed(Duration(milliseconds: 100), () {
        EasyNavigator.getInstance().onJumpTo(widget.router!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasBuild) {
      //页面第一次打开时通知打开的是那个tab
      EasyNavigator.getInstance()
          .onBottomTabChange(initialPage, _pages[initialPage]);
      _hasBuild = true;
    }
    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          AHChannel.showNativeToast(msg: "再按一次退出APP");
          return false;
        }
        AHChannel.exitApp();
        return true;
      },
      child: Scaffold(
        body: PageView(
          controller: _controller,
          children: _pages,
          onPageChanged: (index) => _onJumpTo(index, pageChange: true),
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomAppBar(
          color: R.color_1,
          child: Container(
            height: 52.0,
            child: Row(
              children: <Widget>[
                _bottomItem("首页", Icons.margin, 0),
                _bottomItem("优选", Icons.margin, 1),

                SizedBox(), // 增加一些间隔
                _bottomItem("消息", Icons.margin, 2),
                _bottomItem("我的", Icons.share, 3),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          ),
          // shape: CircularNotchedRectangle(),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TouchCallBack(
              child: Container(
                margin: EdgeInsets.only(bottom: 12.0),
                color: Colors.orange,
                child: Icon(
                  Icons.add,
                  size: 48.0,
                  color: Colors.green,
                ),
              ),
              onPressed: () {
                AHChannel.showNativeToast(msg: "发布按钮");
              },
            ),
          ],
        ),
        // 设置 floatingActionButton 在底部导航栏中间
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return TouchCallBack(
      child: Column(
        children: [
          Icon(
            icon,
            color: _currentIndex == index ? _activeColor : _defaultColor,
          ),
          Text(
            title,
            style:
                TextStyle(color: R.color_font_1, fontSize: sp(Sp.font_middle2)),
          ),
        ],
      ),
      onPressed: () {
        _onJumpTo(index);
      },
    );
  }

  void _onJumpTo(int index, {pageChange = false}) {
    if (!pageChange) {
      //让PageView展示对应tab
      _controller.jumpToPage(index);
    } else {
      EasyNavigator.getInstance().onBottomTabChange(index, _pages[index]);
    }
    setState(() {
      //控制选中第一个tab
      _currentIndex = index;
    });
  }
}
