// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:studentapp/features/add_student/data/datasource/localdatasource/local.dart';
// import 'package:studentapp/features/add_student/presentation/notifier/students_notifier.dart';

// class MockStudentDBLocalDatasource extends Mock
//     implements StudentDBLocalDatasource {}

// void main() {
//   group('StudentNotifier', () {
//     late StudentNotifier studentNotifier;
//     late MockStudentDBLocalDatasource mockDatasource;

//     setUp(() {
//       const String _studentsKey = 'students';
//       mockDatasource = MockStudentDBLocalDatasource();
//       studentNotifier =
//           StudentNotifier(studentDBLocalDatasource: mockDatasource);

//       // Use thenAnswer to simulate async behavior of getString
//       when(mockDatasource.getString(key: _studentsKey)).thenAnswer(
//         (_) async =>
//             '[{"id":1,"name":"Alice Johnson","email":"alice.johnson@example.com","enrolmentStatus":"enrolled","imageUrl":"https://www.pinterest.com/pin/81346337013043294/"}, {"id":2,"name":"Bob Smith","email":"bob.smith@example.com","enrolmentStatus":"graduated","imageUrl":"https://www.pinterest.com/pin/81346337013043294/"}]',
//       );
//     });

//     test('should return the correct number of students', () async {
//       // Load the student profiles
//       await studentNotifier.loadInitialData();

//       // Fetch the student profiles
//       final students = await studentNotifier.getStudentProfiles();

//       // Verify the number of students
//       expect(students.length, 2); // We expect 2 students in the mock data
//     });
//   });
// }
