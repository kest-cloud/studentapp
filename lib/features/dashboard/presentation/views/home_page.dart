import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/core/assets/assets.dart';
import 'package:studentapp/core/di-manual/di_manual.dart';
import 'package:studentapp/features/add_student/data/domain/entity/student_model.dart';
import 'package:studentapp/features/add_student/presentation/notifier/students_notifier.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:studentapp/features/add_student/presentation/view/student_details.dart';
import 'package:studentapp/features/dashboard/data/domain/entity/student_from_api.dart';
import 'package:studentapp/features/dashboard/presentation/notifier/dashboard_notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getStudentProfileList();
      getStudentProfileListFromAPI();
    });

    super.initState();
  }

  getStudentProfileListFromAPI() async {
    final caller = getIt<DashboardNotifier>();
    await caller.getStudentProfiles(context);
  }

  getStudentProfileList() async {
    final caller = getIt<StudentNotifier>();
    caller.loadInitialData();
    final res = await caller.getStudentProfiles();
    caller.setStudentList = res.map((data) => Student.fromJson(data)).toList();
  }

  // Function to show a confirmation dialog before deleting
  void _showDeleteConfirmationDialog(
      BuildContext context, int? index, Student? student) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: Text(
              'Do you want to delete this ${student?.name} from Student profile?'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            TextButton(
              onPressed: () {
                final caller = getIt<StudentNotifier>();
                Navigator.pop(context);
                caller.deleteStudent(context, index, student?.name);
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialogForAPi(
      BuildContext context, int? index, StudentFromApiCall? student) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: Text(
              'Do you want to delete this ${student?.name} from Student profile?'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            TextButton(
              onPressed: () {
                final caller = getIt<DashboardNotifier>();
                Navigator.pop(context);
                caller.deleteStudentProfiles(context, index);
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DashboardNotifier>(builder: (context, dashValue, _) {
        return Consumer<StudentNotifier>(builder: (context, value, _) {
          return DefaultTabController(
            length: 2, // Number of tabs
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                title: const Text(
                  "Student Profiles",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                automaticallyImplyLeading: false,
                scrolledUnderElevation: 0,
                bottom: const TabBar(
                  indicatorWeight: 5,
                  indicatorColor: Colors.blue,
                  dividerColor: Colors.blueGrey,
                  labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                  labelColor: Color.fromARGB(255, 4, 51, 87),
                  tabs: [
                    Tab(
                      text: "Student List(Local)",
                    ),
                    Tab(text: "Student List(API)"),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  RefreshIndicator(
                    color: Colors.blue,
                    backgroundColor: Colors.white,
                    onRefresh: () async {
                      getStudentProfileList();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 20),
                      child: ListView.separated(
                        itemCount: value.students?.length ?? 0,
                        itemBuilder: (context, index) {
                          var reversedIndex =
                              value.students!.length - 1 - index;
                          final student = value.students?[reversedIndex];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        StudentDetails(student: student)),
                              );
                            },
                            borderRadius: BorderRadius.circular(20.r),
                            child: Dismissible(
                              key: Key(student!.id.toString()),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                _showDeleteConfirmationDialog(
                                    context, student.id, student);
                              },
                              child: Container(
                                width: 300.w,
                                padding: EdgeInsets.all(18.w),
                                decoration: BoxDecoration(
                                  color:
                                      Colors.white, // Set the background color
                                  border: Border.all(
                                    color: Colors.blue, // Border color
                                    width: 2, // Border width
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      12), // Rounded corners
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.2), // Shadow color
                                      spreadRadius:
                                          2, // Spread the shadow a bit
                                      blurRadius: 5, // Make the shadow blurry
                                      offset: const Offset(0,
                                          4), // Shadow offset (horizontal, vertical)
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    index.isEven
                                        ? Container(
                                            width: 100,
                                            height: 100,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: ClipOval(
                                              child: student.imageUrl != ""
                                                  ? Image.file(
                                                      fit: BoxFit.cover,
                                                      File(student.imageUrl!))
                                                  : Image.asset(
                                                      k1,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          )
                                            .animate()
                                            .fadeIn(duration: 650.ms)
                                            .then(delay: 500.ms)
                                            .slideX(begin: -2)
                                        : Container(
                                            width: 100,
                                            height: 100,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: ClipOval(
                                              child: student.imageUrl != ""
                                                  ? Image.file(
                                                      fit: BoxFit.cover,
                                                      File(student.imageUrl!))
                                                  : Image.asset(
                                                      k1,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          )
                                            .animate()
                                            .fadeIn(duration: 651.ms)
                                            .slideX(begin: 2),
                                    SizedBox(width: 20.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 200.w,
                                          child: Text(
                                            student.name ?? "",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200.w,
                                          child: Text(
                                            student.email ?? "",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Text(
                                          student.enrolmentStatus ?? "",
                                          style: TextStyle(
                                            color: student.enrolmentStatus
                                                        ?.toLowerCase()
                                                        .compareTo("enrolled"
                                                            .toLowerCase()) ==
                                                    0
                                                ? Colors.orange
                                                : student.enrolmentStatus
                                                            ?.toLowerCase()
                                                            .compareTo("graduated"
                                                                .toLowerCase()) ==
                                                        0
                                                    ? Colors.green
                                                    : Colors.teal,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 20.h,
                          );
                        },
                      ),
                    ),
                  ),

                  //Api Part
                  RefreshIndicator(
                    color: Colors.blue,
                    backgroundColor: Colors.white,
                    onRefresh: () async {
                      getStudentProfileListFromAPI();
                    },
                    child: dashValue.students?.length == 0
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 20),
                            child: ListView.separated(
                              itemCount: dashValue.students?.length ?? 0,
                              itemBuilder: (context, index) {
                                var reversedIndex =
                                    dashValue.students!.length - 1 - index;
                                final student =
                                    dashValue.students?[reversedIndex];
                                return InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           StudentDetails(student: studen)),
                                    // );
                                  },
                                  borderRadius: BorderRadius.circular(20.r),
                                  child: Dismissible(
                                    key: Key(student!.id.toString()),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) {
                                      //if I were to impletment a delete action. would be this.
                                      // _showDeleteConfirmationDialogForAPi(
                                      //     context, student.id, student);
                                    },
                                    child: Container(
                                      width: 300.w,
                                      padding: EdgeInsets.all(18.w),
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .white, // Set the background color
                                        border: Border.all(
                                          color: Colors.blue, // Border color
                                          width: 2, // Border width
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            12), // Rounded corners
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                                0.2), // Shadow color
                                            spreadRadius:
                                                2, // Spread the shadow a bit
                                            blurRadius:
                                                5, // Make the shadow blurry
                                            offset: const Offset(0,
                                                4), // Shadow offset (horizontal, vertical)
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          index.isEven
                                              ? Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: ClipOval(
                                                    child: student.imageUrl !=
                                                            ""
                                                        ? Image.file(
                                                            fit: BoxFit.cover,
                                                            File(student
                                                                .imageUrl!))
                                                        : Image.asset(
                                                            k1,
                                                            fit: BoxFit.cover,
                                                          ),
                                                  ),
                                                )
                                                  .animate()
                                                  .fadeIn(duration: 650.ms)
                                                  .then(delay: 500.ms)
                                                  .slideX(begin: -2)
                                              : Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: ClipOval(
                                                    child: student.imageUrl !=
                                                            ""
                                                        ? Image.file(
                                                            fit: BoxFit.cover,
                                                            File(student
                                                                .imageUrl!))
                                                        : Image.asset(
                                                            k1,
                                                            fit: BoxFit.cover,
                                                          ),
                                                  ),
                                                )
                                                  .animate()
                                                  .fadeIn(duration: 651.ms)
                                                  .slideX(begin: 2),
                                          SizedBox(width: 20.w),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 200.w,
                                                child: Text(
                                                  student.name ?? "",
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 200.w,
                                                child: Text(
                                                  student.email ?? "",
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Text(
                                                student.enrolmentStatus ?? "",
                                                style: TextStyle(
                                                    color: student
                                                                .enrolmentStatus
                                                                ?.toLowerCase()
                                                                .compareTo(
                                                                    "enrolled"
                                                                        .toLowerCase()) ==
                                                            0
                                                        ? Colors.orange
                                                        : student.enrolmentStatus
                                                                    ?.toLowerCase()
                                                                    .compareTo(
                                                                        "graduated"
                                                                            .toLowerCase()) ==
                                                                0
                                                            ? Colors.green
                                                            : Colors.teal,
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 20.h,
                                );
                              },
                            ),
                          )
                        : const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.people,
                                      size: 40,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                        "You currently do not have any student"),
                                  ],
                                ),
                              )
                            ],
                          ),
                  ),
                  // Second tab content
                ],
              ),
            ),
          );
        });
      }),
    );
  }
}
