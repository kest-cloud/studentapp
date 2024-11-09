import 'package:studentapp/features/dashboard/presentation/views/navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:studentapp/shared/widgets/splash/splash.dart';

// final routes = <String, WidgetBuilder>{
//   LoginScreen.routeName: (BuildContext context) => const LoginScreen(),
//   HomeScreen.routeName: (BuildContext context) => const HomeScreen(),
//   DashBoardScreen.routeName: (BuildContext context) => const DashBoardScreen(),
//   SplashScreen.routeName: (BuildContext context) => const SplashScreen()
// };

Route onGenerateRoute(RouteSettings settings) {
  return switch (settings.name) {
    Splash.routeName => MaterialPageRoute(
        builder: (_) => const Splash(),
        settings: const RouteSettings(name: Splash.routeName),
      ),
    NavPage.routeName => MaterialPageRoute(
        builder: (_) => const NavPage(),
        settings: const RouteSettings(name: NavPage.routeName),
      ),
    _ => MaterialPageRoute(
        builder: (_) => const Splash(),
        settings: const RouteSettings(name: Splash.routeName)),
  };
}
