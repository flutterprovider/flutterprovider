import 'package:flutter/material.dart';

class NavigationUtils {
  NavigationUtils._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static NavigatorState? get navigator => navigatorKey.currentState;
  static BuildContext? get context => navigatorKey.currentContext;

  static Future<T?> push<T>(Widget screen) {
    return navigator!
        .push(MaterialPageRoute(builder: (_) => screen));
  }

  static Future<T?> pushNamed<T>(String route, {Object? arguments}) {
    return navigator!.pushNamed(route, arguments: arguments);
  }

  static Future<T?> pushReplacement<T>(Widget screen) {
    return navigator!
        .pushReplacement(MaterialPageRoute(builder: (_) => screen));
  }

  static void pushAndRemoveAll(Widget screen) {
    navigator!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => screen),
      (_) => false,
    );
  }

  static void pop<T>([T? result]) {
    if (navigator!.canPop()) navigator!.pop(result);
  }
}
