// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micro_chat_app/core/themes/my_themes.dart';
import 'package:micro_chat_app/core/themes/text_styles.dart';

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function() onTap;

  const ProfileItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).textColor,
          ),
          SizedBox(width: 20.w),
          Text(
            title,
            style: TextStyles.m.copyWith(color: Theme.of(context).textColor),
          ),
        ],
      ),
    );
  }
}

class ItemProperties {
  final String title;
  final IconData icon;
  final void Function() onTap;
  const ItemProperties({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}
