class GussExampleModel {
  String? title;
  List<String>? subData;

  GussExampleModel({this.title, this.subData});

  GussExampleModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subData = json['subData'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subData'] = this.subData;
    return data;
  }
}
