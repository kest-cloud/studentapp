import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentapp/core/utils/dims.dart';
import 'package:studentapp/features/add_student/data/datasource/localdatasource/local.dart';
import 'package:studentapp/features/add_student/data/domain/entity/student_model.dart';
import 'package:flutter/material.dart';
import 'package:studentapp/shared/widgets/bottom_sheet.dart';

class StudentNotifier extends ChangeNotifier {
  final StudentDBLocalDatasource _studentDBLocalDatasource;

  StudentNotifier({
    required StudentDBLocalDatasource studentDBLocalDatasource,
  }) : _studentDBLocalDatasource = studentDBLocalDatasource;

  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  String? profilePhotoPath;
  String enrollmentStatus = 'Enrolled';
  static const String _studentsKey = 'students';
  // Add a getter for _studentsKey
  String get studentsKey => _studentsKey;

  set setEnrollmentStatus(String value) {
    enrollmentStatus = value;
    notifyListeners();
  }

  List<Student>? students;
  set setStudentList(List<Student>? value) {
    students = value;
    notifyListeners();
  }

  Future<void> pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);

      // Check file size
      final fileSizeInBytes = await file.length();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024); // Convert to MB

      // Check file format
      final fileExtension = pickedFile.path.split('.').last.toLowerCase();
      const allowedFormats = ['jpg', 'jpeg', 'png'];

      if (fileSizeInMB <= 5 && allowedFormats.contains(fileExtension)) {
        profilePhotoPath = pickedFile.path;
        notifyListeners();
      } else {
        const GeneralBottomSheet().showFailureBottomSheet(context,
            "Please select an image in JPG or PNG format and ensure it is less than 5MB.");
      }
    }
  }

  // Load initial mock data from JSON file in assets if not already saved
  Future<void> loadInitialData() async {
    final data = await _studentDBLocalDatasource.getString(key: _studentsKey);
    if (data == null) {
      final jsonString =
          await rootBundle.loadString('lib/core/data/mock/student.json');
      await _studentDBLocalDatasource.saveString(
          stringName: _studentsKey, value: jsonString);
    }
  }

  // Get student profiles from the local data source
  Future<List<Map<String, dynamic>>> getStudentProfiles() async {
    final data = await _studentDBLocalDatasource.getString(key: _studentsKey);
    if (data != null) {
      return List<Map<String, dynamic>>.from(json.decode(data));
    }
    return [];
  }

  // Save student profiles to the local data source
  Future<void> _saveStudentProfiles(List<Map<String, dynamic>> students) async {
    final jsonString = json.encode(students);
    await _studentDBLocalDatasource.saveString(
        stringName: _studentsKey, value: jsonString);
  }

  // Add a new student with given details
  Future<void> addStudent(BuildContext context, String name, String email,
      String enrolmentStatus, String? imagePath) async {
    final students = await getStudentProfiles();

    final newStudent = {
      "id": students.isNotEmpty ? students.last['id'] + 1 : 1,
      "name": name,
      "email": email,
      "enrolmentStatus": enrolmentStatus,
      "imageUrl": imagePath, // Add the image path here
    };
    Logger(newStudent);

    students.add(newStudent);
    const GeneralBottomSheet().showSuccessBottomSheet(
        context, "You have succesfully added a new student.");
    await _saveStudentProfiles(students);
    profilePhotoPath = null;
  }

  // Delete a student by their ID
  Future<void> deleteStudent(
      BuildContext context, int? id, String? name) async {
    final students = await getStudentProfiles();
    students.removeWhere((student) => student['id'] == id);
    await _saveStudentProfiles(students);
    const GeneralBottomSheet().showSuccessBottomSheet(
        context, "You have succesfully deleted $name from Student List.");
    final res = await getStudentProfiles();
    setStudentList = res.map((data) => Student.fromJson(data)).toList();
  }

  // Update a student's information by ID
  Future<void> updateStudent(
      int id, String name, String email, String enrolmentStatus) async {
    final students = await getStudentProfiles();
    final index = students.indexWhere((student) => student['id'] == id);
    if (index != -1) {
      students[index] = {
        "id": id,
        "name": name,
        "email": email,
        "enrolmentStatus": enrolmentStatus,
      };
      await _saveStudentProfiles(students);
    }
  }

  Future<Map<String, dynamic>?> getStudentById(int id) async {
    final students = await getStudentProfiles();
    final student = students.firstWhere(
      (student) => student['id'] == id,
      orElse: () => {},
    );
    return student;
  }
}
