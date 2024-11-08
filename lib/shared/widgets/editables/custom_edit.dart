// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:studentapp/core/utils/colors.dart';
import 'package:studentapp/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:snailmobile/utils/app_localizations.dart';
// import 'package:snailmobile/utils/screensize.dart';

// ignore: must_be_immutable
class CustomTextFieldWidget extends StatefulWidget {
  CustomTextFieldWidget({
    Key? key,
    this.initialValue,
    this.label,
    this.hintText,
    this.prefix,
    this.suffix,
    this.suffixAction,
    this.controller,
    this.inputType,
    this.textCapitalization,
    this.validator,
    this.obscureText = false,
    this.isEnabled = true,
    this.color = const Color(0xFF3E4A59),
    this.onChanged,
    this.fontSize,
    this.centerText = false,
    this.readOnly = false,
    this.errorMessage,
    this.onSubmitted,
    this.filled = false,
    this.fillColor,
    this.inputFormatters,
    this.hintStyle,
    this.textStyle,
    this.labelTextStyle,
    this.contentPadding,
    this.onTap,
    this.border,
    this.textInputAction,
    this.focusNode,
    this.keyboardType,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : super(key: key);

  // final AppLocalizations? tr;
  final String? initialValue;
  final String? label;
  final String? hintText;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final VoidCallback? suffixAction;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final TextCapitalization? textCapitalization;
  final FormFieldValidator? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? hintStyle;
  final EdgeInsets? contentPadding;
  final InputBorder? border;
  final FocusNode? focusNode;
  final AutovalidateMode autovalidateMode;
  @required
  bool obscureText;
  final bool? isEnabled;
  final color;
  final fontSize;
  final fillColor;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  @required
  bool centerText;
  @required
  bool readOnly = false;
  final String? errorMessage;
  final bool? filled;
  final TextStyle? textStyle;
  final TextStyle? labelTextStyle;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;

  @override
  _CustomTextFieldWidgetState createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  bool isTapped = false;
  String? error;
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: widget.centerText
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        widget.label == null
            ? Container()
            : Text(
                widget.label ?? '',
                style: widget.labelTextStyle ??
                    textTheme.bodySmall?.copyWith(
                      fontSize: widget.fontSize ?? 14.sp,
                      color: appColor.lightGrey3,
                    ),
              ),
        SizedBox(
          height: size.height * 0.01,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isTapped = !isTapped;
            });
            // print(isTapped);
          },
          child: TextFormField(
            enableSuggestions: false,

            textInputAction: widget.textInputAction,
            onTap: widget.onTap,
            focusNode: widget.focusNode,
            cursorColor: Theme.of(context).primaryColor,
            cursorHeight: 20.0.h,
            readOnly: widget.readOnly,
            controller: widget.controller,
            autocorrect: true,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.sentences,
            initialValue: widget.initialValue,
            obscureText: widget.obscureText,
            // onSaved: (val) => email = val,
            validator: widget.validator,
            onFieldSubmitted: widget.onSubmitted,
            onChanged: (value) {
              widget.onChanged == null ? null : widget.onChanged!(value);
              // OjawajuActivityTimerService().trackUserActivity();
            },

            style: widget.textStyle ??
                Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greyColor),
            keyboardType: widget.inputType,
            inputFormatters: widget.inputFormatters,

            decoration: InputDecoration(
              errorText: widget.errorMessage,
              fillColor: widget.fillColor ?? const Color(0xFFF2F2F2),
              //  errorText: userProvider.getMessage(),
              errorMaxLines:
                  Theme.of(context).inputDecorationTheme.errorMaxLines,
              filled: widget.filled,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: widget.contentPadding ??
                  Theme.of(context).inputDecorationTheme.contentPadding,
              // EdgeInsets.symmetric(
              //   horizontal: 8.0.w,
              //   vertical: 25.h,
              // ),
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  Theme.of(context).inputDecorationTheme.hintStyle,

              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: Theme.of(context)
                          .inputDecorationTheme
                          .focusedBorder
                          ?.borderSide ??
                      BorderSide()),
              enabledBorder: widget.border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.r),
                    borderSide: Theme.of(context)
                            .inputDecorationTheme
                            .enabledBorder
                            ?.borderSide ??
                        BorderSide(),
                  ),

              border: widget.border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.r),
                    borderSide: Theme.of(context)
                            .inputDecorationTheme
                            .border
                            ?.borderSide ??
                        BorderSide(),
                  ),
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  left: 12.0.w,
                  right: 10.0.w,
                ),
                child: widget.prefix,
              ),

              prefixIconConstraints: BoxConstraints(
                maxHeight: 20.0.h,
              ),
              suffixIconConstraints: BoxConstraints(
                  maxHeight: 40.0.h, minWidth: 60.w, maxWidth: 100.w),
              // suffixConstraints:
              suffixIcon: widget.suffix == null
                  ? null
                  : InkResponse(
                      onTap: widget.suffixAction,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 12.0.w,
                          right: 15.0.w,
                        ),
                        child: widget.suffix,
                      ),
                    ),
            ),
            autovalidateMode: widget.autovalidateMode,
          ),
        ),
      ],
    );
  }
}
