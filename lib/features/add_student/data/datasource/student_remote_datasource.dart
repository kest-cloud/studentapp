import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:studentapp/core/networkhandler/network_requester.dart';

abstract class StudentRemoteDatasource {
  Future<Response<Map<String, dynamic>>> login({
    required String username,
    required String password,
    required Map<String, dynamic> param,
  });
}

class StudentRemoteDatasourceImpl extends StudentRemoteDatasource {
  StudentRemoteDatasourceImpl({
    required this.networkRequester,
  });

  final NetworkRequester networkRequester;

  final baseUrl = "";

  @override
  Future<Response<Map<String, dynamic>>> login({
    required String username,
    required String password,
    required Map<String, dynamic> param,
  }) async {
    var response = await networkRequester.post(
      '/OAuthToken',
      isProtected: false,
      contentType: 'application/x-www-form-urlencoded',
      data: param,
    );

    return response;
  }
}
