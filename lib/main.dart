import 'dart:async';
import 'dart:io';
import 'package:studentapp/app.dart';
import 'package:studentapp/core/networkhandler/httpcert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/di-manual/di_manual.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = MyHttpOverrides();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await setUp();
    runApp(const MyApp());
  }, (error, stack) async {});
}
