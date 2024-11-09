import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studentapp/core/assets/assets.dart';
import 'package:studentapp/features/add_student/data/domain/entity/student_model.dart';

class StudentDetails extends StatefulWidget {
  final Student? student;
  const StudentDetails({super.key, required this.student});

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Student Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.blue,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 361.w,
                height: 300.h,
                child: widget.student?.imageUrl != ""
                    ? Image.file(
                        fit: BoxFit.cover, File(widget.student?.imageUrl ?? ""))
                    : Image.asset(
                        k1,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Student Name: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                "${widget.student?.name}" ?? " ",
                style: const TextStyle(fontSize: 20, color: Colors.black45),
              ),
              const SizedBox(height: 20),
              const Text(
                "Email: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                "${widget.student?.email}" ?? " ",
                style: TextStyle(fontSize: 20, color: Colors.black45),
              ),
              const SizedBox(height: 20),
              const Text(
                "Status: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                "${widget.student?.enrolmentStatus}" ?? " ",
                style: TextStyle(fontSize: 20, color: Colors.black45),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
