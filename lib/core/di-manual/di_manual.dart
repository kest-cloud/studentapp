import 'package:studentapp/features/add_student/data/datasource/localdatasource/local.dart';
import 'package:studentapp/features/add_student/data/datasource/repository/student_repo.dart';
import 'package:studentapp/features/add_student/data/datasource/student_remote_datasource.dart';
import 'package:studentapp/features/add_student/data/domain/repository/repo.dart';
import 'package:studentapp/features/add_student/presentation/notifier/students_notifier.dart';
import 'package:studentapp/features/dashboard/data/datasource/dashboard_remote_database.dart';
import 'package:studentapp/features/dashboard/data/datasource/localdatasource/local.dart';
import 'package:studentapp/features/dashboard/presentation/notifier/dashboard_notifier.dart';
import 'package:studentapp/features/setting_page/data/datasource/localdatasource/local.dart';
import 'package:studentapp/features/setting_page/data/datasource/repository/sett_repo.dart';
import 'package:studentapp/features/setting_page/data/domain/repository/repo.dart';
import 'package:studentapp/features/setting_page/presentation/notifier/settings_notifier.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/core/networkhandler/network_requester.dart';
import 'package:studentapp/features/dashboard/data/datasource/repository/dashboard_repo.dart';
import 'package:studentapp/features/dashboard/data/domain/repository/repo.dart';

GetIt getIt = GetIt.instance;

Future<void> setUp() async {
  ///network
  BaseOptions options = BaseOptions(
    // baseUrl: "${dotenv.env['baseUrl']}",
    receiveDataWhenStatusError: true,
    sendTimeout: const Duration(seconds: 30),
    connectTimeout: const Duration(seconds: 30),
    // 60 seconds
    receiveTimeout: const Duration(seconds: 25), // 60 seconds
  );

  var dio = Dio(options);

  getIt.registerLazySingleton<Dio>(() => dio);

  // dio.interceptors.add(
  //   PrettyDioLogger(
  //       requestBody: true,
  //       //true
  //       requestHeader: true,
  //       //true
  //       responseBody: true,
  //       //true
  //       responseHeader: true,
  //       //false
  //       compact: true,
  //       //false
  //       error: true,
  //       //true
  //       maxWidth: 90),
  // );

  //trackedDio
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );

  var fluttersecuredstorage = const FlutterSecureStorage();
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => fluttersecuredstorage,
  );

  //storage
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingletonAsync<SharedPreferences>(() async {
    return sharedPreferences;
  });

  getIt.registerLazySingleton<StudentRemoteDatasource>(
      () => StudentRemoteDatasourceImpl(
            networkRequester: getIt(),
          ));

  getIt.registerLazySingleton<DashboardRemoteDatasource>(
      () => DashboardRemoteDatasourceImpl(
            networkRequester: getIt(),
          ));

  // getIt.registerLazySingleton<SettingsDBLocalDatasource>(() =>
  //     SettingsDBLocalDatasourceImpl(
  //         secureStorage: getIt(), sharedPreferences: getIt()));

  getIt.registerLazySingleton<StudentDBLocalDatasource>(() =>
      StudentDBLocalDatasourceImpl(
          secureStorage: getIt(), sharedPreferences: getIt()));

  getIt.registerLazySingleton<DashboardDBLocalDatasource>(() =>
      DashboardDBLocalDatasourceImpl(
          secureStorage: getIt(), sharedPreferences: getIt()));

  getIt.registerLazySingleton<NetworkRequester>(
      () => NetworkRequester(dio: getIt()));

// repo
  getIt.registerLazySingleton<DashBoardRepository>(
    () => DashBoardRepositoryImpl(
      remoteDatasource: getIt(),
      dbLocalDatasource: getIt(),
    ),
  );

  getIt.registerLazySingleton<StudentRepository>(
    () => StudentRepositoryImpl(
      remoteDatasource: getIt(),
      dbLocalDatasource: getIt(),
    ),
  );
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(
      remoteDatasource: getIt(),
      dbLocalDatasource: getIt(),
    ),
  );

  // Notifier
  getIt.registerLazySingleton<StudentNotifier>(
      () => StudentNotifier(studentDBLocalDatasource: getIt()));
  getIt
      .registerLazySingleton<SettingsNotifier>(() => SettingsNotifier(getIt()));
  getIt.registerLazySingleton<DashboardNotifier>(
      () => DashboardNotifier(dashBoardRepository: getIt()));
}
