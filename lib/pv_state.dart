import 'dart:async';

import 'package:flutter/material.dart';

ValueNotifier obs<V>(V? initialValue) {
  return ValueNotifier(initialValue);
}

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  static List<BasePagePStateMixin> pageStack = [];

  @override
  void initState() {
    super.initState();
    if (this is BasePagePStateMixin) {
      if (pageStack.isNotEmpty) {
        (pageStack.last).onPushNext();
      }
      pageStack.add(this as BasePagePStateMixin);
      scheduleMicrotask(() {
        (this as BasePagePStateMixin).onPush();
      });
    }
  }

  P? find<P extends BasePagePStateMixin>() {
    for (final element in pageStack.reversed) {
      if (element is P) {
        return element;
      }
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    if (this is BasePagePStateMixin) {
      (this as BasePagePStateMixin).onPop();
      int index = pageStack.indexOf(this as BasePagePState);
      pageStack.removeAt(index);
      if (index == pageStack.length - 1 && pageStack.isNotEmpty) {
        scheduleMicrotask(() {
          pageStack.last.onPopNext();
        });
      }
    }
  }
}

abstract class BasePState<T extends StatefulWidget> extends BaseState<T> {
  @override
  Widget build(BuildContext context) {
    throw Exception('Do not call super.build()');
  }
}

/// For pages
abstract class BasePagePState<T extends StatefulWidget> extends BasePState<T>
    with BasePagePStateMixin {}

/// For dialogs
abstract class BaseDialogPState<T extends StatefulWidget> extends BasePState<T>
    with BaseDialogPStateMixin {}

/// For embedded widgets
abstract class BaseWidgetPState<T extends StatefulWidget> extends BasePState<T>
    with BaseWidgetPStateMixin {}

mixin BasePagePStateMixin {
  void onPush() {}

  void onPop() {}

  void onPushNext() {}

  void onPopNext() {}
}

mixin BaseDialogPStateMixin {}

mixin BaseWidgetPStateMixin {}

mixin VState {
  Widget build(BuildContext context);
}

class Stateful<T extends BasePState, VState> extends StatefulWidget {
  final T state;
  final Map<String, dynamic>? arguments;

  static Stateful of<S extends BasePState, VState>(
    S newState, {
    Key? key,
    Map<String, dynamic>? arguments,
  }) {
    return Stateful(
      key: key,
      state: newState,
      arguments: arguments,
    );
  }

  const Stateful({
    Key? key,
    required this.state,
    this.arguments,
  }) : super(key: key);

  @override
  State createState() {
    return state;
  }
}
