import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studentapp/core/assets/assets.dart';
import 'package:studentapp/features/dashboard/presentation/views/navigation_bar.dart';

class GeneralBottomSheet extends StatefulWidget {
  const GeneralBottomSheet({super.key});

  @override
  State<StatefulWidget> createState() => _GeneralBottomSheet();

  void showSuccessBottomSheet(
    BuildContext context,
    String successMessage,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black87.withOpacity(0.8),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                // padding: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 15),
                      Container(
                        height: 80.h,
                        width: 80.h,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(successMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                          )),
                      const SizedBox(height: 20),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, NavPage.routeName);
                          },
                          child: const Text(
                            "Close",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showFailureBottomSheet(
    BuildContext context,
    String failureMessage,
  ) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black87.withOpacity(0.8),
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 3), () {
          // Navigator.pop(context);
        });

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 15),
                      Container(
                        height: 80.h,
                        width: 80.h,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(kGBL),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: Text(failureMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).then((v) {
      // Navigator.pop(context);
    });
  }
}

class _GeneralBottomSheet extends State<GeneralBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: const SizedBox(),
    );

    /*return  Material(
      child: ,
    );*/
  }
}
