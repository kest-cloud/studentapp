import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:studentapp/features/add_student/data/datasource/localdatasource/local.dart';
import 'package:studentapp/features/add_student/presentation/notifier/students_notifier.dart';

class MockStudentDBLocalDatasource implements StudentDBLocalDatasource {
  @override
  Future<String?> getString({String? key}) async {
    // Return a mock JSON data string for testing
    final mockStudentData = [
      {
        "id": 1,
        "name": "Alice",
        "email": "alice@example.com",
        "enrolmentStatus": "Enrolled",
      },
      {
        "id": 2,
        "name": "Bob",
        "email": "bob@example.com",
        "enrolmentStatus": "Enrolled",
      },
    ];
    return jsonEncode(mockStudentData);
  }

  @override
  Future<void> clearToken() {
    // TODO: implement clearToken
    throw UnimplementedError();
  }

  @override
  Future<int> getInt({String? key, int defaultValue = 0}) {
    // TODO: implement getInt
    throw UnimplementedError();
  }

  @override
  Future<String?> getToken({String? token}) {
    // TODO: implement getToken
    throw UnimplementedError();
  }

  @override
  Future<bool> hasLoggedin() {
    // TODO: implement hasLoggedin
    throw UnimplementedError();
  }

  @override
  Future<void> saveInt({String? intName, int? value}) {
    // TODO: implement saveInt
    throw UnimplementedError();
  }

  @override
  Future<void> saveSession({String? tokenName, String? token}) {
    // TODO: implement saveSession
    throw UnimplementedError();
  }

  @override
  Future<void> saveString({String? stringName, String? value}) {
    // TODO: implement saveString
    throw UnimplementedError();
  }
}

void main() {
  late MockStudentDBLocalDatasource mockDatasource;
  late StudentNotifier studentNotifier;

  setUp(() {
    // Initialize the custom mock and the notifier before each test
    mockDatasource = MockStudentDBLocalDatasource();
    studentNotifier = StudentNotifier(studentDBLocalDatasource: mockDatasource);
  });

  test('getStudentProfiles returns a list of students', () async {
    // Act: Call getStudentProfiles
    final result = await studentNotifier.getStudentProfiles();

    // Expected data for assertion
    final expectedStudentData = [
      {
        "id": 1,
        "name": "Alice",
        "email": "alice@example.com",
        "enrolmentStatus": "Enrolled",
      },
      {
        "id": 2,
        "name": "Bob",
        "email": "bob@example.com",
        "enrolmentStatus": "Enrolled",
      },
    ];

    // Assert: Verify the result matches expected data
    expect(result, expectedStudentData);
  });
}
