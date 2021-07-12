import 'package:app/page/home/main_home_page.dart';
import 'package:app/page/main_four_page.dart';
import 'package:app/page/main_second_page.dart';
import 'package:app/page/main_third_page.dart';
import 'package:app/tools/channel_tools.dart';
import 'package:flutter/material.dart';

import 'base/common/resource.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  DateTime? _lastPressedAt; //上次点击时间
  List<Widget> _pages = [];
  int _currentIndex = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  void _onTapHandler(int index) {
    _currentIndex = index;
    setState(() {
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _pages.add(MainHomePage());
    _pages.add(MainSecondPage());
    _pages.add(MainThirdPage());
    _pages.add(MainFourPage());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 1)) {
          _lastPressedAt = DateTime.now();
          AHChannel.showNativeToast(msg: "Press again to exit");
          return false;
        }
        // try {
        //   platform.invokeMethod("exitApp");
        // } catch (e) {
        //   logger(e.toString());
        // }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: R.color_3,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: sp(Sp.font_small),
          selectedItemColor: R.color_font_1,
          unselectedItemColor: R.color_font_1.withOpacity(0.2),
          unselectedFontSize: sp(Sp.font_small),
          currentIndex: _currentIndex,
          items: _buildBottomBarItems(),
          onTap: _onTapHandler,
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomBarItems() {
    return [
      _buildBottomNavigationBarItem(
          titleName: '首页',
          index: 0,
          icon: 'images/icon_no_wifi.png',
          selectedIcon: 'images/icon_nothing.png'),
      _buildBottomNavigationBarItem(
          titleName: '优选',
          index: 1,
          icon: 'images/icon_no_wifi.png',
          selectedIcon: 'images/icon_nothing.png'),
      _buildBottomNavigationBarItem(
          titleName: '消息',
          index: 2,
          icon: 'images/icon_no_wifi.png',
          selectedIcon: 'images/icon_nothing.png'),
      _buildBottomNavigationBarItem(
          titleName: '我的',
          index: 3,
          icon: 'images/icon_no_wifi.png',
          selectedIcon: 'images/icon_nothing.png'),
    ];
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      {required String titleName,
      int? index,
      String? selectedIcon,
      String? icon}) {
    return BottomNavigationBarItem(
        label: titleName,
        icon: Image.asset(
          _currentIndex == index ? selectedIcon! : icon!,
          width: 48.0,
          height: 34.0,
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
