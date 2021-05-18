class HttpStatus2 {
  /// 自定义错误码
  static const int error_code = 10001;
  static const int ok = 20000;

  /// 第三方登录-请根据oauthId去第三方账号绑定邮箱页面，请求第三方账号绑定邮箱接口
  static const int status_30001 = 30001;

  /// 第三方登录-请根据oauthId和邮箱去邮箱绑定第三方页面，请求邮箱绑定第三方接口
  static const int status_30002 = 30002;

  /// 业务码-参数格式错误-会提示各种信息
  static const int status_40002 = 40002;

  /// 业务码-token失效
  static const int status_40000 = 40000;

  /// token失效
  static const int status_40001 = 40001;

  ///  推广码不正确
  static const int status_40004 = 40004;

  ///  重复领取了
  static const int status_40009 = 40009;

  /// 业务码-服务器内部逻辑错误
  static const int status_50000 = 50000;

  static const int status_50002 = 50002;

  /// 业务码-已经试用用过
  static const int status_50041 = 50041;

  /// 自定义code,用于端上给flutter数据，出错
  static const int status_90088 = 90088;
}
