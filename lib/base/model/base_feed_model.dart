import 'package:flutter/material.dart';

import 'base_parse.dart';

class BaseDataResponse {
  int? page;
  int? size;
  int? totalPages;
  int? totalElements;
  dynamic content;

  BaseDataResponse(
      {this.page,
      this.size,
      this.totalPages,
      this.totalElements,
      this.content});

  BaseDataResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    size = json['size'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['size'] = this.size;
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['content'] = this.content;
    return data;
  }
}
