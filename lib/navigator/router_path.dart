///定义路由数据，path & params  ---->（1）<----
class MyRoutePath {
  static const MAIN_PATH = "/";
  static const DETAIL_PATH = "detail";
  static const CENTER_PATH = "center";
  static const TOPICS_PATH = "topics";
  static const SETTING_PATH = "setting";
  static const TEST1_PATH = "test1";
  static const TEST2_PATH = "test2";
  static const SEARCH_PATH = "search";
  static const UNKNOWN_PATH = "unknown";

  // final String location;
  // final Map<String, dynamic>? params;
  //
  // ///主页面
  // MyRoutePath.main({this.params}) : location = MAIN_PATH;
  //
  // ///详情页
  // MyRoutePath.detail({this.params}) : location = DETAIL_PATH;
  //
  // ///个人中心页
  // MyRoutePath.center({this.params}) : location = CENTER_PATH;
  //
  // ///帖子聚合页
  // MyRoutePath.topics({this.params}) : location = TOPICS_PATH;
  //
  // ///Setting页
  // MyRoutePath.setting({this.params}) : location = SETTING_PATH;
  //
  // ///test1页
  // MyRoutePath.test1({this.params}) : location = TEST1_PATH;
  //
  // ///test2页
  // MyRoutePath.test2({this.params}) : location = TEST2_PATH;
  //
  // ///搜索页面
  // MyRoutePath.search({this.params}) : location = SEARCH_PATH;
  //
  // /// 404页面
  // MyRoutePath.unknown()
  //     : location = UNKNOWN_PATH,
  //       params = null;
}
