import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studentapp/shared/styles/app_colors.dart';

class CustomCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const CustomCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358.w,
      height: 69.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.borderColor, width: 1.w),
        color: Colors.white,
      ),
      child: InkWell(
        splashColor: AppColors.primaryColor,
        onTap: onTap,
        child: Container(
          width: 358.0.w,
          height: 69.0.h,
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    icon,
                    size: 20.h,
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.rubik().fontFamily),
                        ),
                        Text(subtitle,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300,
                                fontFamily: GoogleFonts.rubik().fontFamily)),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 20.h,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      /* Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: ListTile(
            leading: Icon(
              icon,
              size: 20.h,
            ),
            title: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: GoogleFonts.rubik().fontFamily),
            ),
            subtitle: Text(subtitle,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                    fontFamily: GoogleFonts.rubik().fontFamily)),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 20.h,
            ),
            onTap: onTap,
          ),
        ),
      ), */
    );
  }
}
