// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const MockupHeight = 812;
const MockupWidth = 375;

sHeight(BuildContext context) {
  return (dynamic height) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * (height / MockupHeight);
  };
}

sWidth(BuildContext context) {
  return (dynamic width) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * (width / MockupWidth);
  };
}

fullScreen(BuildContext context) {
  return (String? axis) {
    if (axis == 'height') return MediaQuery.of(context).size.height;
    return MediaQuery.of(context).size.width;
  };
}

class Screen {
  Size screenSize;

  Screen(this.screenSize);

  double wp(percentage) {
    return percentage / 100 * screenSize.width;
  }

  double hp(percentage) {
    return percentage / 100 * screenSize.height;
  }
}
