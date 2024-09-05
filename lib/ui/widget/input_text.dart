import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micro_chat_app/core/themes/my_themes.dart';
import 'package:micro_chat_app/core/themes/text_styles.dart';

class InputText extends StatelessWidget {
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? label;
  final String hint;
  final String? value;
  final bool isNotVisible;
  final Function(String newVal) onChanged;
  final TextEditingController? controller;
  const InputText({
    super.key,
    this.label,
    required this.hint,
    this.value,
    this.isNotVisible = false,
    this.suffixIcon,
    this.prefixIcon,
    required this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: isNotVisible,
      style: TextStyles.sm.copyWith(color: Theme.of(context).textColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyles.s.copyWith(color: Theme.of(context).textColor),
        hintText: hint,
        hintStyle: TextStyles.sm
            .copyWith(color: Theme.of(context).textColor.withOpacity(0.5)),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.w),
          borderSide:
              BorderSide(color: Theme.of(context).textColor.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.w),
          borderSide: BorderSide(color: Theme.of(context).textColor),
        ),
      ),
    );
  }
}
