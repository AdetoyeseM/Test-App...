import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

navigateReplace(context, Widget route, {isDialog = false}) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (BuildContext ctx) => route,
    ),
  );
}


cupernavigateReplace(context, Widget route, {isDialog = false}) {
  return Navigator.pushReplacement(
    context,
    CupertinoPageRoute(
      builder: (BuildContext ctx) => route,
    ),
  );
}
navigate(context, Widget route, {isDialog = false}) => Navigator.push(
      context,
      MaterialPageRoute(
        maintainState: false,
        fullscreenDialog: isDialog,
        builder: (context) => route,
      ),
    );

popToFirst(BuildContext context) =>
    Navigator.of(context).popUntil((route) => route.isFirst);

popView(BuildContext context) => Navigator.pop(context);

navigateTransparentRoute(BuildContext context, Widget route) {
  return Navigator.push(
    context,
    TransparentRoute(
      builder: (context) => route,
    ),
  );
}

class TransparentRoute extends PageRoute<void> {
  TransparentRoute({
    required this.builder,
  })  : assert(builder != null),
        super(fullscreenDialog: false);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 350);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final result = builder(context);
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: SlideTransition(
          transformHitTests: false,
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(0.0, -1.0),
            ).animate(secondaryAnimation),
            child: result,
          ),
        ),
      ),
    );
  }
}
