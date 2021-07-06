import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/global.dart';

import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshHeader extends RefreshIndicator {
  final Color bgColor;

  RefreshHeader({this.bgColor = R.color_background})
      : super(height: Global.refreshHeight, refreshStyle: RefreshStyle.Follow);

  @override
  State<StatefulWidget> createState() {
    return GifHeaderState();
  }
}

class GifHeaderState extends RefreshIndicatorState<RefreshHeader>
    with SingleTickerProviderStateMixin {
  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    return Container(
      color: widget.bgColor,
      child: Image.asset(
        "images/icon_dialog_loading.webp",
        height: Global.refreshHeight,
        width: getScreenWidth(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
