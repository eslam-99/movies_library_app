import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../gen/assets.gen.dart';

Future loadingOverlay(context) {
  return showDialog(
    context: context,
    useSafeArea: false,
    barrierColor: Colors.white,
    barrierDismissible: kDebugMode,
    builder: (context) {
      return PopScope(
        // onWillPop: () => Future(() => kDebugMode),
        canPop: kDebugMode,
        onPopInvoked: (didPop) => kDebugMode,
        child: const Center(
          child: AppLoading(),
        ),
      );
    },
  );
}

class AppLoading extends StatelessWidget {
  final double? size;
  const AppLoading({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth == double.infinity ? (size ?? 50) : constraints.maxWidth / 3;
          double maxHeight = constraints.maxWidth == double.infinity ? (size ?? 50) : constraints.maxWidth / 3;
          return Container(
            width: maxWidth,
            height: maxHeight,
            constraints: const BoxConstraints(
              minHeight: 50,
              minWidth: 50,
            ),
            child: Lottie.asset(Assets.lottie.loading),
          );
        }
    );
  }
}
