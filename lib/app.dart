import 'package:studentapp/features/add_student/presentation/notifier/students_notifier.dart';
import 'package:studentapp/features/dashboard/presentation/notifier/dashboard_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/core/di-manual/di_manual.dart';
import 'package:studentapp/core/routes/route.dart';
import 'package:studentapp/shared/constants/utils.dart';
import 'package:studentapp/shared/widgets/splash/splash.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

bool userIsInsideApp = false;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: _getDesignSize(context),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: getIt<StudentNotifier>()),
            ChangeNotifierProvider.value(value: getIt<DashboardNotifier>()),
          ],
          child: MaterialApp(
            navigatorKey: navigatorKey,
            builder: (xcontext, child) {
              return SizedBox(child: child!);
            },
            debugShowCheckedModeBanner: false,
            initialRoute: Splash.routeName,
            onGenerateRoute: onGenerateRoute,
          ),
        );
      },
    );
  }

  Size _getDesignSize(context) {
    bool isTablet =
        Utils.isTabletSize(context); // This is a method to detect tablet/phone
    return isTablet
        ? const Size(1366, 1024)
        : const Size(390, 844); // Here is the design size for phone sizes
  }
}
