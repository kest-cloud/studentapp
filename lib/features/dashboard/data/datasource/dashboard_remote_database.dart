import 'package:dio/dio.dart';
import 'package:studentapp/core/networkhandler/network_requester.dart';

abstract class DashboardRemoteDatasource {
  Future<List<dynamic>> getStudentProfiles();

  Future<dynamic> deleteStudentProfiles(id);

  Future<dynamic> addStudent(Map<String, Object?> newStudent);
}

class DashboardRemoteDatasourceImpl extends DashboardRemoteDatasource {
  DashboardRemoteDatasourceImpl({
    required this.networkRequester,
  });

  final NetworkRequester networkRequester;

  final baseUrl = "http://10.0.2.2:3000";

  @override
  Future<List<dynamic>> getStudentProfiles() async {
    var response = await networkRequester.get(
      path: baseUrl,
      "/students",
      isProtected: false,
      contentType: 'application/json',
    );

    return response;
  }

  @override
  Future<dynamic> deleteStudentProfiles(id) async {
    var response = await networkRequester.delete(
      path: baseUrl,
      "/students/$id",
      isProtected: false,
      contentType: 'application/json',
      data: {},
    );

    return response;
  }

  @override
  Future addStudent(Map<String, Object?> newStudent) async {
    var response = await networkRequester.post(
      path: baseUrl,
      "/students",
      isProtected: false,
      contentType: 'application/json',
      data: {},
    );

    return response;
  }

  // @override
  // Future<Response<Map<String, dynamic>>> createPassword(
  //     {required CreatePasswordRequest params}) async {
  //   var response = await networkRequester.post(
  //     '/api/v3/Onboarding/CreatePassword',
  //     isProtected: false,
  //     path: baseUrl,
  //     data: params.toJson(),
  //   );

  //   return response;
  // }
}
