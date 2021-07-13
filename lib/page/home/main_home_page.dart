import 'package:app/base/common/resource.dart';
import 'package:app/base/widget/common_ui_kit.dart';
import 'package:app/page/home/main_home_tab_page.dart';
import 'package:app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:underline_indicator/underline_indicator.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage>
    with TickerProviderStateMixin {
  late TabController _controller;
  var tabs = ["关注", "推荐", "北京周边", "暑期游", "日然", "游玩", "运动", "艺术"];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WMPreferredSize2(
        "123",
        leading: false,
        titleWidget: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 5.0),
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  Text(
                    "北京",
                    style: TextStyle(
                        color: R.color_font_1, fontSize: sp(Sp.font_big)),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                    decoration: MyBoxDecoration.all(
                        radius: 18.0, color: R.color_d8d8d8.withOpacity(0.8)),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    height: 36.0,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 22.0,
                          color: R.color_font_2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            "海坨山露营",
                            style: TextStyle(
                                color: R.color_font_2,
                                fontSize: sp(Sp.font_middle2)),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 5.0),
              alignment: Alignment.bottomCenter,
              child: Icon(
                Icons.add_a_photo,
                size: 32.0,
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: _tabBar(),
          ),
          Flexible(
              child: TabBarView(
                  controller: _controller,
                  children: tabs.map((tab) {
                    return MainHomeTabPage();
                  }).toList()))
        ],
      ),
    );
  }

  ///自定义顶部tab
  _tabBar() {
    return TabBar(
        controller: _controller,
        isScrollable: true,
        labelColor: Colors.black,
        indicator: UnderlineIndicator(
            strokeCap: StrokeCap.round,
            borderSide: BorderSide(color: primary, width: 3),
            insets: EdgeInsets.only(left: 15, right: 15)),
        tabs: tabs.map<Tab>((tab) {
          return Tab(
              child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Text(
              tab,
              style: TextStyle(fontSize: 16),
            ),
          ));
        }).toList());
  }

  bool get wantKeepAlive => true;
}
