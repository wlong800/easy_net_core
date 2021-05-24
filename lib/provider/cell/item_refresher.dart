import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

typedef ShouldRebuild<A, T> = bool Function(A notifier, T value);

/// 包裹某个用于状态刷新的item，用于颗粒化，比如QA列表中的item
class ItemRefresher<A, T> extends SingleChildStatefulWidget {
  final ShouldRebuild<A, T>? _shouldRebuild;
  final T value;

  ItemRefresher({
    Key? key,
    required this.value,
    ShouldRebuild<A, T>? shouldRebuild,
    required this.builder,
    Widget? child,
  })  : this._shouldRebuild = shouldRebuild,
        super(key: key, child: child);

  final ValueWidgetBuilder<T> builder;

  @override
  _ItemRefresherState<A, T> createState() => _ItemRefresherState<A, T>();
}

class _ItemRefresherState<A, T> extends SingleChildState<ItemRefresher<A, T>> {
  late Widget cache;
  Widget? oldWidget;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    A notifier = Provider.of(context);
    var shouldInvalidateCache = oldWidget != widget ||
        (widget._shouldRebuild != null &&
            notifier != null &&
            widget._shouldRebuild!.call(notifier, widget.value));
    if (shouldInvalidateCache) {
      oldWidget = widget;
      cache = widget.builder(
        context,
        widget.value,
        child,
      );
    }
    return cache;
  }
}

//单个用于标识是否更新状态-->A notifier
class PostNotifier with ChangeNotifier {
  var id;
}
