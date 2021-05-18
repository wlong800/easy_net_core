import 'package:flutter/material.dart';

import 'common_callback.dart';

class TouchCallBack extends StatefulWidget {
  final Widget? child;
  final VoidCallback? onPressed;
  final Callback? onGestureState;
  final bool isFeed;
  final Color? background;

  TouchCallBack({
    Key? key,
    required this.child,
    required this.onPressed,
    this.isFeed: true,
    this.background,
    this.onGestureState,
  }) : super(key: key);

  @override
  TouchState createState() => TouchState();
}

class TouchState extends State<TouchCallBack> {
  Color? color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: Container(
        color: color,
        child: widget.child,
      ),
      onTap: widget.onPressed,
      onPanDown: (d) {
        if (widget.onGestureState != null) {
          widget.onGestureState!('onPanDown');
        }
        if (widget.isFeed == false) return;
        if (!mounted) return;
        setState(() {
          color = widget.background;
        });
      },
      onPanCancel: () {
        if (!mounted) return;
        setState(() {
          color = Colors.transparent;
        });
      },
    );
  }
}
