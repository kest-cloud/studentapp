import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/app_colors.dart';

class ActionButton extends StatelessWidget {
  final IconData? icon;
  final String text;
  final VoidCallback? onPressed;

  const ActionButton(
      {super.key, this.icon, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r), // <-- Radius
        ),
      ),
      child: SizedBox(
        // Set width and height using screenutil
        height: 45.h,
        width: 296.w,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) // Display the icon only if it's provided
                Icon(
                  icon,
                  color: Colors.black,
                ),
              SizedBox(
                  width: icon != null
                      ? 8.0
                      : 0), // Add some space between icon and text
              Text(
                text,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
