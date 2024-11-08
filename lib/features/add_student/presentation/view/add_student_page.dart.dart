import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:studentapp/core/di-manual/di_manual.dart';
import 'package:studentapp/features/add_student/presentation/notifier/students_notifier.dart';
import 'package:studentapp/shared/widgets/editables/custom_edit.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final caller = getIt<StudentNotifier>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: const Text(
          "Add Student",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<StudentNotifier>(
        builder: (context, value, _) {
          return Padding(
            padding: EdgeInsets.all(16.0.w), // Use ScreenUtil for padding
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFieldWidget(
                      inputType: TextInputType.name,
                      textStyle: const TextStyle(color: Colors.black),
                      controller: _firstNameController,
                      hintText: "enter your first name",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Name cannot be empty';
                        }
                        // final nameRegExp = RegExp(r'^[a-zA-Z]+$');
                        // if (!nameRegExp.hasMatch(value)) {
                        //   return 'Please enter a valid name (letters only)';
                        // }
                        return null; // No error
                      },
                      label: "First name",
                    ),
                    const SizedBox(height: 16),
                    CustomTextFieldWidget(
                      inputType: TextInputType.name,
                      textStyle: const TextStyle(color: Colors.black),
                      controller: _lastNameController,
                      hintText: "enter your last name",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Name cannot be empty';
                        }
                        // final nameRegExp = RegExp(r'^[a-zA-Z]+$');
                        // if (!nameRegExp.hasMatch(value)) {
                        //   return 'Please enter a valid first name (letters only)';
                        // }
                        return null; // No error
                      },
                      label: "Last name",
                    ),
                    const SizedBox(height: 16),
                    CustomTextFieldWidget(
                      inputType: TextInputType.emailAddress,
                      textStyle: const TextStyle(color: Colors.black),
                      controller: _emailController,
                      hintText: "enter email address",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email cannot be empty';
                        }
                        final emailRegExp =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegExp.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null; // No error
                      },
                      label: "Email Address",
                    ),
                    const SizedBox(height: 26),
                    // Enrollment Status Dropdown
                    DropdownButtonFormField<String>(
                      value: caller.enrollmentStatus,
                      items: ['Enrolled', 'Graduated', 'Alumni']
                          .map((status) => DropdownMenuItem(
                              value: status, child: Text(status)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          caller.enrollmentStatus = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Enrollment Status',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        caller.pickImage(context);
                      },
                      child: Container(
                        height: 200.h, // Use ScreenUtil for height
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.grey[200],
                        ),
                        child: value.profilePhotoPath != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.file(
                                  File(value.profilePhotoPath ?? ""),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              )
                            : const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 50,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Tap to pick photo',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        height: 60.h,
                        width: 200.w,
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            onTap: () {
                              caller.addStudent(
                                context,
                                _firstNameController.text.trim() +
                                    " " +
                                    _lastNameController.text.trim(),
                                _emailController.text.trim(),
                                caller.enrollmentStatus,
                                caller.profilePhotoPath,
                              );
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Ink(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Text('Submit',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
