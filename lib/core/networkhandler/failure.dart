import 'dart:io';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ExceptionHandler {
  static String handleError(error) {
    if (error is SocketException) {
      if (error.osError!.errorCode == 8) {
        return "Please check your internet connection";
      } else if (error.osError!.errorCode == 61 ||
          error.osError!.errorCode == 111 ||
          error.osError!.errorCode == 500) {
        return "The server could not be reached, please try again later.";
      }
    }
    return parseDioErrorMessage(error);
  }

  static dynamic errorResponseData(error) {
    if (error is DioException) {
      if (error.response?.data != null) {
        return error.response?.data;
      }
    }
    return '';
  }

  static String handleBadResponse(DioException dioError) {
    String errorDescription = "Sorry, Your request failed, Please try again";

    if (dioError.response?.data != null) {
      if (dioError.response?.data is Map) {
        if (dioError.response?.data['userMessage'] != null) {
          return errorDescription = dioError.response?.data['userMessage'];
        } else if (dioError.response?.data['message'] != null) {
          return errorDescription = dioError.response?.data['message'];
        } else {
          return errorDescription = dioError.response?.data['error'] ??
              "Sorry, Your request failed, Please try again"; // e.g invalid_grant
        }
      }

      return errorDescription;
    }
    switch (dioError.response?.statusCode) {
      case 504:
        return "Internal Server occurred, please try again";
      case 503:
        return "Internal Server occurred, please try again";
      case 500:
      case 404:
      case 502:
      case 400:
      case 403:
        return "An error from occurred, please try again";
      case 401:
        return "You are not authorized.";
      case 413:
        return "File too large";
      default:
        // default exception error message
        return "An error occurred, please try again";
    }
  }

  // ignore: deprecated_member_use
  static String parseDioErrorMessage(DioException dioError) {
    String message = "";
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";

        break;
      case DioExceptionType.unknown:
        message = 'Kindly check your internet connection';
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = handleBadResponse(dioError);
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.connectionError:
        message = "Kindly check your internet connection";
        break;
      default:
        message = "Something went wrong";
        break;
    }

    debugPrint("the message is $message");
    return message;
  }
}

class Failure extends Equatable {
  final String? message;
  final dynamic data;

  const Failure({this.message, this.data});

  @override
  List<Object?> get props => [message, data];
}
