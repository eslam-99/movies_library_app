import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_library_app/core/theme/app_colors.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';
import '../../injection_container.dart';

class AppToast {
  static Future showNormalToast({
    required BuildContext? context,
    required String msg,
    required AppToastType type,
  }) async {
    await Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.primary,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static Future showToastyBox({
    required BuildContext? context,
    required String msg,
    required AppToastType type,
  }) async {
    if (context == null && sl<GlobalKey<NavigatorState>>().currentContext == null) {
      AppToast.showNormalToast(
        context: null,
        msg: msg,
        type: type,
      );
    } else {
      ToastService.showToast(
      context ?? sl<GlobalKey<NavigatorState>>().currentContext!,
        backgroundColor: type == AppToastType.success ? Colors.green.shade500 : type == AppToastType.warning ? Colors.orange
            .shade500 : type == AppToastType.error ? Colors.red.shade500 : Colors.white,
        shadowColor: Colors.black12,
        length: ToastLength.medium,
        expandedHeight: 100,
        message: msg,
        messageStyle: TextStyle(fontSize: 16, color: type == AppToastType.msg ? AppColors.primary : Colors.white),
        leading: Icon(
          type == AppToastType.success ? Icons.check_circle_rounded : type == AppToastType.warning
              ? Icons.warning_rounded
              : type == AppToastType.error ? Icons.error_rounded : Icons.message,
          color: type == AppToastType.msg ? AppColors.primary : Colors.white,
        ),
        slideCurve: Curves.elasticInOut,
        positionCurve: Curves.bounceOut,
        dismissDirection: DismissDirection.horizontal,
      );
    }
  }

  static Future showToastyBoxWidget({
    required BuildContext context,
    required Widget child,
  }) async {
    ToastService.showWidgetToast(
      context,
      backgroundColor: Colors.white,
      shadowColor: Colors.black12,
      length: ToastLength.medium,
      expandedHeight: 100,
      child: child,
      slideCurve: Curves.elasticInOut,
      positionCurve: Curves.bounceOut,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}

enum AppToastType {
  msg,
  success,
  warning,
  error,
}

class MyToast {
  static Future showToast(String msg) async {
    await Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}