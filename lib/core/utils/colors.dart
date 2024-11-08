import 'package:flutter/material.dart';

final appColor = PoColors();

class PoColors {
  // PoColors();
  static PoColors? _instance;

  factory PoColors() {
    return _instance ??= PoColors._internal();
  }

  PoColors._internal();

  final orange = const Color(0xffECA72C);

  final orangeBeginGrad = const Color(0xffFF5041);
  final red = const Color(0xffF22E52);
  final pink = const Color(0xffC3B0D1);

  final orangeEndGrad = const Color(0xffFF6A13);
  final primary = const Color(0xffECA72C);

  final backgroundDeep = const Color(0xFFF6F6F6);
  final transparent = Colors.transparent;
  final gray = const Color(0xFFB8BBD4);
  final lightGrey3 = const Color(0xFF6C6C6C);
  final lightGrey4 = const Color(0xFFB8BBD4);
  final green = const Color(0xFF38B000);
  final black = const Color(0xFF000000);
  final transparentBlack = const Color(0xD8010101);
  final shadowGrey = const Color(0x232F2F2F);
  final success = const Color(0xFF43C084);
  final blue = const Color(0xFF379BF6);
  final offWhite = const Color(0xFFF7F7F7);
  final white = const Color(0xFFFFFFFF);
  final formError = Colors.red.shade400;
  final yellow = const Color(0xFFF2C364);
  final backgroundYellow = const Color(0xFFFFF2DB);
  final bottomSheetPillColor = const Color(0xFFE6E6E6);
  final borderColor = const Color(0xFFEFECF0);
  final faintGrey = const Color(0xFF929292);
  final filterByBorderColor = const Color(0xFFEDEDED);
  final redColor = const Color(0xFFF22E52);
  final menuBackgroundColor = const Color(0xFFFDFBFF);
  final blackNoName = const Color(0xFF121212);
  final passwordCheckBg = const Color(0xFFFDFBFF);
  final passwordConditions = const Color(0xFF222222);
  final activateDeactivateUssdBackgroundColor = const Color(0xFFFFD7DE);
  final cardVariantColor = const Color(0xFFFAF4FF);
  final textBlackColor = const Color(0xFF1D1A19);
  final newBlack = const Color(0xFF1B1B1B);
  final cardBackground = const Color(0xFFFCF9FF);
  final amountFieldBottomLabelColor = const Color(0xFF1D1A19);
  final cardBackgroundColor = const Color(0xFFFCF9FF);
  final backgroundRed = const Color(0xFFFFD7DE);
  final lightPurpleBackground = const Color(0xFFF9F4FD);

  final smallGradient = const LinearGradient(
      begin: Alignment(-0.9449995756149292, -1.0066247582435608),
      end: Alignment(-1.10259151458740234, 0.8449995756149292),
      // stops: [0.1,0.4,0.5],
      colors: [
        Color.fromRGBO(163, 0, 5, 1),
        Color.fromRGBO(47, 46, 52, 1),
      ]);

  final primaryGradient = const LinearGradient(
      begin: Alignment(-0.9449995756149292, -1.0066247582435608),
      end: Alignment(-1.10259151458740234, 0.8449995756149292),
      colors: [
        Color.fromRGBO(163, 0, 5, 1),
        Color.fromRGBO(47, 46, 52, 1),
      ]);

  final secondaryGradient = const LinearGradient(
      begin: Alignment(-0.3, -1),
      end: Alignment(-0.9, 6),
      colors: [
        Color.fromRGBO(163, 0, 5, 1),
        Color.fromRGBO(47, 46, 52, 1),
      ]);
}
