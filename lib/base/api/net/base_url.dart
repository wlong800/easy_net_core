

String? baseUrl;

String getServiceUrl() {
  // if (isNotEmpty(baseUrl)) {
  //   if (!baseUrl!.endsWith("/")) baseUrl = baseUrl! + "/";
  //   return baseUrl;
  // }
  // logger("base url   ${Global.type}");
  // switch (Global.type) {
  //   case 0:
  //     return serviceUrl;
  //   case 1:
  //     return serviceUrlTest;
  //   case 2:
  //     return serviceUrlBate;
  //   default:
  //     return serviceUrl;
  // }
  return baseUrl ?? "https://fu.allhistory.com/";
}
