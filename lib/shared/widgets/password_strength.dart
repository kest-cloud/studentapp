import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordStrengthIndicator extends StatefulWidget {
  final String password;
  final VoidCallback? onRequirementsMet;

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
    this.onRequirementsMet,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PasswordStrengthIndicatorState createState() =>
      _PasswordStrengthIndicatorState();
}

class _PasswordStrengthIndicatorState extends State<PasswordStrengthIndicator> {
  @override
  void didUpdateWidget(covariant PasswordStrengthIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Schedule _checkRequirements to be called after the build is complete
    Future.microtask(_checkRequirements);
  }

  void _checkRequirements() {
    bool meetsAllRequirements = true;

    // Check each requirement
    meetsAllRequirements = widget.password.length >= 8 &&
        _containsUppercase(widget.password) &&
        _containsNumber(widget.password) &&
        _containsSpecialCharacter(widget.password);

    setState(() {});

    // Trigger the callback if provided
    if (meetsAllRequirements && widget.onRequirementsMet != null) {
      widget.onRequirementsMet!();
    } else {
      setState(() {
        meetsAllRequirements = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRequirement(
            'Minimum of 8 characters', widget.password.length >= 8),
        _buildRequirement(
            'One UPPERCASE character', _containsUppercase(widget.password)),
        _buildRequirement('One number', _containsNumber(widget.password)),
        _buildRequirement('One unique character (~!@#\$%^&*_+)',
            _containsSpecialCharacter(widget.password)),
      ],
    );
  }

  Widget _buildRequirement(String text, bool isFulfilled) {
    return Row(
      children: [
        Icon(
          isFulfilled ? Icons.check_circle : Icons.circle_rounded,
          color: isFulfilled ? Colors.green : Colors.grey,
          size: 10.w,
        ),
        SizedBox(width: 8.h),
        Text(
          text,
          style: TextStyle(
              color: isFulfilled ? Colors.black : Colors.grey,
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              fontFamily: GoogleFonts.rubik().fontFamily),
        ),
      ],
    );
  }

  bool _containsUppercase(String value) {
    return RegExp(r'[A-Z]').hasMatch(value);
  }

  bool _containsNumber(String value) {
    return RegExp(r'\d').hasMatch(value);
  }

  bool _containsSpecialCharacter(String value) {
    return RegExp(r'[~!@#\$%^&*_+]').hasMatch(value);
  }
}
