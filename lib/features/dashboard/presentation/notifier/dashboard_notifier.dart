import 'dart:io';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:studentapp/core/utils/dims.dart';
import 'package:flutter/material.dart';
import 'package:studentapp/features/dashboard/data/domain/entity/student_from_api.dart';
import 'package:studentapp/features/dashboard/data/domain/repository/repo.dart';
import 'package:studentapp/shared/widgets/bottom_sheet.dart';

class DashboardNotifier extends ChangeNotifier {
  final DashBoardRepository _dashBoardRepository;

  DashboardNotifier({
    required DashBoardRepository dashBoardRepository,
  }) : _dashBoardRepository = dashBoardRepository;

  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  String? profilePhotoPath;
  String enrollmentStatus = 'Enrolled';
  static const String _studentsKey = 'students';

  set setEnrollmentStatus(String value) {
    enrollmentStatus = value;
    notifyListeners();
  }

  WithStates withStates = WithStates.idle;
  setWithStates(WithStates state) {
    withStates = state;
    notifyListeners();
  }

  List<dynamic>? students;
  set setStudentFromApiCall(List<dynamic>? value) {
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

  // Get student profiles from mock api data
  getStudentProfiles(context) async {
    setWithStates(WithStates.loading);
    notifyListeners();

    final data = await _dashBoardRepository.getStudentProfiles();
    data.fold((failure) {
      String? errorString = failure.message;
      Logger(errorString);
      setWithStates(WithStates.error);

      notifyListeners();
    }, (right) {
      setStudentFromApiCall =
          right.map((data) => StudentFromApiCall.fromJson(data)).toList();
      notifyListeners();
    });
  }

  Future<void> addStudent(BuildContext context, String name, String email,
      String enrolmentStatus, String? imagePath) async {
    var random = Random();
    int randomInt = random.nextInt(100);
    final newStudent = {
      "id": randomInt,
      "name": name,
      "email": email,
      "enrolmentStatus": enrolmentStatus,
      "imageUrl": imagePath, // Add the image path here
    };
    setWithStates(WithStates.loading);
    notifyListeners();

    final data = await _dashBoardRepository.addStudent(newStudent);
    data.fold((failure) {
      String? errorString = failure.message;
      Logger(errorString);
      setWithStates(WithStates.error);

      notifyListeners();
    }, (right) {
      setStudentFromApiCall =
          right.map((data) => StudentFromApiCall.fromJson(data)).toList();
      getStudentProfiles(context);
      notifyListeners();
    });

    const GeneralBottomSheet().showSuccessBottomSheet(
        context, "You have succesfully added a new student.");

    profilePhotoPath = null;
  }

  deleteStudentProfiles(context, id) async {
    setWithStates(WithStates.loading);
    notifyListeners();

    final data = await _dashBoardRepository.deleteStudentProfiles(id);
    data.fold((failure) {
      String? errorString = failure.message;
      Logger(errorString);
      setWithStates(WithStates.error);

      notifyListeners();
    }, (right) {
      setStudentFromApiCall =
          right.map((data) => StudentFromApiCall.fromJson(data)).toList();
      getStudentProfiles(context);
      notifyListeners();
    });
  }
}

enum WithStates {
  loading,
  success,
  error,
  idle;

  bool get isLoading => this == WithStates.loading;

  bool get isSuccess => this == WithStates.success;

  bool get isError => this == WithStates.error;

  bool get isIdle => this == WithStates.idle;
}
