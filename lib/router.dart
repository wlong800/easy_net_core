import 'package:app/base/common/logger.dart';
import 'package:app/page/complaint_of_user_page.dart';
import 'package:app/page/custom_contacts_add_page.dart';
import 'package:app/page/custom_contacts_page.dart';
import 'package:flutter/cupertino.dart';

Widget pushPageByRouter(String scheme) {
  logger("scheme: $scheme");
  if (scheme == "/contacts_add") {
    return CustomContactsAddPage(
      isSystemPop: true,
    );
  } else if (scheme == "/report") {
    return ComplaintOfUserPage();
  }
  return CustomContactsPage();
}
