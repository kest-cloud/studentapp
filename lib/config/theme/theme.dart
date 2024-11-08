import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studentapp/core/utils/colors.dart';
import 'package:studentapp/core/utils/dims.dart';

var theme = StudentappTheme().light;

class StudentappTheme {
  static StudentappTheme? _instance;

  factory StudentappTheme() {
    return _instance ??= StudentappTheme._internal();
  }

  StudentappTheme._internal();

  var light = ThemeData(
    fontFamily: "Satoshi",
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: appColor.transparent,
        systemStatusBarContrastEnforced: false,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    iconTheme: IconThemeData(color: appColor.black),
    primaryColor: appColor.primary,
    scaffoldBackgroundColor: appColor.backgroundDeep,
    drawerTheme: DrawerThemeData(
      backgroundColor: appColor.backgroundDeep,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      background: appColor.backgroundDeep,
      secondary: appColor.backgroundDeep,
    ),
    disabledColor: const Color.fromRGBO(74, 85, 104, 1),
    cardTheme: CardTheme(
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 5,
      color: const Color.fromRGBO(242, 242, 247, 1),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),

    switchTheme: SwitchThemeData(
      trackColor: MaterialStateColor.resolveWith((states) => appColor.primary),
      thumbColor: MaterialStateColor.resolveWith((states) => appColor.white),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: appColor.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    ),
    radioTheme: RadioThemeData(
        fillColor:
            MaterialStateColor.resolveWith((states) => appColor.primary)),
    // ignore: prefer_const_constructors
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 1.2,
      ),
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0.8,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),

      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      // bodyText1: ,
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.25,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodySmall: bodySmall,
      displayMedium: TextStyle(
        fontSize: 33,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        color: textColor,
      ),
      displaySmall: displaySmall,
      labelSmall: TextStyle(
        fontSize: 12,
        letterSpacing: 0,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      labelLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: textColor,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
    inputDecorationTheme: InputDecorationTheme(
      // contentPadding: const EdgeInsets.only(top: 12),
      isCollapsed: true,
      // contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      isDense: true,
      fillColor: appColor.backgroundDeep,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
        borderSide: BorderSide(
          color: appColor.gray,
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: appColor.gray,
          width: 1.0,
        ),
      ),

      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: appColor.white,
        ),
        borderRadius: BorderRadius.circular(
          Dims.inputRadius,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1,
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(
          Dims.inputRadius,
        ),
      ),
      hintStyle: TextStyle(
        color: appColor.black.withOpacity(0.6),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      labelStyle: TextStyle(
        color: appColor.black.withOpacity(0.6),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

get displaySmall =>
    TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: appColor.black);

get bodySmall => TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: textColor,
    );

get textColor => appColor.black;
