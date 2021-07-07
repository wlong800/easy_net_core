import 'package:app/base/common/lang.dart';

class CommunityFeedModel {
  String? id;
  String? likeNum;
  String? commentNum;
  String? transmitNum;
  String? creatorId;
  String? createTime;
  String? updateTime;
  List<String>? tagIds;
  List<ImageObject>? images;
  List<ImageObject>? videos;
  String? title;
  String? voteId;
  String? activeStatus;
  String? hotNum;
  List<Content>? content;
  Creator? creator;
  String? hasLiked;
  String? topicId;
  String? topicTitle;
  String? referenceId;
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
    id = toString2(json['id']);
    title = toString2(json['title']);
    likeNum = toString2(json['likeNum']);
    commentNum = toString2(json['commentNum']);
    transmitNum = toString2(json['transmitNum']);
    creatorId = toString2(json['creatorId']);
    createTime = toString2(json['createTime']);
    updateTime = toString2(json['updateTime']);
    if (json['tagIds'] != null) {
      tagIds = [];
      json['tagIds'].forEach((v) {
        tagIds?.add(v);
      });
    }
    voteId = toString2(json['voteId']);
    activeStatus = toString2(json['activeStatus']);
    hotNum = toString2(json['hotNum']);
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
    hasLiked = toString2(json['hasLiked']);
    topicId = toString2(json['topicId']);
    topicTitle = toString2(json['topicTitle']);
    referenceId = toString2(json['referenceId']);
    referenceType = toString2(json['referenceType']);
    referenceData = json['referenceData'] != null
        ? ReferenceData.fromJson(json['referenceData'])
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
  String? width;
  String? height;
  String? thumb;
  String? duration;

  ImageObject({this.url, this.width, this.height, this.thumb, this.duration});

  ImageObject.fromJson(Map<String, dynamic> json) {
    url = toString2(json['url']);
    width = toString2(json['width']);
    height = toString2(json['height']);
    thumb = toString2(json['thumb']);
    duration = toString2(json['duration']);
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
  String? width;
  String? height;
  String? thumb;
  String? duration;

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
    type = toString2(json['type']);
    style = toString2(json['style']);
    text = toString2(json['text']);
    index = toString2(json['index']);
    url = toString2(json['url']);
    width = toString2(json['width']);
    height = toString2(json['height']);
    thumb = toString2(json['thumb']);
    duration = toString2(json['duration']);
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
  String? id;
  String? username;
  String? gender;
  Geo? geo;
  String? regionId;
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
    id = toString2(json['id']);
    username = toString2(json['username']);
    gender = toString2(json['gender']);
    geo = json['geo'] != null ? Geo.fromJson(json['geo']) : null;
    regionId = toString2(json['regionId']);
    avatar = toString2(json['avatar']);
    summary = toString2(json['summary']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  String? lat;
  String? lon;

  Geo({this.lat, this.lon});

  Geo.fromJson(Map<String, dynamic> json) {
    lat = toString2(json['lat']);
    lon = toString2(json['lon']);
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
  String? id;
  String? likeNum;
  String? commentNum;
  String? transmitNum;
  String? creatorId;
  String? createTime;
  String? updateTime;
  List<String>? tagIds;
  String? voteId;
  String? activeStatus;
  String? hotNum;
  List<CommunityFeedModel>? content;
  Creator? creator;
  String? hasLiked;
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
    id = toString2(json['id']);
    likeNum = toString2(json['likeNum']);
    commentNum = toString2(json['commentNum']);
    transmitNum = toString2(json['transmitNum']);
    creatorId = toString2(json['creatorId']);
    createTime = toString2(json['createTime']);
    updateTime = toString2(json['updateTime']);
    if (json['tagIds'] != null) {
      tagIds = [];
      json['tagIds'].forEach((v) {
        tagIds?.add(v);
      });
    }
    voteId = toString2(json['voteId']);
    activeStatus = toString2(json['activeStatus']);
    hotNum = toString2(json['hotNum']);
    if (json['content'] != null) {
      content = [];
      json['content'].forEach((v) {
        content?.add(CommunityFeedModel.fromJson(v));
      });
    }
    creator =
        json['creator'] != null ? Creator.fromJson(json['creator']) : null;
    hasLiked = toString2(json['hasLiked']);
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
  String? id;
  String? title;
  String? sourceType;
  String? sourceId;
  String? importance;
  String? eventStartTime;
  String? eventEndTime;
  String? registrationFormId;
  String? registrationStartTime;
  String? registrationEndTime;
  String? coverUrl;
  String? bgColor;
  String? cardStyle;
  String? eventType;
  String? onlineFlag;
  String? ignoreRegionFlag;
  String? onlySelfFlag;
  String? cityAreaId;
  Geo? geo;
  String? siteId;
  String? merchantId;
  String? productId;
  String? price;
  String? minOfPeople;
  String? maxOfMen;
  String? maxOfWomen;
  String? maxOfSecret;
  String? registeredOfflineOfMen;
  String? registeredOfflineOfWomen;
  String? registeredOnlineOfMen;
  String? registeredOnlineOfWomen;
  String? registeredOnlineOfSecret;
  String? groupStatus;
  String? summary;
  String? createBy;
  String? createTime;
  String? needRegistration;
  String? activeStatus;
  String? groupQRCode;
  String? allowCancelRegistration;
  String? eventTypeName;
  String? registrationStatus;
  Site? site;
  List<Tags>? tags;

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
    id = toString2(json['id']);
    title = toString2(json['title']);
    sourceType = toString2(json['sourceType']);
    sourceId = toString2(json['sourceId']);
    importance = toString2(json['importance']);
    eventStartTime = toString2(json['eventStartTime']);
    eventEndTime = toString2(json['eventEndTime']);
    registrationFormId = toString2(json['registrationFormId']);
    registrationStartTime = toString2(json['registrationStartTime']);
    registrationEndTime = toString2(json['registrationEndTime']);
    coverUrl = toString2(json['coverUrl']);
    bgColor = toString2(json['bgColor']);
    cardStyle = toString2(json['cardStyle']);
    eventType = toString2(json['eventType']);
    onlineFlag = toString2(json['onlineFlag']);
    ignoreRegionFlag = toString2(json['ignoreRegionFlag']);
    onlySelfFlag = toString2(json['onlySelfFlag']);
    cityAreaId = toString2(json['cityAreaId']);
    geo = json['geo'] != null ? Geo.fromJson(json['geo']) : null;
    siteId = toString2(json['siteId']);
    merchantId = toString2(json['merchantId']);
    productId = toString2(json['productId']);
    price = toString2(json['price']);
    minOfPeople = toString2(json['minOfPeople']);
    maxOfMen = toString2(json['maxOfMen']);
    maxOfWomen = toString2(json['maxOfWomen']);
    maxOfSecret = toString2(json['maxOfSecret']);
    registeredOfflineOfMen = toString2(json['registeredOfflineOfMen']);
    registeredOfflineOfWomen = toString2(json['registeredOfflineOfWomen']);
    registeredOnlineOfMen = toString2(json['registeredOnlineOfMen']);
    registeredOnlineOfWomen = toString2(json['registeredOnlineOfWomen']);
    registeredOnlineOfSecret = toString2(json['registeredOnlineOfSecret']);
    groupStatus = toString2(json['groupStatus']);
    summary = toString2(json['summary']);
    createBy = toString2(json['createBy']);
    createTime = toString2(json['createTime']);
    needRegistration = toString2(json['needRegistration']);
    activeStatus = toString2(json['activeStatus']);
    groupQRCode = toString2(json['groupQRCode']);
    allowCancelRegistration = toString2(json['allowCancelRegistration']);
    eventTypeName = toString2(json['eventTypeName']);
    registrationStatus = toString2(json['registrationStatus']);
    site = json['site'] != null ? Site.fromJson(json['site']) : null;
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
  String? id;
  String? name;
  String? cover;
  String? merchantId;
  String? address;
  String? gps;
  String? attentionType;
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
    id = toString2(json['id']);
    name = toString2(json['name']);
    cover = toString2(json['cover']);
    merchantId = toString2(json['merchantId']);
    address = toString2(json['address']);
    gps = toString2(json['gps']);
    attentionType = toString2(json['attentionType']);
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
  String? id;
  String? name;
  String? abbreviation;
  String? categoryId;
  String? module;

  Tags({this.id, this.name, this.abbreviation, this.categoryId, this.module});

  Tags.fromJson(Map<String, dynamic> json) {
    id = toString2(json['id']);
    name = toString2(json['name']);
    abbreviation = toString2(json['abbreviation']);
    categoryId = toString2(json['categoryId']);
    module = toString2(json['module']);
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
  String? id;
  String? introduction;
  String? maxOfChoice;
  String? choiceType;
  String? deadline;
  String? style;
  String? headcount;
  String? userCount;
  List<Options>? options;
  String? hasParticipated;
  String? betStatus;

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
    id = toString2(json['id']);
    introduction = toString2(json['introduction']);
    maxOfChoice = toString2(json['maxOfChoice']);
    choiceType = toString2(json['choiceType']);
    deadline = toString2(json['deadline']);
    style = toString2(json['style']);
    headcount = toString2(json['headcount']);
    userCount = toString2(json['userCount']);
    if (json['options'] != null) {
      options = [];
      json['options'].forEach((v) {
        options?.add(Options.fromJson(v));
      });
    }
    hasParticipated = toString2(json['hasParticipated']);
    betStatus = toString2(json['betStatus']);
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
  String? id;
  String? voteId;
  String? optionName;
  String? optionImageUrl;
  String? optionNum;
  String? headcount;
  String? selectOption;

  Options(
      {this.id,
      this.voteId,
      this.optionName,
      this.optionImageUrl,
      this.optionNum,
      this.headcount,
      this.selectOption});

  Options.fromJson(Map<String, dynamic> json) {
    id = toString2(json['id']);
    voteId = toString2(json['voteId']);
    optionName = toString2(json['optionName']);
    optionImageUrl = toString2(json['optionImageUrl']);
    optionNum = toString2(json['optionNum']);
    headcount = toString2(json['headcount']);
    selectOption = toString2(json['selectOption']);
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
