import 'base/api/net/base_url.dart';

class ServicePath {
  static String getContacts = getServiceUrl() +
      'api/m/future/mall/portal/user/contact/list'; // 获取常用联系人
  static String updateContacts = getServiceUrl() +
      'api/m/future/mall/portal/user/contact/save'; // 保存常用联系人
  static String deleteContacts = getServiceUrl() +
      'api/m/future/mall/portal/user/contact'; // 删除常用联系人


}
