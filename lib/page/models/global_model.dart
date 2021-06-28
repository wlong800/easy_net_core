class GlobalInfo {
  int? appBarHeight;
  String? baseUrl;

  GlobalInfo({this.appBarHeight, this.baseUrl});

  GlobalInfo.fromJson(Map<String, dynamic> json) {
    appBarHeight = json['appBarHeight'];
    baseUrl = json['baseUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appBarHeight'] = this.appBarHeight;
    data['baseUrl'] = this.baseUrl;
    return data;
  }
}
