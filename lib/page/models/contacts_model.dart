import 'package:app/base/common/lang.dart';

class ContactsModel {
  String? contactAddr;
  String? contactEmail;
  String? contactIdNo;
  String? contactMobile;
  String? contactName;
  int? id;

  ContactsModel(
      {this.contactAddr,
      this.contactEmail,
      this.contactIdNo,
      this.contactMobile,
      this.contactName,
      this.id});

  ContactsModel.fromJson(Map<String, dynamic> json) {
    contactAddr = json['contactAddr'];
    contactEmail = json['contactEmail'];
    contactIdNo = json['contactIdNo'];
    contactMobile = json['contactMobile'];
    contactName = json['contactName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contactAddr'] = this.contactAddr;
    data['contactEmail'] = this.contactEmail;
    data['contactIdNo'] = this.contactIdNo;
    data['contactMobile'] = this.contactMobile;
    data['contactName'] = this.contactName;
    data['id'] = this.id;
    return data;
  }

  String getContactsIDCard() {
    return getHideCenterText(toString2(contactIdNo));
  }

  String getContactsPhone() {
    return getHideCenterText(toString2(contactMobile));
  }
}
