import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micro_chat_app/core/themes/text_styles.dart';

class InputText extends StatelessWidget {
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String label;
  final String hint;
  final String? value;
  final bool isNotVisible;
  final Function(String newVal) onChanged;
  const InputText({
    super.key,
    required this.label,
    required this.hint,
    this.value,
    this.isNotVisible = false,
    this.suffixIcon,
    this.prefixIcon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      obscureText: isNotVisible,
      style: TextStyles.sm,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyles.s,
        hintText: hint,
        hintStyle: TextStyles.sm.copyWith(color: Colors.black38),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.w),
          borderSide: const BorderSide(color: Colors.black38),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.w),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
