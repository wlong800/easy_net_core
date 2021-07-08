
import 'package:app/base/common/resource.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const String QUOTE_START_LABEL = "=={";
const String QUOTE_END_LABEL = "}==";

typedef int UserSpanAction(UserInfo userInfo);
class QuoteUtil {
    static RichText buildUserQuoteText(String str, UserSpanAction action) {
        var textSpans = <TextSpan>[];
        var index = 0;
        var startIndex = 0;
        while (startIndex >= 0 && startIndex < str.length) {
            startIndex = str.indexOf(QUOTE_START_LABEL, index);

            if (startIndex > 0)
                textSpans.add(_buildNormalTextSpan(str.substring(index, startIndex)));
            else if (startIndex < 0) {
                textSpans.add(_buildNormalTextSpan(str.substring(index)));
                break;
            }
            index = startIndex + 3;
            var endIndex = _findEndLabel(str, index, textSpans, action);
            if (endIndex < 0 && index < str.length) {
                textSpans.add(_buildNormalTextSpan(str.substring(index)));
                break;
            } else if (index >= str.length)
                break;
            index = endIndex;
        }
        return RichText(
            text: TextSpan(
                children: textSpans
            )
        );
    }

    static int _findEndLabel(String str, int start, List<TextSpan> items, UserSpanAction action) {
        var endIndex = str.indexOf(QUOTE_END_LABEL, start);
        if (endIndex > 0) {
            var userInfo = _checkUserInfo(str, start, endIndex);
            if (userInfo != null) {
                items.add(_buildUserTextSpan(userInfo, action));
                return endIndex + 3;
            } else {
                items.add(_buildNormalTextSpan(QUOTE_START_LABEL));
                return start;
            }
        }
        return -1;
    }

    static UserInfo? _checkUserInfo(String str, int start, int end){
        var content = str.substring(start, end);
        var values = content.split(",");
        if (values.length > 1) {
        try {
            return UserInfo(int.parse(values[0]), values[1]);
        } catch (Exception) {
        }
        }
        return null;
    }

    static TextSpan _buildNormalTextSpan(String str, {Color textColor = R.color_font_1, double fontSize = Sp.font_big}) {
        return TextSpan(
            text: str,
            style: TextStyle(
                color: textColor,
                fontSize: sp(fontSize)
            )
        );
    }

    static TextSpan _buildUserTextSpan(UserInfo userInfo, UserSpanAction action, {Color textColor = R.color_ff9932, double fontSize = Sp.font_big}) {
        return TextSpan(
            text: "//@${userInfo.name}",
            style: TextStyle(
                color: textColor,
                fontSize: sp(fontSize)
            ),
            recognizer: TapGestureRecognizer()
                ..onTap = (){
                    action.call(userInfo);
                }
        );
    }
}

class UserInfo {
    int id;
    String name;
    UserInfo(this.id, this.name){}
}