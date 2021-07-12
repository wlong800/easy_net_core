import 'package:app/base/common/lang.dart';
import 'package:app/base/logger/logger.dart';
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

class _BottomNavigatorState extends State<BottomNavigator> with SingleTickerProviderStateMixin {
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
    if (isNotEmpty(widget.router)) {
      Future.delayed(Duration(milliseconds: 100), () {
        EasyNavigator.getInstance().onJumpTo(widget.router!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      MainHomePage(),
      MainSecondPage(),
      MainThirdPage(),
      MainFourPage()
    ];
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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => _onJumpTo(index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: _activeColor,
          items: [
            _bottomItem('首页', Icons.home, 0),
            _bottomItem('排行', Icons.local_fire_department, 1),
            _bottomItem('收藏', Icons.favorite, 2),
            _bottomItem('我的', Icons.live_tv, 3),
          ],
        ),
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(icon, color: _defaultColor),
        activeIcon: Icon(icon, color: _activeColor),
        label: title);
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
