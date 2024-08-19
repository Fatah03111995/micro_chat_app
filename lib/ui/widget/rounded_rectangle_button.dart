import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedRectangleButton extends StatelessWidget {
  final void Function() onTap;
  final Widget child;
  final Color color;
  const RoundedRectangleButton({
    super.key,
    required this.onTap,
    required this.child,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: color,
      ),
      child: TextButton(onPressed: onTap, child: child),
    );
  }
}
