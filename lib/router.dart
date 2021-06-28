import 'dart:convert';

import 'package:app/base/logger/logger.dart';
import 'package:app/page/complaint_of_user_page.dart';
import 'package:app/page/custom_contacts_add_page.dart';
import 'package:app/page/custom_contacts_page.dart';
import 'package:app/page/user_ttal_set_page.dart';
import 'package:flutter/cupertino.dart';

Widget pushPageByRouter(String router) {
  logger("router: $router");
  Uri uri = Uri.parse(router);
  String host = uri.host;
  String scheme = uri.scheme;
  logger("scheme: $scheme");
  if (!inWhiteList(scheme)) {
    return Container(
      child: Center(child: Text("illegal scheme ..., $scheme")),
    );
  }
  switch (host) {
    case "contacts_add":
      return CustomContactsAddPage(
        isSystemPop: true,
      );
    case "report":
      return ComplaintOfUserPage();
    case "user_ttal_set":
      var questions = uri.queryParameters.containsKey("params")
          ? json.decode(uri.queryParameters['params']!)
          : null;
      logger("questions: $questions");
      return UserTTALSetPage(
        questions: questions,
      );
    case "contacts_list":
      return CustomContactsPage();
  }
  return Container(
    child: Center(child: Text("scheme is not match.... , $scheme")),
  );
}

bool inWhiteList(String scheme) {
  //最终是个白名单列表
  return scheme == "wmactivity";
}
