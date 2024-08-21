import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UtilComponent {
  static toastErr(String message) {
    Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      msg: message,
      backgroundColor: Colors.red[300],
      textColor: Colors.black,
      timeInSecForIosWeb: 3,
      webShowClose: true,
    );
  }

  static toastSuccess(String message) {
    Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      msg: message,
      backgroundColor: Colors.green[300],
      textColor: Colors.black,
      timeInSecForIosWeb: 3,
      webShowClose: true,
    );
  }

  static toastInfo(String message) {
    Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      msg: message,
      backgroundColor: Colors.grey,
      textColor: Colors.black,
      timeInSecForIosWeb: 3,
      webShowClose: true,
    );
  }

  static toastWarning(String message) {
    Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      msg: message,
      textColor: Colors.black,
      backgroundColor: Colors.yellow[300],
      timeInSecForIosWeb: 10,
      webShowClose: true,
    );
  }
}
