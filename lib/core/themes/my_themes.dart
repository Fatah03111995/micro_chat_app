// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:micro_chat_app/core/themes/my_colors.dart';

extension CustomThemeData on ThemeData {
  Color get primaryColor =>
      brightness == Brightness.dark ? MyColors.blue1 : MyColors.blue1;
  Color get secondaryColor =>
      brightness == Brightness.dark ? MyColors.dark900 : MyColors.dark100;
  Color get textColor =>
      brightness == Brightness.dark ? Colors.white : MyColors.dark900;
  Color get secondaryTextColor =>
      brightness == Brightness.dark ? MyColors.dark900 : MyColors.dark100;
  Color get containerColor =>
      brightness == Brightness.dark ? MyColors.dark700 : Colors.white;
  Color get buttonColor => MyColors.blue1;
  Color get secondaryButtonColor =>
      brightness == Brightness.dark ? MyColors.dark700 : MyColors.dark100;
  Color get scaffoldBgColor =>
      brightness == Brightness.dark ? MyColors.dark900 : MyColors.blue4;
}
