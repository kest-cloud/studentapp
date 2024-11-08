import 'dart:async';

import 'package:studentapp/features/dashboard/presentation/views/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studentapp/shared/styles/app_colors.dart';

class Splash extends StatefulWidget {
  static const routeName = '/splash';
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    // Add a delay of 2 seconds before navigating to the next screen
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushNamed(context, NavPage.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Your splash screen content
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Container(
          height: 100.h,
          width: 100.w,
          color: Colors.black,
        ),
      ),
    );
  }
}
