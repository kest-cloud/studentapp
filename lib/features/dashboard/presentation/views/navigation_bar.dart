import 'package:studentapp/features/add_student/presentation/view/add_student_page.dart.dart';
import 'package:studentapp/features/dashboard/presentation/views/home_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studentapp/features/setting_page/presentation/view/settings_page.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class NavPage extends StatefulWidget {
  static const routeName = '/navBar';
  const NavPage({Key? key}) : super(key: key);

  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  final Color navigationBarColor = Colors.white;
  int selectedIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    /// [AnnotatedRegion<SystemUiOverlayStyle>] only for Android black navigation bar, with 3-button navigation control (legacy)

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[
            const HomePage(),
            const AddStudentPage(),
            SettingsPage(),
          ],
        ),
        bottomNavigationBar: WaterDropNavBar(
          waterDropColor: Colors.blue,
          backgroundColor: navigationBarColor,
          onItemSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
            pageController.animateToPage(
              selectedIndex,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuad,
            );
          },
          selectedIndex: selectedIndex,
          barItems: <BarItem>[
            BarItem(
              filledIcon: Icons.home_rounded,
              outlinedIcon: Icons.home_outlined,
            ),
            BarItem(
              filledIcon: Icons.person_add_rounded,
              outlinedIcon: Icons.person_add_outlined,
            ),
            BarItem(
              filledIcon: Icons.settings_rounded,
              outlinedIcon: Icons.settings_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
