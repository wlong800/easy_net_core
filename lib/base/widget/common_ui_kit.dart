import 'dart:io';
import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/base/common/touch_callback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 公共控件前期全部放到这，后期随着页面增多，抽离

/// 标题栏
class AFPreferredSize extends PreferredSize {
  final String title;
  final bool leading;
  final bool isSystemPop;
  final VoidCallback? callback;
  final VoidCallback? leadingCallback;
  final String? rightText;
  final Widget? rightWidget;
  final Color bgColor;
  final Color titleColor;
  final double titleSize;
  final bool titleBold;
  final Widget? titleWidget;
  final Widget? leadingWidget;
  final double elevation;
  final double height;
  final Brightness brightness;

  AFPreferredSize(this.title,
      {this.leading = true,
      this.isSystemPop = false,
      this.callback,
      this.rightText,
      this.rightWidget,
      this.bgColor = Colors.white,
      this.titleColor = R.color_1,
      this.titleBold = false,
      this.titleWidget,
      this.leadingWidget,
      this.height = Size2.app_bar_height,
      this.leadingCallback,
      this.elevation = 0.0,
      this.titleSize = Sp.font_big,
      this.brightness = Brightness.light})
      : super(child: Container(), preferredSize: Size.fromHeight(height));

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      title: _buildTitleWidget(),
      centerTitle: true,
      elevation: this.elevation,
      brightness: brightness,
      leading: _buildLeadingButton(context),
      actions: getActions(),
      shadowColor: R.color_2,
    );
  }

  Widget? _buildTitleWidget() {
    if (titleWidget != null) return titleWidget;
    return Text(
      title,
      style: TextStyle(
          fontSize: sp(titleSize),
          color: titleColor,
          fontWeight: titleBold ? FontWeight.bold : FontWeight.normal),
    );
  }

  List<Widget>? getActions() {
    Widget widget = rightText == null
        ? Container()
        : TouchCallBack(
            child: Container(
              padding: EdgeInsets.only(right: 10.0),
              alignment: Alignment.center,
              child: Text(
                rightText!,
                style:
                    TextStyle(color: R.color_2, fontSize: sp(Sp.font_middle2)),
              ),
            ),
            onPressed: () {
              callback!();
            });

    return <Widget>[
      rightWidget != null ? rightWidget! : widget,
    ];
  }

  Widget? _buildLeadingButton(BuildContext context) {
    if (!leading) return null;
    if (leadingWidget != null) {
      return TouchCallBack(
        child: leadingWidget,
        onPressed: () {
          if (leadingCallback != null) {
            leadingCallback!();
            return;
          }
          if (isSystemPop) {
            SystemNavigator.pop();
            Navigator.pop(context);
          } else {
            Navigator.pop(context);
          }
        },
      );
    }
    return IconButton(
      padding: EdgeInsets.all(14.0),
      icon: Icon(
        MyIcons.arrow_right,
        size: 20.0,
        color: R.color_1,
      ),
      onPressed: () {
        if (leadingCallback != null) {
          leadingCallback!();
          return;
        }
        if (isSystemPop) {
          SystemNavigator.pop();
        } else {
          Navigator.pop(context);
        }
      },
    );
  }
}

Widget buildRightButton({required String imageName}) {
  return Container(
    padding: EdgeInsets.all(16.0),
    child: Image.asset(imageName, width: 24.0),
  );
}

class EmptyWidget extends StatelessWidget {
  final Color bgColor;
  final Color textColor;
  final String text;
  final String image;
  final double paddingTop;
  final bool showAppBar;

  const EmptyWidget(
      {Key? key,
      this.bgColor = Colors.white,
      this.textColor = R.color_1,
      this.text = String2.error,
      this.image = "images/empty_state_search.png",
      this.paddingTop = 89.0,
      this.showAppBar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (showAppBar) {
      return Scaffold(
        appBar: AFPreferredSize(""),
        body: _buildContainer(),
      );
    } else {
      return _buildContainer();
    }
  }

  Container _buildContainer() {
    return Container(
        color: bgColor,
        alignment: Alignment.bottomCenter,
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                height: showAppBar
                    ? (paddingTop - Size2.app_bar_height)
                    : paddingTop,
              ),
              Image.asset(
                image,
                width: 119.0,
                height: 113.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 29.0, left: 24.0, right: 24.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: textColor.withOpacity(0.6),
                      fontSize: sp(Sp.font_big)),
                ),
              ),
            ],
          ),
        ));
  }
}

class CustomLoadingMoreKit extends StatelessWidget {
  final Color color;
  final VoidCallback? onLoadMoreErrorCallback;

  const CustomLoadingMoreKit(
      {Key? key, this.color = R.color_2, this.onLoadMoreErrorCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = _buildLoadWidget("Loading", showLoading: true);
        } else if (mode == LoadStatus.loading) {
          body = _buildLoadWidget("Loading", showLoading: true);
        } else if (mode == LoadStatus.failed) {
          return _buildLoadWidget("Network error, Tap to refresh");
        } else if (mode == LoadStatus.canLoading) {
          body = Container();
        } else if (mode == LoadStatus.noMore) {
          return _buildLoadWidget("- That's my bottom line -");
        } else {
          body = _buildLoadWidget("Loading", showLoading: true);
        }
        return Container(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }

  Widget _buildLoadWidget(String text, {bool showLoading = false}) {
    if (showLoading) {
      return Container(
          color: color,
          height: 46.0,
          child: Center(
            child: Image.asset(
              'images/loading_bottom.webp',
              width: 26.0,
            ),
          ));
    }
    return TouchCallBack(
      child: Container(
          color: color,
          height: 46.0,
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: R.color_2, fontSize: sp(Sp.font_middle)),
            ),
          )),
      onPressed: () {
        if (onLoadMoreErrorCallback != null) onLoadMoreErrorCallback!();
      },
    );
  }
}

class LoadingMoreKit extends StatelessWidget {
  static const int STATE_LOADING = 0;
  static const int STATE_COMPLETE = 1;
  static const int STATE_NO_DATA = 2;
  static const int STATE_ERROR = 3;

  final int? state;
  final Color color;

  const LoadingMoreKit({Key? key, this.state, this.color = R.color_2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state == STATE_NO_DATA) {
      return _buildLoadWidget("- That's my bottom line -");
    } else if (state == STATE_LOADING) {
      return _buildLoadWidget("Loading...", showLoading: true);
    } else if (state == STATE_ERROR) {
      return _buildLoadWidget("Load Error");
    } else {
      return _buildLoadWidget("Loading...", showLoading: true);
    }
  }

  Widget _buildLoadWidget(String text, {bool showLoading = false}) {
    if (showLoading) {
      return Container(
          color: color,
          height: 46.0,
          child: Center(
            child: Image.asset(
              'images/loading_bottom.webp',
              width: 26.0,
            ),
          ));
    }
    return Container(
        color: color,
        height: 46.0,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: R.color_2, fontSize: sp(Sp.font_middle)),
          ),
        ));
  }
}

class AvatarKit extends StatelessWidget {
  final String? avatar;
  final double width, height;
  final double radius;
  final double radius2;
  final bool shadow;
  final double borderWidth;

  const AvatarKit(
      {Key? key,
      this.avatar,
      this.width = 68.0,
      this.height = 68.0,
      this.radius = 12.0,
      this.radius2 = 14.0,
      this.shadow = true,
      this.borderWidth = 3.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: !shadow
          ? null
          : BoxDecoration(
              border: Border.all(color: R.color_3, width: borderWidth),
              boxShadow: MyBoxShadow.all(),
              borderRadius: BorderRadius.circular(radius2),
            ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: buildAvatar(),
      ),
    );
  }

  Widget buildAvatar() {
    if (toString2(avatar).startsWith("http") || isEmpty(avatar)) {
      if (isEmpty(avatar)) {
        return Image.asset(
          "images/icon_photo_auto.png",
          width: width,
          fit: BoxFit.cover,
        );
      }
      return FadeInImage.assetNetwork(
        placeholder: "images/icon_photo_auto.png",
        image: avatar ?? "",
        fit: BoxFit.cover,
      );
    }
    return Image.file(
      File(avatar!),
      fit: BoxFit.cover,
    );
  }
}

/// loading页
class LoadingKit extends StatelessWidget {
  final Color bgColor;

  const LoadingKit({Key? key, this.bgColor = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: R.color_2,
      child: ListView(
        children: <Widget>[
          Container(
            height: 140,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                'images/loading.webp',
                width: 100.0,
                height: 100,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              child: Text(
                "Loading",
                style: TextStyle(
                  color: R.color_2,
                  decoration: TextDecoration.none,
                  fontSize: sp(Sp.font_big),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}