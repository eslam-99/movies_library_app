import 'package:flutter/material.dart';

class AppNav {
  static Future<T?> to<T extends Object?>(BuildContext context, Widget page) {
    return Navigator.push<T>(context, MaterialPageRoute(builder: (context) => page));
  }

  static Future<T?> off<T extends Object?, TO extends Object?>(BuildContext context, Widget page) {
    return Navigator.pushReplacement<T, TO>(context, MaterialPageRoute(builder: (context) => page));
  }

  static Future<T?> toNamed<T extends Object?>(BuildContext context, String routeName, {dynamic extra}) {
    return Navigator.pushNamed<T>(context, routeName, arguments: extra);
  }

  static Future<T?> offNamed<T extends Object?, TO extends Object?>(BuildContext context, String routeName, {dynamic extra}) {
    return Navigator.pushReplacementNamed<T, TO>(context, routeName, arguments: extra);
  }

  static Future<T?> offAllNamed<T extends Object?>(BuildContext context, String routeName, {dynamic extra}) {
    return Navigator.pushNamedAndRemoveUntil<T>(context, routeName, (route) => false, arguments: extra);
  }

  static bool canPop(BuildContext context) {
    return Navigator.canPop(context);
  }

  static void pop(BuildContext context, {dynamic data}) {
    Navigator.pop(context, data);
  }

  static void popAll(BuildContext context) {
    while(Navigator.canPop(context))
      Navigator.pop(context);
  }
}