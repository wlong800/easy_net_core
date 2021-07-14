import 'package:app/base/common/resource.dart';
import 'package:app/base/logger/logger.dart';
import 'package:app/base/widget/my_sliver_app_bar.dart';
import 'package:app/page/home/main_home_tab_page.dart';
import 'package:app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:underline_indicator/underline_indicator.dart';

/// 专题页（eg:古北水镇俩日游）
class SubjectPage extends StatefulWidget {
  const SubjectPage({Key? key}) : super(key: key);

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage>
    with TickerProviderStateMixin {
  AppBarStateChangeController _appBarStateChangeController =
      AppBarStateChangeController();
  late TabController _controller;
  bool _verticalOffsetZero = false;
  var tabs = ["古北水镇俩日游", "张北草原俩日游", "日光山谷露营", "日光山谷露营2"];
  var _bgColors = [
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.green,
    Colors.yellow,
    Colors.orange,
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
    _appBarStateChangeController.addListener(() {
      var verticalOffsetZero = _appBarStateChangeController.verticalOffsetZero;
      if (_verticalOffsetZero != verticalOffsetZero) {
        logger("verticalOffsetZero >>> $verticalOffsetZero");
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          //需要创建的小组件
          setState(() {});
        });
      }
      _verticalOffsetZero = verticalOffsetZero;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _appBarStateChangeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          logger("innerBoxIsScrolled : $innerBoxIsScrolled");
          return <Widget>[
            MySliverAppBar(
              appBarStateChangeController: _appBarStateChangeController,
              expandedHeight: 200.0,
              backgroundColor: R.color_1,
              brightness: Brightness.light,
              automaticallyImplyLeading: false,
              shadowColor: Colors.black,
              centerTitle: true,
              leading: Container(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: R.color_white,
                  size: 22.0,
                ),
                color: Colors.yellow,
              ),
              floating: true,
              snap: false,
              pinned: true,
              forceElevated: false,
              actions: [
                Icon(
                  Icons.access_alarms_sharp,
                  size: 22.0,
                  color: R.color_white,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.more_horiz,
                    size: 22.0,
                    color: R.color_white,
                  ),
                ),
              ],
              // bottom: _tabBar(),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                title:
                    Offstage(offstage: !_verticalOffsetZero, child: Text("标题")),
                centerTitle: true,
                stretchModes: [
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                  StretchMode.zoomBackground
                ],
                background: Container(
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/icon_nothing.png",
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                    ],
                  ),
                  color: _bgColors[_controller.index],
                ),
              ),
            ),
            // SliverPersistentHeader(
            //   delegate: _SliverAppBarDelegate(
            //     _tabBar(),
            //   ),
            //   pinned: true,
            // ),
          ];
        },
        body: TabBarView(
            controller: _controller,
            children: tabs.map((tab) {
              return MainHomeTabPage();
            }).toList()),
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
