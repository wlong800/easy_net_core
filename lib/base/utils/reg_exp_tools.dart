
///大陆手机号码11位数，匹配格式：前三位固定格式+后8位任意数
/// 此方法中前三位格式有：
/// 13+任意数 * 15+除4的任意数 * 18+除1和4的任意数 * 17+除9的任意数 * 147
bool isChinaPhoneLegal(String str) {
  return new RegExp(
          '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
      .hasMatch(str);
}

///电话号码：1开头，后面10位数字
bool isPhone(String input) {
  RegExp mobile = new RegExp(r"1[0-9]\d{9}$");
  return mobile.hasMatch(input);
}

///登录密码：6~16位
bool validatePwd(String input) {
  RegExp mobile = new RegExp(r"^\S{6,12}$");
  return mobile.hasMatch(input);
}

///6位数字验证码
bool isValidateCaptcha(String input) {
  RegExp mobile = new RegExp(r"^\S{6,12}$");
  return mobile.hasMatch(input);
}

//带校验的身份证
bool isCardId(String cardId) {
  if (cardId.length != 18) {
    return false; // 位数不够
  }
  // 身份证号码正则
  RegExp postalCode = new RegExp(
      r'^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|[Xx])$');
  // 通过验证，说明格式正确，但仍需计算准确性
  if (!postalCode.hasMatch(cardId)) {
    return false;
  }
  //将前17位加权因子保存在数组里
  final List idCardList = [
    "7",
    "9",
    "10",
    "5",
    "8",
    "4",
    "2",
    "1",
    "6",
    "3",
    "7",
    "9",
    "10",
    "5",
    "8",
    "4",
    "2"
  ];
  //这是除以11后，可能产生的11位余数、验证码，也保存成数组
  final List idCardYArray = [
    '1',
    '0',
    '10',
    '9',
    '8',
    '7',
    '6',
    '5',
    '4',
    '3',
    '2'
  ];
  // 前17位各自乖以加权因子后的总和
  int idCardWiSum = 0;

  for (int i = 0; i < 17; i++) {
    int subStrIndex = int.parse(cardId.substring(i, i + 1));
    int idCardWiIndex = int.parse(idCardList[i]);
    idCardWiSum += subStrIndex * idCardWiIndex;
  }
  // 计算出校验码所在数组的位置
  int idCardMod = idCardWiSum % 11;
  // 得到最后一位号码
  String idCardLast = cardId.substring(17, 18);
  //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
  if (idCardMod == 2) {
    if (idCardLast != 'x' && idCardLast != 'X') {
      return false;
    }
  } else {
    //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
    if (idCardLast != idCardYArray[idCardMod]) {
      return false;
    }
  }
  return true;
}

bool validateEmailExp(String email) {
 RegExp regExp = new RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$");
 return regExp.hasMatch(email);
}
