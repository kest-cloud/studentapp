import 'package:flutter/material.dart';

class Utils {
  static isTabletSize(context) {
    final MediaQueryData data = MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.views.single);
    return data.size.shortestSide > 600 ? true : false;
  }
}
