import 'package:app/base/common/lang.dart';

class CommunityFeedModel {
  int? id;
  int? likeNum;
  int? commentNum;
  int? transmitNum;
  int? creatorId;
  String? createTime;
  String? updateTime;
  List<String>? tagIds;
  List<ImageObject>? images;
  List<ImageObject>? videos;
  String? title;
  int? voteId;
  String? activeStatus;
  int? hotNum;
  List<Content>? content;
  Creator? creator;
  bool? hasLiked;
  int? topicId;
  String? topicTitle;
  int? referenceId;
  String? referenceType;
  ReferenceData? referenceData;

  CommunityFeedModel(
      {this.id,
      this.likeNum,
      this.commentNum,
      this.transmitNum,
      this.creatorId,
      this.createTime,
      this.updateTime,
      this.tagIds,
      this.voteId,
      this.activeStatus,
      this.hotNum,
      this.content,
      this.creator,
      this.hasLiked,
      this.topicId,
      this.topicTitle,
      this.referenceId,
      this.referenceType,
      this.referenceData,
      this.images,
      this.videos,
      this.title});

  CommunityFeedModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    likeNum = json['likeNum'];
    commentNum = json['commentNum'];
    transmitNum = json['transmitNum'];
    creatorId = json['creatorId'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    if (json['tagIds'] != null) {
      tagIds = [];
      json['tagIds'].forEach((v) {
        tagIds?.add(v);
      });
    }
    voteId = json['voteId'];
    activeStatus = json['activeStatus'];
    hotNum = json['hotNum'];
    if (json['content'] != null) {
      content = [];
      json['content'].forEach((v) {
        content?.add(Content.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(ImageObject.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = [];
      json['videos'].forEach((v) {
        videos?.add(ImageObject.fromJson(v));
      });
    }
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    hasLiked = json['hasLiked'];
    topicId = json['topicId'];
    topicTitle = json['topicTitle'];
    referenceId = json['referenceId'];
    referenceType = json['referenceType'];
    referenceData = json['referenceData'] != null
        ? new ReferenceData.fromJson(json['referenceData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['likeNum'] = this.likeNum;
    data['commentNum'] = this.commentNum;
    data['transmitNum'] = this.transmitNum;
    data['creatorId'] = this.creatorId;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    if (this.tagIds != null) {
      data['tagIds'] = this.tagIds?.map((v) => v).toList();
    }
    data['voteId'] = this.voteId;
    data['activeStatus'] = this.activeStatus;
    data['hotNum'] = this.hotNum;
    if (this.content != null) {
      data['content'] = this.content?.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images?.map((v) => v.toJson()).toList();
    }
    if (this.videos != null) {
      data['videos'] = this.videos?.map((v) => v.toJson()).toList();
    }
    if (this.creator != null) {
      data['creator'] = this.creator?.toJson();
    }
    data['hasLiked'] = this.hasLiked;
    data['topicId'] = this.topicId;
    data['topicTitle'] = this.topicTitle;
    data['referenceId'] = this.referenceId;
    data['referenceType'] = this.referenceType;
    if (this.referenceData != null) {
      data['referenceData'] = this.referenceData?.toJson();
    }
    return data;
  }

  bool isImages() {
    return isNotEmpty(getImages());
  }

  bool isVideo() {
    return isNotEmpty(getVideos());
  }

  bool isContent() {
    return isNotEmpty(getTitle());
  }

  List<ImageObject>? getImages() {
    if (images != null) return images;
    if (content == null) return null;
    images = [];
    content?.forEach((element) {
      if ("IMAGE" == element.type) {
        images?.add(ImageObject(
            url: element.url, width: element.width, height: element.height));
      }
    });
    if (toInt(images?.length) == 4) {
      images?.insert(2, ImageObject());
    }
    return images;
  }

  List<String> getImagesUrl() {
    var urls = <String>[];
    getImages()?.forEach((element) {
      urls.add(element.url!);
    });
    return urls;
  }

  List<ImageObject>? getVideos() {
    if (videos != null) return videos;
    if (content == null) return null;
    videos = [];
    content?.forEach((element) {
      if ("VIDEO" == element.type) {
        videos?.add(ImageObject(
            url: element.url,
            width: element.width,
            height: element.height,
            thumb: element.thumb,
            duration: element.duration));
      }
    });
    return videos;
  }

  String? getTitle() {
    if (isEmpty(title)) {
      if (content == null) return title;
      content?.forEach((element) {
        if ("TEXT" == element.type) {
          title = element.text;
        }
      });
    }
    return title;
  }
}

class ImageObject {
  String? url;
  int? width;
  int? height;
  String? thumb;
  double? duration;

  ImageObject({this.url, this.width, this.height, this.thumb, this.duration});

  ImageObject.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
    thumb = json['thumb'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    data['thumb'] = this.thumb;
    data['duration'] = this.duration;
    return data;
  }
}

class Content {
  String? type;
  String? style;
  String? text;
  String? index;
  String? url;
  int? width;
  int? height;
  String? thumb;
  double? duration;

  Content(
      {this.type,
      this.style,
      this.text,
      this.index,
      this.url,
      this.width,
      this.height,
      this.thumb,
      this.duration});

  Content.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    style = json['style'];
    text = json['text'];
    index = json['index'];
    url = json['url'];
    width = json['width'];
    height = json['height'];
    thumb = json['thumb'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = this.type;
    data['style'] = this.style;
    data['text'] = this.text;
    data['index'] = this.index;
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    data['thumb'] = this.thumb;
    data['duration'] = this.duration;
    return data;
  }
}

class Creator {
  int? id;
  String? username;
  String? gender;
  Geo? geo;
  int? regionId;
  String? avatar;
  String? summary;

  Creator(
      {this.id,
      this.username,
      this.gender,
      this.geo,
      this.regionId,
      this.avatar,
      this.summary});

  Creator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    gender = json['gender'];
    geo = json['geo'] != null ? Geo.fromJson(json['geo']) : null;
    regionId = json['regionId'];
    avatar = json['avatar'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['gender'] = this.gender;
    if (this.geo != null) {
      data['geo'] = this.geo?.toJson();
    }
    data['regionId'] = this.regionId;
    data['avatar'] = this.avatar;
    data['summary'] = this.summary;
    return data;
  }

  String? getAvatar() {
    if (!isEmpty(avatar)) {
      return avatar?.startsWith("http") == true ? avatar : "https:$avatar";
    }
    return null;
  }

  String? getGenderImage() {
    if (gender == "MALE") {
      return "images/icon_activity_male.png";
    } else if (gender == "FEMALE") {
      return "images/icon_activity_female.png";
    }
    return null;
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

class ReferenceData {
  Post? post;
  Event? event;

  ReferenceData({this.post, this.event});

  ReferenceData.fromJson(Map<String, dynamic> json) {
    post = json['post'] != null ? Post.fromJson(json['post']) : null;
    event = json['event'] != null ? Event.fromJson(json['event']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.post != null) {
      data['post'] = this.post?.toJson();
    }
    return data;
  }
}

class Post {
  int? id;
  int? likeNum;
  int? commentNum;
  int? transmitNum;
  int? creatorId;
  String? createTime;
  String? updateTime;
  List<String>? tagIds;
  int? voteId;
  String? activeStatus;
  int? hotNum;
  List<CommunityFeedModel>? content;
  Creator? creator;
  bool? hasLiked;
  VoteInfo? voteInfo;

  Post(
      {this.id,
      this.likeNum,
      this.commentNum,
      this.transmitNum,
      this.creatorId,
      this.createTime,
      this.updateTime,
      this.tagIds,
      this.voteId,
      this.activeStatus,
      this.hotNum,
      this.content,
      this.creator,
      this.hasLiked,
      this.voteInfo});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    likeNum = json['likeNum'];
    commentNum = json['commentNum'];
    transmitNum = json['transmitNum'];
    creatorId = json['creatorId'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    if (json['tagIds'] != null) {
      tagIds = [];
      json['tagIds'].forEach((v) {
        tagIds?.add(v);
      });
    }
    voteId = json['voteId'];
    activeStatus = json['activeStatus'];
    hotNum = json['hotNum'];
    if (json['content'] != null) {
      content = [];
      json['content'].forEach((v) {
        content?.add(CommunityFeedModel.fromJson(v));
      });
    }
    creator =
        json['creator'] != null ? Creator.fromJson(json['creator']) : null;
    hasLiked = json['hasLiked'];
    voteInfo =
        json['voteInfo'] != null ? VoteInfo.fromJson(json['voteInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['likeNum'] = this.likeNum;
    data['commentNum'] = this.commentNum;
    data['transmitNum'] = this.transmitNum;
    data['creatorId'] = this.creatorId;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    if (this.tagIds != null) {
      data['tagIds'] = this.tagIds?.map((v) => v).toList();
    }
    data['voteId'] = this.voteId;
    data['activeStatus'] = this.activeStatus;
    data['hotNum'] = this.hotNum;
    if (this.content != null) {
      data['content'] = this.content?.map((v) => v.toJson()).toList();
    }
    if (this.creator != null) {
      data['creator'] = this.creator?.toJson();
    }
    data['hasLiked'] = this.hasLiked;
    if (this.voteInfo != null) {
      data['voteInfo'] = this.voteInfo?.toJson();
    }
    return data;
  }
}

class Event {
  int? id;
  String? title;
  String? sourceType;
  int? sourceId;
  int? importance;
  String? eventStartTime;
  String? eventEndTime;
  int? registrationFormId;
  String? registrationStartTime;
  String? registrationEndTime;
  String? coverUrl;
  String? bgColor;
  String? cardStyle;
  String? eventType;
  bool? onlineFlag;
  bool? ignoreRegionFlag;
  bool? onlySelfFlag;
  int? cityAreaId;
  Geo? geo;
  int? siteId;
  int? merchantId;
  int? productId;
  double? price;
  int? minOfPeople;
  int? maxOfMen;
  int? maxOfWomen;
  int? maxOfSecret;
  int? registeredOfflineOfMen;
  int? registeredOfflineOfWomen;
  int? registeredOnlineOfMen;
  int? registeredOnlineOfWomen;
  int? registeredOnlineOfSecret;
  String? groupStatus;
  String? summary;
  int? createBy;
  String? createTime;
  bool? needRegistration;
  String? activeStatus;
  String? groupQRCode;
  bool? allowCancelRegistration;
  String? eventTypeName;
  String? registrationStatus;
  Site? site;
  List<Tags>? tags;

  // List<RelatedTags>? relatedTags;

  Event(
      {this.id,
      this.title,
      this.sourceType,
      this.sourceId,
      this.importance,
      this.eventStartTime,
      this.eventEndTime,
      this.registrationFormId,
      this.registrationStartTime,
      this.registrationEndTime,
      this.coverUrl,
      this.bgColor,
      this.cardStyle,
      this.eventType,
      this.onlineFlag,
      this.ignoreRegionFlag,
      this.onlySelfFlag,
      this.cityAreaId,
      this.geo,
      this.siteId,
      this.merchantId,
      this.productId,
      this.price,
      this.minOfPeople,
      this.maxOfMen,
      this.maxOfWomen,
      this.maxOfSecret,
      this.registeredOfflineOfMen,
      this.registeredOfflineOfWomen,
      this.registeredOnlineOfMen,
      this.registeredOnlineOfWomen,
      this.registeredOnlineOfSecret,
      this.groupStatus,
      this.summary,
      this.createBy,
      this.createTime,
      this.needRegistration,
      this.activeStatus,
      this.groupQRCode,
      this.allowCancelRegistration,
      this.eventTypeName,
      this.registrationStatus,
      this.site,
      this.tags});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    sourceType = json['sourceType'];
    sourceId = json['sourceId'];
    importance = json['importance'];
    eventStartTime = json['eventStartTime'];
    eventEndTime = json['eventEndTime'];
    registrationFormId = json['registrationFormId'];
    registrationStartTime = json['registrationStartTime'];
    registrationEndTime = json['registrationEndTime'];
    coverUrl = json['coverUrl'];
    bgColor = json['bgColor'];
    cardStyle = json['cardStyle'];
    eventType = json['eventType'];
    onlineFlag = json['onlineFlag'];
    ignoreRegionFlag = json['ignoreRegionFlag'];
    onlySelfFlag = json['onlySelfFlag'];
    cityAreaId = json['cityAreaId'];
    geo = json['geo'] != null ? Geo.fromJson(json['geo']) : null;
    siteId = json['siteId'];
    merchantId = json['merchantId'];
    productId = json['productId'];
    price = json['price'];
    minOfPeople = json['minOfPeople'];
    maxOfMen = json['maxOfMen'];
    maxOfWomen = json['maxOfWomen'];
    maxOfSecret = json['maxOfSecret'];
    registeredOfflineOfMen = json['registeredOfflineOfMen'];
    registeredOfflineOfWomen = json['registeredOfflineOfWomen'];
    registeredOnlineOfMen = json['registeredOnlineOfMen'];
    registeredOnlineOfWomen = json['registeredOnlineOfWomen'];
    registeredOnlineOfSecret = json['registeredOnlineOfSecret'];
    groupStatus = json['groupStatus'];
    summary = json['summary'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    needRegistration = json['needRegistration'];
    activeStatus = json['activeStatus'];
    groupQRCode = json['groupQRCode'];
    allowCancelRegistration = json['allowCancelRegistration'];
    eventTypeName = json['eventTypeName'];
    registrationStatus = json['registrationStatus'];
    site = json['site'] != null ? new Site.fromJson(json['site']) : null;
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags?.add(Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['sourceType'] = this.sourceType;
    data['sourceId'] = this.sourceId;
    data['importance'] = this.importance;
    data['eventStartTime'] = this.eventStartTime;
    data['eventEndTime'] = this.eventEndTime;
    data['registrationFormId'] = this.registrationFormId;
    data['registrationStartTime'] = this.registrationStartTime;
    data['registrationEndTime'] = this.registrationEndTime;
    data['coverUrl'] = this.coverUrl;
    data['bgColor'] = this.bgColor;
    data['cardStyle'] = this.cardStyle;
    data['eventType'] = this.eventType;
    data['onlineFlag'] = this.onlineFlag;
    data['ignoreRegionFlag'] = this.ignoreRegionFlag;
    data['onlySelfFlag'] = this.onlySelfFlag;
    data['cityAreaId'] = this.cityAreaId;
    if (this.geo != null) {
      data['geo'] = this.geo?.toJson();
    }
    data['siteId'] = this.siteId;
    data['merchantId'] = this.merchantId;
    data['productId'] = this.productId;
    data['price'] = this.price;
    data['minOfPeople'] = this.minOfPeople;
    data['maxOfMen'] = this.maxOfMen;
    data['maxOfWomen'] = this.maxOfWomen;
    data['maxOfSecret'] = this.maxOfSecret;
    data['registeredOfflineOfMen'] = this.registeredOfflineOfMen;
    data['registeredOfflineOfWomen'] = this.registeredOfflineOfWomen;
    data['registeredOnlineOfMen'] = this.registeredOnlineOfMen;
    data['registeredOnlineOfWomen'] = this.registeredOnlineOfWomen;
    data['registeredOnlineOfSecret'] = this.registeredOnlineOfSecret;
    data['groupStatus'] = this.groupStatus;
    data['summary'] = this.summary;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['needRegistration'] = this.needRegistration;
    data['activeStatus'] = this.activeStatus;
    data['groupQRCode'] = this.groupQRCode;
    data['allowCancelRegistration'] = this.allowCancelRegistration;
    data['eventTypeName'] = this.eventTypeName;
    data['registrationStatus'] = this.registrationStatus;
    if (this.site != null) {
      data['site'] = this.site?.toJson();
    }
    if (this.tags != null) {
      data['tags'] = this.tags?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Site {
  int? id;
  String? name;
  String? cover;
  int? merchantId;
  String? address;
  String? gps;
  int? attentionType;
  List<String>? phones;

  Site(
      {this.id,
      this.name,
      this.cover,
      this.merchantId,
      this.address,
      this.gps,
      this.attentionType,
      this.phones});

  Site.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cover = json['cover'];
    merchantId = json['merchantId'];
    address = json['address'];
    gps = json['gps'];
    attentionType = json['attentionType'];
    phones = json['phones'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cover'] = this.cover;
    data['merchantId'] = this.merchantId;
    data['address'] = this.address;
    data['gps'] = this.gps;
    data['attentionType'] = this.attentionType;
    data['phones'] = this.phones;
    return data;
  }
}

class Tags {
  int? id;
  String? name;
  String? abbreviation;
  int? categoryId;
  String? module;

  Tags({this.id, this.name, this.abbreviation, this.categoryId, this.module});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    abbreviation = json['abbreviation'];
    categoryId = json['categoryId'];
    module = json['module'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['abbreviation'] = this.abbreviation;
    data['categoryId'] = this.categoryId;
    data['module'] = this.module;
    return data;
  }
}

class VoteInfo {
  int? id;
  String? introduction;
  int? maxOfChoice;
  int? choiceType;
  String? deadline;
  String? style;
  int? headcount;
  int? userCount;
  List<Options>? options;
  bool? hasParticipated;
  int? betStatus;

  VoteInfo(
      {this.id,
      this.introduction,
      this.maxOfChoice,
      this.choiceType,
      this.deadline,
      this.style,
      this.headcount,
      this.userCount,
      this.options,
      this.hasParticipated,
      this.betStatus});

  VoteInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    introduction = json['introduction'];
    maxOfChoice = json['maxOfChoice'];
    choiceType = json['choiceType'];
    deadline = json['deadline'];
    style = json['style'];
    headcount = json['headcount'];
    userCount = json['userCount'];
    if (json['options'] != null) {
      options = [];
      json['options'].forEach((v) {
        options?.add(Options.fromJson(v));
      });
    }
    hasParticipated = json['hasParticipated'];
    betStatus = json['betStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['introduction'] = this.introduction;
    data['maxOfChoice'] = this.maxOfChoice;
    data['choiceType'] = this.choiceType;
    data['deadline'] = this.deadline;
    data['style'] = this.style;
    data['headcount'] = this.headcount;
    data['userCount'] = this.userCount;
    if (this.options != null) {
      data['options'] = this.options?.map((v) => v.toJson()).toList();
    }
    data['hasParticipated'] = this.hasParticipated;
    data['betStatus'] = this.betStatus;
    return data;
  }
}

class Options {
  int? id;
  int? voteId;
  String? optionName;
  String? optionImageUrl;
  int? optionNum;
  int? headcount;
  bool? selectOption;

  Options(
      {this.id,
      this.voteId,
      this.optionName,
      this.optionImageUrl,
      this.optionNum,
      this.headcount,
      this.selectOption});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voteId = json['voteId'];
    optionName = json['optionName'];
    optionImageUrl = json['optionImageUrl'];
    optionNum = json['optionNum'];
    headcount = json['headcount'];
    selectOption = json['selectOption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['voteId'] = this.voteId;
    data['optionName'] = this.optionName;
    data['optionImageUrl'] = this.optionImageUrl;
    data['optionNum'] = this.optionNum;
    data['headcount'] = this.headcount;
    data['selectOption'] = this.selectOption;
    return data;
  }
}
