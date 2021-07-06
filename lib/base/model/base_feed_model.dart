import 'package:flutter/material.dart';

import 'base_parse.dart';

typedef S ItemCreator<S>();

class BaseFeedModel<T extends BaseParse> {
  ItemCreator<T>? creator;

  int? page;
  int? size;
  int? totalPages;
  int? totalElements;
  List<T>? content;

  BaseFeedModel(
      {@required this.creator,
      this.page,
      this.size,
      this.totalPages,
      this.totalElements,
      this.content});

  BaseFeedModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    size = json['size'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    if (json['content'] != null) {
      content = [];
      json['content'].forEach((v) {
        content?.add(creator!());
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['size'] = this.size;
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    if (this.content != null) {
      data['content'] = this.content?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
