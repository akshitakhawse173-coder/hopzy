// Dart imports:
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationService {
  // A global key to hold the navigator state
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Returns a widget based on the provided route name and optional arguments
  // Needs to be implemented with actual route mappings
  static Widget getWidget(String? name, [Object? arguments]) {
    switch (name) {
      default:
        throw UnimplementedError("No route defined for $name");
    }
  }

  // Returns a platform-specific route for the given widget and settings
  static Route<T> getRoute<T>(Widget widget, {RouteSettings? settings, String? name}) {
    settings ??= RouteSettings(name: name);
    return Platform.isIOS
        ? CupertinoPageRoute(settings: settings, builder: (context) => widget)
        : MaterialPageRoute(settings: settings, builder: (context) => widget);
  }

  // Creates a route for the given settings
  static Route<T> pages<T>(RouteSettings settings) {
    return getRoute(getWidget(settings.name, settings.arguments), settings: settings);
  }

  // Pushes a new route onto the navigator stack
  static Future<T?>? push<T extends Object?>({Widget? page, String? name, Object? arguments}) {
    assert(page != null || name != null);
    page ??= getWidget(name);
    if (name != null && arguments != null) {
      return navigatorKey.currentState?.pushNamed(name, arguments: arguments);
    } else if (arguments != null) {
      return navigatorKey.currentState?.push<T>(getRoute(page, settings: RouteSettings(arguments: arguments)));
    }
    return navigatorKey.currentState?.push<T>(getRoute(page, name: name));
  }

  // Replaces the current route with a new one
  static Future<T?>? pushReplacement<T extends Object?, TO extends Object>(Widget page, {String? name, TO? result, Object? arguments}) =>
      navigatorKey.currentState
          ?.pushReplacement<T, TO>(getRoute(page, name: name, settings: RouteSettings(arguments: arguments)), result: result);

  // Pushes a new route and removes routes until the predicate returns true
  static Future<T?>? pushAndRemoveUntil<T extends Object?, TO extends Object?>({
    String? name,
    Widget? page,
    bool Function(Route<dynamic>)? predicate,
  }) {
    assert(page != null || name != null);
    page ??= getWidget(name);
    predicate ??= (p0) => false;
    return navigatorKey.currentState?.pushAndRemoveUntil<T>(getRoute(page, name: name), predicate);
  }

  // Pops the top-most route off the navigator
  static void pop<T extends Object?>([T? result]) => navigatorKey.currentState?.pop<T>(result);

  // Pops routes until the predicate returns true
  static void popUntil(bool Function(Route<dynamic>) predicate) => navigatorKey.currentState?.popUntil(predicate);

  // Pops the current route and pushes a named route
  static Future<T?>? popAndPushNamed<T extends Object?, TO extends Object?>(String routeName, {TO? result, Object? arguments}) {
    return navigatorKey.currentState?.popAndPushNamed<T, TO>(routeName, result: result, arguments: arguments);
  }

  // Pops routes until the route with the specified name is reached
  static void popUntilNamed(String routeName) {
    navigatorKey.currentState?.popUntil((route) => route.settings.name == routeName);
  }

  // Pushes a named route onto the navigator stack
  static Future<T?>? pushNamed<T extends Object?>(String name, {Object? arguments}) {
    return navigatorKey.currentState?.pushNamed<T>(name, arguments: arguments);
  }

  // Replaces the current route with a named route
  static Future<T?>? pushReplacementNamed<T extends Object?, TO extends Object?>(String name, {TO? result, Object? arguments}) {
    return navigatorKey.currentState?.pushReplacementNamed<T, TO>(name, result: result, arguments: arguments);
  }
}
