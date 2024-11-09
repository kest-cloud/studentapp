// ignore: file_nam
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:studentapp/core/networkhandler/failure.dart';

class NetworkRequester {
  NetworkRequester({
    required this.dio,
  });

  final Dio dio;

  String _token = '';

  set token(String token) {
    _token = token;
  }

  void clearSession() {
    // clears token
    _token = '';
  }

  Future<List<dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool isProtected = false,
    Map<String, dynamic>? headers,
    bool isFormData = false,
    String? path,
    String? contentType,
  }) async {
    try {
      Response<List<dynamic>> response = await dio.get<List<dynamic>>(
        '$path$endpoint',
        queryParameters: queryParameters ?? {},
        options: Options(
          method: 'GET',
          headers: headers,
          extra: <String, dynamic>{},
          contentType: isFormData ? 'multipart/form-data' : contentType,
        ),
      );

      return response.data!;
    } catch (e) {
      // print("Error :::$e");
      throw ExceptionHandler.handleError(e);
    }
  }

  Future<Response<List<dynamic>>> getList(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool isProtected = false,
    Map<String, dynamic>? headers,
    bool isFormData = false,
    String? path,
    String? contentType,
  }) async {
    try {
      Response<List<dynamic>> response = await dio.get<List<dynamic>>(
        '${path ?? dotenv.env['baseUrl']}$endpoint',
        queryParameters: queryParameters ?? {},
        options: Options(
          method: 'GET',
          headers: headers,
          extra: <String, dynamic>{},
          contentType: isFormData ? 'multipart/form-data' : contentType,
        ),
      );

      return response;
    } catch (e) {
      // print("Error :::");
      throw ExceptionHandler.handleError(e);
    }
  }

  Future<Response<Map<String, dynamic>>> post(String endpoint,
      {required dynamic data,
      bool isProtected = false,
      bool isFormData = false,
      String? path,
      String? contentType,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    Response<Map<String, dynamic>> response =
        await dio.post<Map<String, dynamic>>(
      '${path ?? dotenv.env['baseUrl']}$endpoint',
      data: data,
      queryParameters: queryParameters ?? {},
      options: Options(
        method: 'POST',
        extra: <String, dynamic>{},
        headers: headers,
        contentType: isFormData ? 'multipart/form-data' : contentType,
      ),
    );

    return response;
  }

  Future<Response<Map<String, dynamic>>> postList(String endpoint,
      {required List<dynamic> data,
      bool isProtected = false,
      bool isFormData = false,
      String? path,
      String? contentType,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    Response<Map<String, dynamic>> response =
        await dio.post<Map<String, dynamic>>(
      '${path ?? dotenv.env['baseUrl']}$endpoint',
      data: data,
      queryParameters: queryParameters ?? {},
      options: Options(
        method: 'POST',
        extra: <String, dynamic>{},
        headers: headers,
        contentType: isFormData ? 'multipart/form-data' : contentType,
      ),
    );

    return response;
  }

  Future<Response> patch(
    String endpoint, {
    required Map<String, dynamic> data,
    bool isProtected = false,
    bool isFormData = false,
    String? path,
    String? contentType,
  }) async {
    try {
      Response<Map<String, dynamic>> response =
          await dio.patch<Map<String, dynamic>>(
        '${path ?? dotenv.env['baseUrl']}$endpoint',
        data: data,
        queryParameters: {},
        options: Options(
          method: 'PATCH',
          headers: <String, dynamic>{
            if (isProtected) 'Authorization': 'Bearer $_token',
          },
          extra: <String, dynamic>{},
          contentType: isFormData ? 'multipart/form-data' : contentType,
        ),
      );

      return response;
    } on DioException catch (error) {
      throw ExceptionHandler.handleError(error);
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  Future<Response> put(
    String endpoint, {
    required Map<String, dynamic> data,
    bool isProtected = false,
    bool isFormData = false,
    String? path,
    String? contentType,
  }) async {
    try {
      Response<Map<String, dynamic>> response =
          await dio.put<Map<String, dynamic>>(
        '${path ?? dotenv.env['baseUrl']}$endpoint',
        data: data,
        queryParameters: {},
        options: Options(
          method: 'PUT',
          headers: <String, dynamic>{
            if (isProtected) 'Authorization': 'Bearer $_token',
          },
          extra: <String, dynamic>{},
          contentType: isFormData ? 'multipart/form-data' : contentType,
        ),
      );

      return response;
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  Future<Response<Map<String, dynamic>>> delete(String endpoint,
      {required Map<String, dynamic> data,
      bool isProtected = false,
      bool isFormData = false,
      String? path,
      String? contentType}) async {
    try {
      Response<Map<String, dynamic>> response =
          await dio.delete<Map<String, dynamic>>(
        '$path$endpoint',
        queryParameters: {},
        options: Options(
          method: 'DELETE',
          extra: <String, dynamic>{},
          contentType: isFormData ? 'multipart/form-data' : contentType,
        ),
      );
      return response;
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }

  // multipart form data
  Future<Response<Map<String, dynamic>>> postFormData(
    String endpoint, {
    required FormData data,
    bool isProtected = false,
    bool isFormData = false,
    String? contentType,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? path,
  }) async {
    try {
      Response<Map<String, dynamic>> response = await dio.post(
        '${path ?? dotenv.env['baseUrl']}$endpoint',
        data: data,
        queryParameters: {},
        options: Options(
          method: 'POST',
          headers: <String, dynamic>{
            if (isProtected) 'Authorization': 'Bearer $_token',
          },
          extra: {},
          contentType: isFormData ? 'multipart/form-data' : contentType,
        ),
      );

      return response;
    } catch (e) {
      throw ExceptionHandler.handleError(e);
    }
  }
}
