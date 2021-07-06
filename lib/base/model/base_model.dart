import 'package:flutter/material.dart';

import 'base_parse.dart';

typedef S ItemCreator<S>();

class BaseModel<T extends BaseParse> {
  ItemCreator<T>? creator;
  int? code;
  String? message;
  T? data;

  BaseModel({@required this.creator, this.code, this.message, this.data});

  BaseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? creator!() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}
