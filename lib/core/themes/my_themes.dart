// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:micro_chat_app/core/themes/my_colors.dart';

class DarkMode extends MyTheme {
  DarkMode()
      : super(
            primaryColor: MyColors.blue1,
            secondaryColor: MyColors.dark900,
            textColor: Colors.white,
            secondaryTextColor: MyColors.dark900,
            containerColor: MyColors.dark700,
            secondaryContainerColor: MyColors.blue4,
            buttonColor: MyColors.blue1,
            secondaryButtonColor: MyColors.dark700,
            scaffoldBgColor: MyColors.dark900);
}

class LightMode extends MyTheme {
  LightMode()
      : super(
          primaryColor: MyColors.blue1,
          secondaryColor: MyColors.dark100,
          textColor: MyColors.dark900,
          secondaryTextColor: MyColors.dark100,
          containerColor: Colors.white,
          secondaryContainerColor: MyColors.blue1,
          buttonColor: MyColors.blue1,
          secondaryButtonColor: MyColors.dark100,
          scaffoldBgColor: MyColors.blue4,
        );
}

abstract class MyTheme {
  final Color primaryColor;
  final Color secondaryColor;
  final Color textColor;
  final Color secondaryTextColor;
  final Color containerColor;
  final Color secondaryContainerColor;
  final Color buttonColor;
  final Color secondaryButtonColor;
  final Color scaffoldBgColor;
  const MyTheme({
    required this.primaryColor,
    required this.secondaryColor,
    required this.textColor,
    required this.secondaryTextColor,
    required this.containerColor,
    required this.secondaryContainerColor,
    required this.buttonColor,
    required this.secondaryButtonColor,
    required this.scaffoldBgColor,
  });
}
