class UserInfoModel {
  int? id;
  String? username;
  String? phone;
  String? gender;
  List<String>? userIdentity;
  String? initials;
  String? spelling;
  String? imUid;
  String? imPwd;
  int? fansCount;
  int? followsCount;
  int? tidingsCount;
  bool? hasFollowed;
  int? goldCoin;
  bool? profileInit;
  bool? infoEdited;
  bool? officialAccountFollowed;
  int? wanmeiSyncState;
  String? feedbackAction;
  bool? kol;
  Geo? geo;
  List<int>? customServiceIds;
  List<String>? photos;

  UserInfoModel(
      {this.id,
      this.username,
      this.phone,
      this.gender,
      this.userIdentity,
      this.initials,
      this.spelling,
      this.imUid,
      this.imPwd,
      this.fansCount,
      this.followsCount,
      this.tidingsCount,
      this.hasFollowed,
      this.goldCoin,
      this.profileInit,
      this.infoEdited,
      this.officialAccountFollowed,
      this.wanmeiSyncState,
      this.feedbackAction,
      this.kol,
      this.geo,
      this.customServiceIds,
      this.photos});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    phone = json['phone'];
    gender = json['gender'];
    if (json['userIdentity'] != null) {
      userIdentity = [];
      json['userIdentity'].forEach((v) {
        userIdentity?.add(v);
      });
    }
    initials = json['initials'];
    spelling = json['spelling'];
    imUid = json['imUid'];
    imPwd = json['imPwd'];
    fansCount = json['fansCount'];
    followsCount = json['followsCount'];
    tidingsCount = json['tidingsCount'];
    hasFollowed = json['hasFollowed'];
    goldCoin = json['goldCoin'];
    profileInit = json['profileInit'];
    infoEdited = json['infoEdited'];
    officialAccountFollowed = json['officialAccountFollowed'];
    wanmeiSyncState = json['wanmeiSyncState'];
    feedbackAction = json['feedbackAction'];
    kol = json['kol'];
    geo = json['geo'] != null ? new Geo.fromJson(json['geo']) : null;
    customServiceIds = json['customServiceIds'].cast<int>();
    photos = json['photos'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    if (this.userIdentity != null) {
      data['userIdentity'] = this.userIdentity?.map((v) => v).toList();
    }
    data['initials'] = this.initials;
    data['spelling'] = this.spelling;
    data['imUid'] = this.imUid;
    data['imPwd'] = this.imPwd;
    data['fansCount'] = this.fansCount;
    data['followsCount'] = this.followsCount;
    data['tidingsCount'] = this.tidingsCount;
    data['hasFollowed'] = this.hasFollowed;
    data['goldCoin'] = this.goldCoin;
    data['profileInit'] = this.profileInit;
    data['infoEdited'] = this.infoEdited;
    data['officialAccountFollowed'] = this.officialAccountFollowed;
    data['wanmeiSyncState'] = this.wanmeiSyncState;
    data['feedbackAction'] = this.feedbackAction;
    data['kol'] = this.kol;
    if (this.geo != null) {
      data['geo'] = this.geo?.toJson();
    }
    data['customServiceIds'] = this.customServiceIds;
    data['photos'] = this.photos;
    return data;
  }
}

class Geo {
  double? lat;
  double? lon;

  Geo({this.lat, this.lon});

  Geo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}
